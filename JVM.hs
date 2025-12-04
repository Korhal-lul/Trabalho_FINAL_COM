-- JVM.hs (versão final corrigida: double real, arrays, pow, prints, locais)
module JVM where

import DataTree
import Data.Maybe (fromJust, fromMaybe)
import qualified Data.Map as Map
import Semantic (Env, EnvFun)
import Control.Monad.State
import Control.Monad (when, forM)

type EnvJVM = Map.Map Id (Tipo, Int)

novoLabel :: State Int String
novoLabel = do { n <- get; put (n+1); return ("l" ++ show n) }

genCab :: Id -> String
genCab nome = ".class public " ++ nome ++
              "\n.super java/lang/Object\n\n.method public <init>()V\n\taload_0\n\tinvokenonvirtual java/lang/Object/<init>()V\n\treturn\n.end method\n\n"

genMainCab :: Int -> Int -> String
genMainCab s l = ".method public static main([Ljava/lang/String;)V" ++
                 "\n\t.limit stack " ++ show s ++
                 "\n\t.limit locals " ++ show l ++ "\n\n"

------------------------------------------------------------------------
-- EXPRESSÕES E RELACIONAIS
------------------------------------------------------------------------

genExprL :: Env -> EnvJVM -> Id -> String -> String -> ExprL -> State Int String
genExprL c tab fun v f (And e1 e2) = do
  l1 <- novoLabel
  e1' <- genExprL c tab fun l1 f e1
  e2' <- genExprL c tab fun v f e2
  return (e1' ++ l1 ++ ":\n" ++ e2')
genExprL c tab fun v f (Or e1 e2) = do
  l1 <- novoLabel
  e1' <- genExprL c tab fun v l1 e1
  e2' <- genExprL c tab fun v f e2
  return (e1' ++ l1 ++ ":\n" ++ e2')
genExprL c tab fun v f (Not e) = genExprL c tab fun f v e
genExprL c tab fun v f (Rel r) = genExprR c tab fun v f r

genExprR :: Env -> EnvJVM -> Id -> String -> String -> ExprR -> State Int String
genExprR c tab fun v f (Req e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "eq" ++ "\tgoto " ++ f ++ "\n")
genExprR c tab fun v f (Rdif e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "ne" ++ "\tgoto " ++ f ++ "\n")
genExprR c tab fun v f (Rlt e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "lt" ++ "\tgoto " ++ f ++ "\n")
genExprR c tab fun v f (Rgt e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "gt" ++ "\tgoto " ++ f ++ "\n")
genExprR c tab fun v f (Rle e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "le" ++ "\tgoto " ++ f ++ "\n")
genExprR c tab fun v f (Rge e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1
  (t2, e2') <- genExpr c tab fun e2
  return (e1' ++ e2' ++ genRel t1 t2 v "ge" ++ "\tgoto " ++ f ++ "\n")

-- retorna (Tipo, código)
genExpr :: Env -> EnvJVM -> Id -> Expr -> State Int (Tipo, String)
genExpr _ _ _ (Const (CInt i))
  | i >= -1 && i <= 5 = return (T_Int, "\ticonst_" ++ show i ++ "\n")
  | otherwise         = return (T_Int, "\tldc " ++ show i ++ "\n")
genExpr _ _ _ (Const (CDouble d)) = return (T_Double, "\tldc2_w " ++ show d ++ "\n")

genExpr _ tab _ (IdVar x) =
  case Map.lookup x tab of
    Just (tipo, idx) ->
      case tipo of
        T_Int    -> return (T_Int, "\tiload " ++ show idx ++ "\n")
        T_Double -> return (T_Double, "\tdload " ++ show idx ++ "\n")
        T_Arr _ _-> return (T_Arr T_Int 0, "\taload " ++ show idx ++ "\n")
        _        -> error ("Tipo não suportado para variável " ++ x)
    Nothing -> error ("Variável " ++ x ++ " não encontrada")

genExpr c tab f (Add e1 e2) = binOp c tab f e1 e2 "add"
genExpr c tab f (Sub e1 e2) = binOp c tab f e1 e2 "sub"
genExpr c tab f (Mul e1 e2) = binOp c tab f e1 e2 "mul"
genExpr c tab f (Div e1 e2) = binOp c tab f e1 e2 "div"

genExpr c tab f (Mod e1 e2) = do
  (t1, c1) <- genExpr c tab f e1
  (t2, c2) <- genExpr c tab f e2
  case (t1, t2) of
    (T_Int, T_Int) -> return (T_Int, c1 ++ c2 ++ genOp T_Int "rem")
    (T_Double, T_Double) -> return (T_Double, c1 ++ c2 ++ genOp T_Double "rem")
    _ -> error $ "Operador % nao compatível com tipos: "
                 ++ show t1 ++ " e " ++ show t2


-- POW: produza doubles e, por compatibilidade com seu analisador atual, retorne Int (com d2i)
genExpr c tab fun (Exp e1 e2) = do
  (t1, c1) <- genExpr c tab fun e1
  (t2, c2) <- genExpr c tab fun e2
  let d1 = if t1 == T_Int then c1 ++ "\ti2d\n" else c1
      d2 = if t2 == T_Int then c2 ++ "\ti2d\n" else c2
  return (T_Int, d1 ++ d2 ++ "\tinvokestatic java/lang/Math/pow(DD)D\n\td2i\n")


genExpr c tab fun (Chamada nome args) = do
  argumentos <- mapM (genExpr c tab fun) args
  let codigoArgs = concatMap snd argumentos
      tipos = map fst argumentos
      tipoRet = fromMaybe (error $ "Função " ++ nome ++ " não declarada") (Map.lookup nome c)
      tipoJ t = case t of
        T_Int    -> "I"
        T_Double -> "D"
        T_Void   -> "V"
      chamada = "\tinvokestatic " ++ nome ++ "(" ++ concatMap tipoJ tipos ++ ")" ++ tipoJ tipoRet ++ "\n"
  return (tipoRet, codigoArgs ++ chamada)

genExpr c tab fun (DoubleInt e) = do
  (t, code) <- genExpr c tab fun e
  case t of
    T_Double -> return (T_Int, code ++ "\td2i\n")
    _ -> error "Esperado tipo Double na conversão DoubleInt"
genExpr c tab fun (IntDouble e) = do
  (t, code) <- genExpr c tab fun e
  case t of
    T_Int -> return (T_Double, code ++ "\ti2d\n")
    _ -> error "Esperado tipo Int na conversão IntDouble"

-- ArrAccess: aload arrayref; <idx>; iaload|daload
genExpr c tab fun (ArrAccess nome idxExpr) =
  case Map.lookup nome tab of
    Nothing -> error ("Array " ++ nome ++ " não encontrado")
    Just (T_Arr elemType _, idx) -> do
      (tIdx, idxCode) <- genExpr c tab fun idxExpr
      when (tIdx /= T_Int) $
        error ("Índice do array " ++ nome ++ " deve ser int")
      let loadInstr = case elemType of
                        T_Int    -> "\tiaload\n"
                        T_Double -> "\tdaload\n"
                        _ -> error "Tipo de array não suportado"
      return (elemType, "\taload " ++ show idx ++ "\n" ++ idxCode ++ loadInstr)
    Just _ -> error (nome ++ " não é array")

genExpr _ _ _ expr = error ("Expressão não suportada em genExpr: " ++ show expr)

binOp :: Env -> EnvJVM -> Id -> Expr -> Expr -> String -> State Int (Tipo, String)
binOp c tab f e1 e2 op = do
  (t1, c1) <- genExpr c tab f e1
  (t2, c2) <- genExpr c tab f e2
  case (t1, t2) of
    (T_Int, T_Int)     -> return (T_Int, c1 ++ c2 ++ genOp T_Int op)
    (T_Double, T_Double)-> return (T_Double, c1 ++ c2 ++ genOp T_Double op)
    (T_Int, T_Double)  -> return (T_Double, c1 ++ "\ti2d\n" ++ c2 ++ genOp T_Double op)
    (T_Double, T_Int)  -> return (T_Double, c1 ++ c2 ++ "\ti2d\n" ++ genOp T_Double op)
    _ -> error $ "Operador " ++ op ++ " não compatível com tipos: " ++ show t1 ++ " e " ++ show t2

genOp :: Tipo -> String -> String
genOp T_Int op = "\ti" ++ op ++ "\n"
genOp T_Double op = "\td" ++ op ++ "\n"

genRel :: Tipo -> Tipo -> String -> String -> String
genRel T_Int T_Int label op = "\tif_icmp" ++ op ++ " " ++ label ++ "\n"
genRel T_Double T_Double label op =
  "\tdcmpl\n" ++ "\tif" ++ op ++ " " ++ label ++ "\n"
genRel t1 t2 _ _ = error $ "Comparação não suportada entre tipos: " ++ show t1 ++ " e " ++ show t2

------------------------------------------------------------------------
-- COMANDOS
------------------------------------------------------------------------

genCmd :: Env -> EnvJVM -> Id -> Comando -> State Int String

genCmd c tab fun (Atrib x e) = do
  (t, code) <- genExpr c tab fun e
  case Map.lookup x tab of
    Just (_, idx) -> return (code ++ genStore t idx)
    Nothing -> error $ "Variável não encontrada: " ++ x
  where
    genStore T_Int i = "\tistore " ++ show i ++ "\n"
    genStore T_Double i = "\tdstore " ++ show i ++ "\n"
    genStore (T_Arr _ _) i = "\tastore " ++ show i ++ "\n"
    genStore _ _ = error "Tipo não suportado no store"

genCmd c tab fun (While cond bloco) = do
  li <- novoLabel
  lv <- novoLabel
  lf <- novoLabel
  e' <- genExprL c tab fun lv lf cond
  b' <- genBloco c tab fun bloco
  return (li ++ ":\n" ++ e' ++ lv ++ ":\n" ++ b' ++ "\tgoto " ++ li ++ "\n" ++ lf ++ ":\n")

genCmd c tab fun (If cond b1 b2) = do
  lv <- novoLabel
  lf <- novoLabel
  e' <- genExprL c tab fun lv lf cond
  then' <- genBloco c tab fun b1
  else' <- genBloco c tab fun b2
  return (e' ++ lv ++ ":\n" ++ then' ++ "\tgoto " ++ lf ++ "\n" ++ lf ++ ":\n" ++ else')

-- print: getstatic ; <expr-code> ; invokevirtual print(...)
genCmd c tab fun (Imp e) = do
  (t, code) <- genExpr c tab fun e
  let printCode = case t of
        T_Int    -> "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ code ++ "\tinvokevirtual java/io/PrintStream/print(I)V\n"
        T_Double -> "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ code ++ "\tinvokevirtual java/io/PrintStream/print(D)V\n"
        _ -> error "Tipo não suportado para print"
  return printCode

genCmd c tab fun (Ret maybeExpr) = case maybeExpr of
  Just e -> do
    (t, code) <- genExpr c tab fun e
    let ret = case t of
          T_Int    -> "\tireturn\n"
          T_Double -> "\tdreturn\n"
          _ -> error "Tipo não suportado para return"
    return (code ++ ret)
  Nothing -> return "\treturn\n"

genCmd c tab fun (For init cond inc bloco) = do
  li <- novoLabel
  lv <- novoLabel
  lf <- novoLabel
  cInit <- genCmd c tab fun init
  cCond <- genExprL c tab fun lv lf cond
  cInc  <- genCmd c tab fun inc
  cBody <- genBloco c tab fun bloco
  return (cInit ++ li ++ ":\n" ++ cCond ++ lv ++ ":\n" ++ cBody ++ cInc ++ "\tgoto " ++ li ++ "\n" ++ lf ++ ":\n")

-- ArrAssign: aload arrayref ; <idx> ; <value> ; iastore|dastore
genCmd c tab fun (ArrAssign nome idxExpr valExpr) =
  case Map.lookup nome tab of
    Nothing -> error ("Array " ++ nome ++ " não encontrado")
    Just (T_Arr elemType _, idx) -> do
      (tIdx, idxCode) <- genExpr c tab fun idxExpr
      when (tIdx /= T_Int) $ error ("Índice do array " ++ nome ++ " deve ser int")
      (tVal, valCode) <- genExpr c tab fun valExpr
      let valCode' = case (elemType, tVal) of
            (T_Double, T_Int) -> valCode ++ "\ti2d\n"
            (T_Int, T_Double) -> valCode ++ "\td2i\n"
            _ -> valCode
      let storeInstr = case elemType of
            T_Int -> "\tiastore\n"
            T_Double -> "\tdastore\n"
            _ -> error "Tipo não suportado no array store"
      return ("\taload " ++ show idx ++ "\n" ++ idxCode ++ valCode' ++ storeInstr)
    Just _ -> error (nome ++ " não é array")

-- Leitura: usa Scanner
genCmd c tab fun (Leitura x) = case Map.lookup x tab of
  Nothing -> error $ "Leitura de variavel nao declarada: " ++ x
  Just (t, idx) -> do
    let scannerNew = "\tnew java/util/Scanner\n\tdup\n\tgetstatic java/lang/System/in Ljava/io/InputStream;\n\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n"
    case t of
      T_Int -> return (scannerNew ++ "\tinvokevirtual java/util/Scanner/nextInt()I\n\tistore " ++ show idx ++ "\n")
      T_Double -> return (scannerNew ++ "\tinvokevirtual java/util/Scanner/nextDouble()D\n\tdstore " ++ show idx ++ "\n")
      _ -> error "Tipo nao suportado em Leitura"

-- Proc (procedimento void)
genCmd c tab fun (Proc nome args) =
  case Map.lookup nome c of
    Nothing -> error $ "Procedimento nao declarado: " ++ nome
    Just tipoRet ->
      if tipoRet /= T_Void
        then error $ "Procedimento " ++ nome ++ " retorna valor mas foi usado como comando."
        else do
          argumentos <- mapM (genExpr c tab fun) args
          let codigoArgs = concatMap snd argumentos
              tipos = map fst argumentos
              tipoJ t = case t of
                T_Int -> "I"
                T_Double -> "D"
                T_Void -> "V"
              chamada = "\tinvokestatic " ++ nome ++ "(" ++ concatMap tipoJ tipos ++ ")V\n"
          return (codigoArgs ++ chamada)

------------------------------------------------------------------------
-- FUNCOES, BLOCOS E PROGRAMA
------------------------------------------------------------------------

genFunc :: Env -> (Id, [Var], Bloco) -> State Int String
genFunc env (nome, vars, bloco) = do
  let indexed = zip vars [0..]
      tab = Map.fromList [ (x, (t, i)) | (x :#: (t, _), i) <- indexed ]
      tipo = fromMaybe (error $ "Função " ++ nome ++ " não declarada") (Map.lookup nome env)
      tipoJVM = case tipo of T_Int -> "I"; T_Double -> "D"; T_Void -> "V"
      nLocals = max 1 (length vars)
  corpo <- genBloco env tab nome bloco
  return $ ".method public static " ++ nome ++ "()" ++ tipoJVM ++ "\n" ++
           "\t.limit stack 20\n\t.limit locals " ++ show nLocals ++ "\n" ++
           corpo ++ (if tipo == T_Void then "\treturn\n" else "") ++ ".end method\n\n"

genBloco :: Env -> EnvJVM -> Id -> Bloco -> State Int String
genBloco env tab fun cmds = fmap concat (mapM (genCmd env tab fun) cmds)

-- inicializa arrays nas variáveis locais (args reservados separadamente)
genInitVars :: [(Id, (Tipo, Int))] -> String
genInitVars [] = ""
genInitVars ((_, (T_Arr elemType tam, idx)) : xs) =
  let loadSize = "\tldc " ++ show tam ++ "\n"
      newArr = case elemType of
                 T_Int -> "\tnewarray int\n"
                 T_Double -> "\tnewarray double\n"
                 _ -> error "Tipo de array não suportado"
      store = "\tastore " ++ show idx ++ "\n"
  in loadSize ++ newArr ++ store ++ genInitVars xs
genInitVars (_:xs) = genInitVars xs

genProg :: Id -> Programa -> State Int String
genProg nome (Prog funcoes corpos vars bloco) = do
  let cab = genCab nome
      envFun = Map.fromList [(f, t) | f :->: (_, t) <- funcoes]
      funDefs = [ (f, ps ++ vs, b) | ((f :->: (ps, _)), (f2, vs, b)) <- zip funcoes corpos, f == f2 ]
  funs <- mapM (genFunc envFun) funDefs

  let varsIndexed = zip vars [1..]  -- main: local 0 = args, program vars -> 1..
      tab = Map.fromList [ (x, (t, i)) | (x :#: (t, _), i) <- varsIndexed ]
      initArrays = genInitVars [ (x, (t, i)) | (x :#: (t, _), i) <- varsIndexed ]
      nLocals = 1 + length vars

  maincab <- return (genMainCab 20 nLocals)
  corpo <- genBloco envFun tab "main" bloco

  let main = maincab ++ initArrays ++ corpo ++ "\treturn\n.end method\n"
  return (cab ++ concat funs ++ main)

gerar :: Id -> Programa -> String
gerar nome p = fst $ runState (genProg nome p) 0
