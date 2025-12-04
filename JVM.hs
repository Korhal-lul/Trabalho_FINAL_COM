module JVM where

import DataTree
import Data.Maybe (fromJust, fromMaybe)
import qualified Data.Map as Map
import Semantic (Env, EnvFun)
import Control.Monad.State
import DataTree (Comando(Imp))

type EnvJVM = Map.Map Id (Tipo, Int)

novoLabel::State Int String 
novoLabel = do {n <- get; put (n+1); return ("l"++show n)}

genCab nome = return (".class public " ++ nome ++ 
                      "\n.super java/lang/Object\n\n.method public <init>()V\n\taload_0\n\tinvokenonvirtual java/lang/Object/<init>()V\n\treturn\n.end method\n\n")

genMainCab s l = return (".method public static main([Ljava/lang/String;)V" ++
                         "\n\t.limit stack " ++ show s ++
                         "\n\t.limit locals " ++ show l ++ "\n\n")


genExprL c tab fun v f (And e1 e2) = do 
   l1 <- novoLabel; 
   e1' <- genExprL c tab fun l1 f e1;
   e2' <- genExprL c tab fun v f e2;
   return (e1'++l1++":\n"++e2')
genExprL c tab fun v f (Or e1 e2) = do
  l1 <- novoLabel
  e1' <- genExprL c tab fun v l1 e1
  e2' <- genExprL c tab fun v f e2
  return (e1' ++ l1 ++ ":\n" ++ e2')
genExprL c tab fun v f (Not e) = genExprL c tab fun f v e
genExprL c tab fun v f (Rel r) = genExprR c tab fun v f r

genExprR c tab fun v f (Req e1 e2) = do
  (t1, e1') <- genExpr c tab fun e1;
  (t2,e2') <- genExpr c tab fun e2;
  return (e1'++e2'++genRel t1 t2 v "eq"++"\tgoto "++f++"\n")
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
        T_Double -> return (T_Double, "\tfload " ++ show idx ++ "\n")
        _       -> error ("Tipo não suportado para variável " ++ x)
    Nothing -> error ("Variável " ++ x ++ " não encontrada")

genExpr c tab f (Add e1 e2) = do
  (t1, e1') <- genExpr c tab f e1
  (t2, e2') <- genExpr c tab f e2
  return (t1, e1' ++ e2' ++ genOp t1 "add")
genExpr c tab f (Sub e1 e2) = do
  (t1, e1') <- genExpr c tab f e1
  (t2, e2') <- genExpr c tab f e2
  return (t1, e1' ++ e2' ++ genOp t1 "sub")
genExpr c tab f (Mul e1 e2) = do
  (t1, e1') <- genExpr c tab f e1
  (t2, e2') <- genExpr c tab f e2
  return (t1, e1' ++ e2' ++ genOp t1 "mul")
genExpr c tab f (Div e1 e2) = do
  (t1, e1') <- genExpr c tab f e1
  (t2, e2') <- genExpr c tab f e2
  return (t1, e1' ++ e2' ++ genOp t1 "div")
genExpr c tab f (Mod e1 e2) = do
  (t1, e1') <- genExpr c tab f e1
  (t2, e2') <- genExpr c tab f e2
  case (t1, t2) of
    (T_Int, T_Int) -> return (T_Int, e1' ++ e2' ++ genOp t1 "rem")
    (T_Double, T_Double) -> return (T_Double, e1' ++ e2' ++ genOp t1 "rem") -- opcional, só se quiser admitir double
    _ -> error $ "Operador % nao compatível com tipos: " ++ show t1 ++ " e " ++ show t2
genExpr c tab f (Exp e1 e2) = do
  (t1, c1) <- genExpr c tab f e1
  (t2, c2) <- genExpr c tab f e2
  let code =
        c1 ++
        c2 ++
        "\ti2d\n\
        \\tswap\n\
        \\ti2d\n\
        \\tinvokestatic java/lang/Math/pow(DD)D\n\
        \\td2i\n"
  return (T_Int, code)
genExpr c tab fun (Chamada nome args) = do
  argumentos <- mapM (genExpr c tab fun) args
  let codigoArgs = concatMap snd argumentos
      tipos = map fst argumentos
      tipoRet = fromMaybe (error $ "Função " ++ nome ++ " não declarada") (Map.lookup nome c)
      tipoJ t = case t of
        T_Int    -> "I"
        T_Double -> "F"
        T_Void   -> "V"
      chamada = "\tinvokestatic " ++ nome ++ "(" ++ concatMap tipoJ tipos ++ ")" ++ tipoJ tipoRet ++ "\n"
  return (tipoRet, codigoArgs ++ chamada)
genExpr c tab fun (DoubleInt e) = do
  res <- genExpr c tab fun e
  case res of
    (T_Double, e') -> return (T_Int, e' ++ "\td2i\n")
    _ -> error "Esperado tipo Double na conversão DoubleInt"
genExpr c tab fun (IntDouble e) = do
  res <- genExpr c tab fun e
  case res of
    (T_Int, e') -> return (T_Double, e' ++ "\ti2d\n")
    _ -> error "Esperado tipo Int na conversão IntDouble"

genOp :: Tipo -> String -> String
genOp T_Int op = "\ti" ++ op ++ "\n"
genOp T_Double op = "\tf" ++ op ++ "\n"

genRel :: Tipo -> Tipo -> String -> String -> String
genRel T_Int T_Int label op = "\tif_icmp" ++ op ++ " " ++ label ++ "\n"
genRel T_Double T_Double label op =
  "\tdcmpl\n" ++ "\tif" ++ op ++ " " ++ label ++ "\n"
genRel t1 t2 _ _ = error $ "Comparação não suportada entre tipos: " ++ show t1 ++ " e " ++ show t2


genCmd :: Env -> EnvJVM -> Id -> Comando -> State Int String
genCmd c tab fun (Atrib x e) = do
  (t, e') <- genExpr c tab fun e
  case Map.lookup x tab of
    Just (_, idx) -> return (e' ++ genStore t idx)
    Nothing -> error $ "Variável não encontrada: " ++ x
  where
    genStore T_Int i = "\tistore " ++ show i ++ "\n"
    genStore T_Double i = "\tfstore " ++ show i ++ "\n"

genCmd c tab fun (While cond bloco) = do
  li <- novoLabel
  lv <- novoLabel
  lf <- novoLabel
  e' <- genExprL c tab fun lv lf cond
  b' <- genBloco c tab fun bloco
  return (li++":\n"++e'++lv++":\n"++b'++"\tgoto "++li++"\n"++lf++":\n")

genCmd c tab fun (If cond blocoThen blocoElse) = do
  lv <- novoLabel
  lf <- novoLabel
  e' <- genExprL c tab fun lv lf cond
  bThen <- genBloco c tab fun blocoThen
  bElse <- genBloco c tab fun blocoElse
  return (e' ++ lv ++ ":\n" ++ bThen ++ "\tgoto " ++ lf ++ "\n" ++ lf ++ ":\n" ++ bElse)

genCmd c tab fun (Imp e) = do
  (t, e') <- genExpr c tab fun e
  let printCode = case t of
        T_Int    -> "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++
                   e' ++
                   "\tswap\n" ++
                   "\tinvokevirtual java/io/PrintStream/print(I)V\n"
        T_Double -> "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++
                   e' ++
                   "\tswap\n" ++
                   "\tinvokevirtual java/io/PrintStream/print(F)V\n"
        _       -> error "Tipo não suportado para print"
  return printCode

genCmd c tab fun (Ret maybeExpr) = case maybeExpr of
  Just e -> do
    (t, e') <- genExpr c tab fun e
    let ret = case t of
          T_Int    -> "\tireturn\n"
          T_Double -> "\tfreturn\n"
          _       -> error "Tipo não suportado para return"
    return (e' ++ ret)
  Nothing ->
    return "\treturn\n"

genCmd c tab fun (For init cond inc bloco) = do
  li <- novoLabel
  lv <- novoLabel
  lf <- novoLabel

  cInit <- genCmd c tab fun init
  cCond <- genExprL c tab fun lv lf cond
  cInc  <- genCmd c tab fun inc
  cBody <- genBloco c tab fun bloco

  return $
    cInit ++
    li ++ ":\n" ++
    cCond ++
    lv ++ ":\n" ++
    cBody ++
    cInc ++
    "\tgoto " ++ li ++ "\n" ++
    lf ++ ":\n"

genFunc :: Env -> (Id, [Var], Bloco) -> State Int String
genFunc env (nome, vars, bloco) = do
  let tab = Map.fromList [(x, (t, i)) | x :#: (t, i) <- vars]
      tipo = fromMaybe (error $ "Função " ++ nome ++ " não declarada") (Map.lookup nome env)
      tipoJVM = case tipo of
                  T_Int -> "I"
                  T_Double -> "F"
                  T_Void -> "V"
  corpo <- genBloco env tab nome bloco
  return $
    ".method public static " ++ nome ++ "()" ++ tipoJVM ++ "\n" ++
    "\t.limit stack 10\n\t.limit locals 10\n" ++
    corpo ++
    (if tipo == T_Void then "\treturn\n" else "") ++
    ".end method\n\n"

genBloco :: Env -> EnvJVM -> Id -> Bloco -> State Int String
genBloco c tab fun comandos = fmap concat (mapM (genCmd c tab fun) comandos)

genProg :: Id -> Programa -> State Int String
genProg nome (Prog funcoes corpos vars bloco) = do
  cab <- genCab nome
  maincab <- genMainCab 10 10
  let envFun = Map.fromList [(f, t) | f :->: (_, t) <- funcoes]
      funDefs = [(f, ps ++ vs, b) |
                 ((f :->: (ps, _)), (f2, vs, b)) <- zip funcoes corpos,
                 f == f2]
  funs <- mapM (genFunc envFun) funDefs
  let tab = Map.fromList [(x, (t, i)) | x :#: (t, i) <- vars]
  corpo <- genBloco envFun tab "main" bloco
  let main =
        maincab ++
        corpo ++
        "\treturn\n.end method\n"
  return (cab ++ concat funs ++ main)


gerar nome p = fst $ runState (genProg nome p) 0