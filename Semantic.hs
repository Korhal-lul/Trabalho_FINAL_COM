{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}

module Semantic where

import DataTree
import Control.Monad.Writer
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad (zipWithM, foldM, unless)
import Data.Maybe (fromMaybe)
import qualified Data.Map as Map
import DataTree (ExprL)


type Env = Map.Map Id Tipo
type EnvFun = Map.Map Id ([Var], Tipo)

type Analisador a = ExceptT String (Writer [String]) a

coercao :: (Expr -> Expr -> Expr) -> EnvFun -> Env -> Expr -> Expr -> Tipo -> Tipo -> Analisador (Tipo, Expr)
coercao op envFun env e1 e2 t1 t2
  | t1 == t2 = return (t1, op e1 e2)
  | t1 == T_Int && t2 == T_Double = return (T_Double, op (IntDouble e1) e2)
  | t1 == T_Double && t2 == T_Int = do
      tell ["Advertencia: conversao de double para int"]
      return (T_Int, op e1 (DoubleInt e2))
  | otherwise = throwError $ "Erro de tipos na expressao: " ++ show (op e1 e2) ++
                             ", com tipos " ++ show t1 ++ " e " ++ show t2

tExpr :: EnvFun -> Env -> Expr -> Analisador (Tipo, Expr)
tExpr envFun env (Const (CInt i)) = return (T_Int, Const (CInt i)) -- você pode retornar o valor original se quiser
tExpr envFun env (Const (CDouble d)) = return (T_Double, Const (CDouble d))
tExpr _ _ (Lit s) = return (T_Str, Lit s)
tExpr envFun env (IdVar x) = case Map.lookup x env of
    Just t -> return (t, IdVar x)
    Nothing -> throwError $ "Variavel nao declarada: " ++ x
tExpr envFun env (Add e1 e2) = do
    (t1, e1') <- tExpr envFun env e1
    (t2, e2') <- tExpr envFun env e2
    coercao Add envFun env e1' e2' t1 t2
tExpr envFun env (Sub e1 e2) = do
    (t1, e1') <- tExpr envFun env e1
    (t2, e2') <- tExpr envFun env e2
    coercao Sub envFun env e1' e2' t1 t2
tExpr envFun env (Mul e1 e2) = do
    (t1, e1') <- tExpr envFun env e1
    (t2, e2') <- tExpr envFun env e2
    coercao Mul envFun env e1' e2' t1 t2
tExpr envFun env (Div e1 e2) = do
    (t1, e1') <- tExpr envFun env e1
    (t2, e2') <- tExpr envFun env e2
    coercao Div envFun env e1' e2' t1 t2
tExpr envFun env (IntDouble e) = return (T_Double, IntDouble e)
tExpr envFun env (DoubleInt e) = return (T_Int, DoubleInt e)

tExpr envFun env (Chamada nome args) = do
  case Map.lookup nome envFun of
    Nothing -> throwError $ "Funcao nao declarada: " ++ nome
    Just (params, tipoRet)
      | tipoRet == T_Void ->
          throwError $ "A função " ++ nome ++ " eh void e não pode ser usada em expressoes."
      | length params /= length args ->
          throwError $ "Nemero incorreto de argumentos na chamada da funcao " ++ nome
      | otherwise -> do
          args' <- zipWithM (verificaParam envFun env) params args
          return (tipoRet, Chamada nome args')


tExprR :: EnvFun -> Env -> ExprR -> Analisador (ExprR)
tExprR envFun env (Req e1 e2)  = tRel envFun env Req e1 e2
tExprR envFun env (Rdif e1 e2) = tRel envFun env Rdif e1 e2
tExprR envFun env (Rlt e1 e2)  = tRel envFun env Rlt e1 e2
tExprR envFun env (Rgt e1 e2)  = tRel envFun env Rgt e1 e2
tExprR envFun env (Rle e1 e2)  = tRel envFun env Rle e1 e2
tExprR envFun env (Rge e1 e2)  = tRel envFun env Rge e1 e2

tRel :: EnvFun -> Env -> (Expr -> Expr -> ExprR) -> Expr -> Expr -> Analisador ExprR
tRel envFun env constr e1 e2 = do
  (t1, e1') <- tExpr envFun env e1
  (t2, e2') <- tExpr envFun env e2
  case (t1, t2) of
    (T_Str, T_Str) -> return (constr e1' e2')
    (T_Int, T_Double)    -> return (constr (IntDouble e1') e2')
    (T_Double, T_Int)    -> return (constr e1' (IntDouble e2'))
    (T_Int, T_Int)       -> return (constr e1' e2')
    (T_Double, T_Double) -> return (constr e1' e2')
    _ -> throwError $ "Erro de tipos em expressao relacional: " ++ show (constr e1 e2) ++
                      " com tipos " ++ show t1 ++ " e " ++ show t2

tExprL :: EnvFun -> Env -> ExprL -> Analisador ExprL
tExprL envFun env (And e1 e2) = do
  e1' <- tExprL envFun env e1
  e2' <- tExprL envFun env e2
  return (And e1' e2')

tExprL envFun env (Or e1 e2) = do
  e1' <- tExprL envFun env e1
  e2' <- tExprL envFun env e2
  return (Or e1' e2')

tExprL envFun env (Not e) = do
  e' <- tExprL envFun env e
  return (Not e')

tExprL envFun env (Rel r) = do
  r' <- tExprR envFun env r
  return (Rel r')

verificaParam :: EnvFun -> Env -> Var -> Expr -> Analisador Expr
verificaParam envFun env (nome :#: (tParam, _)) expr = do
  (tArg, expr') <- tExpr envFun env expr
  case (tParam, tArg) of
    _ | tParam == tArg -> return expr'
    (T_Double, T_Int) -> return (IntDouble expr')
    (T_Int, T_Double) -> do
      tell ["Advertencia: parametro double passado para argumento int"]
      return (DoubleInt expr')
    _ -> throwError $ "Tipo incompativel em parametro: esperado " ++ show tParam ++ ", mas recebeu " ++ show tArg

tCmd :: Tipo -> EnvFun -> Env -> Comando -> Analisador Comando

tCmd tipoRet envFun env (Atrib x e) = do
  (tExpr, e') <- tExpr envFun env e
  case Map.lookup x env of
    Nothing -> throwError $ "Variavel nao declarada: " ++ x
    Just tVar
      | tVar == tExpr -> return (Atrib x e')
      | tVar == T_Double && tExpr == T_Int -> return (Atrib x (IntDouble e'))
      | tVar == T_Int && tExpr == T_Double -> do
          tell ["Advertancia: atribuicao double em variavel int"]
          return (Atrib x (DoubleInt e'))
      | otherwise -> throwError $ "Atribuicao incompativel: " ++ x ++
                                  " do tipo " ++ show tVar ++
                                  " com expressao do tipo " ++ show tExpr

tCmd tipoRet envFun env (For init cond inc bloco) = do
  init' <- tCmd tipoRet envFun env init
  cond' <- tExprL envFun env cond
  inc' <- tCmd tipoRet envFun env inc
  bloco' <- tBloco tipoRet envFun env bloco
  return (For init' cond inc' bloco')

tCmd tipoRet envFun env (If cond b1 b2) = do
  _ <- tExprL envFun env cond
  b1' <- tBloco tipoRet envFun env b1
  b2' <- tBloco tipoRet envFun env b2
  return (If cond b1' b2')

tCmd tipoRet envFun env (While cond b) = do
  _ <- tExprL envFun env cond
  b' <- tBloco tipoRet envFun env b
  return (While cond b')

tCmd tipoRet envFun env (Ret Nothing)
  | tipoRet == T_Void = return (Ret Nothing)
  | otherwise = throwError $ "A funcao espera retorno do tipo " ++ show tipoRet ++ ", mas nenhum valor foi retornado."

tCmd tipoRet envFun env (Ret (Just e)) = do
  (t, e') <- tExpr envFun env e
  case (tipoRet, t) of
    _ | tipoRet == t -> return (Ret (Just e'))
    (T_Double, T_Int) -> return (Ret (Just (IntDouble e')))
    (T_Int, T_Double) -> do
      tell ["Advertencia: retorno double em funcao int"]
      return (Ret (Just (DoubleInt e')))
    _ -> throwError $ "Tipo de retorno incompativel: funcao espera " ++ show tipoRet ++ ", mas foi retornado " ++ show t

tCmd tipoRet envFun env (Imp e) = do
  (_, e') <- tExpr envFun env e
  return (Imp e')

tCmd tipoRet envFun env (Leitura x) = case Map.lookup x env of
  Nothing -> throwError $ "Leitura de variavel nao declarada: " ++ x
  Just _  -> return (Leitura x)

tCmd tipoRet envFun env (Proc nome args) = do
  case Map.lookup nome envFun of
    Nothing -> throwError $ "Procedimento nao declarado: " ++ nome
    Just (params, T_Void) ->
      if length params /= length args
        then throwError $ "Na+umero de argumentos incorreto na chamada de " ++ nome
        else do
          args' <- zipWithM (verificaParam envFun env) params args
          return (Proc nome args')
    Just (_, tipoRetFunc) ->
      throwError $ "Procedimento " ++ nome ++ " retorna valor (" ++ show tipoRetFunc ++ ") mas foi usado como comando."

verificaDuplicatasVars :: [Var] -> Analisador ()
verificaDuplicatasVars vars = do
  let nomes = [nome | nome :#: _ <- vars]
      duplicadas = nomesDuplicados nomes
  unless (null duplicadas) $
    throwError $ "Variaveis duplicadas: " ++ show duplicadas

verificaDuplicatasFuncoes :: [Funcao] -> Analisador ()
verificaDuplicatasFuncoes funcoes = do
  let nomes = [nome | nome :->: _ <- funcoes]
      duplicadas = nomesDuplicados nomes
  unless (null duplicadas) $
    throwError $ "Funcoes duplicadas: " ++ show duplicadas

nomesDuplicados :: Ord a => [a] -> [a]
nomesDuplicados xs =
  Map.keys $ Map.filter (>1) $ Map.fromListWith (+) [(x, 1 :: Int) | x <- xs]

tBloco :: Tipo -> EnvFun -> Env -> Bloco -> Analisador Bloco
tBloco tipo envFun env comandos = coletarErros (map (tCmd tipo envFun env) comandos)

verificaFuncao :: EnvFun -> Funcao -> ([Var], Bloco) -> Analisador (Id, [Var], Bloco)
verificaFuncao envFun (nome :->: (params, tipoRet)) (decls, bloco) = do
  verificaDuplicatasVars (params ++ decls)
  let env = Map.fromList [(x, t) | x :#: (t, _) <- params ++ decls]
  bloco' <- tBloco tipoRet envFun env bloco
  return (nome, decls, bloco')

coletarErros :: [Analisador a] -> Analisador [a]
coletarErros = fmap reverse . foldM f []
  where
    f acc analise = catchError
      (do x <- analise; return (x:acc))
      (\err -> tell [err] >> return acc)

verificaPrograma (Prog funcoes corpos vars bloco) =
  let env = Map.fromList [(x, t) | x :#: (t, _) <- vars]
      envFun = Map.fromList [(nome, (params, tipo)) | (nome :->: (params, tipo)) <- funcoes]
      tipoRet = T_Void
      corposSemId = [(decls, bloco) | (_, decls, bloco) <- corpos]
  in case runWriter (runExceptT $ do
         verificaDuplicatasVars vars
         verificaDuplicatasFuncoes funcoes
         corpos' <- zipWithM (verificaFuncao envFun) funcoes corposSemId
         bloco'  <- tBloco tipoRet envFun env bloco
         return (corpos', bloco')) of
       (Left err, warns) -> Left (unlines (err : warns))
       (Right (corpos', bloco'), warns) ->
         Right (Prog funcoes corpos' vars bloco', warns)
