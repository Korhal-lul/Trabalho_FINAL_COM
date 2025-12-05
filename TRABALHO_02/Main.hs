module Main where

import DataTree
import Semantic
import Parser hiding (main)
import qualified Lex as L
import System.IO
import Data.List (intercalate)

-- ============================================================
-- Pretty Print da AST
-- ============================================================

ppIndent :: Int -> String
ppIndent n = replicate n ' '

ppExpr :: Int -> Expr -> String
ppExpr i e = case e of
    Add a b -> base "Add"  [ppExpr (i+2) a, ppExpr (i+2) b]
    Sub a b -> base "Sub"  [ppExpr (i+2) a, ppExpr (i+2) b]
    Mul a b -> base "Mul"  [ppExpr (i+2) a, ppExpr (i+2) b]
    Div a b -> base "Div"  [ppExpr (i+2) a, ppExpr (i+2) b]
    Const (CInt n)    -> ind ++ "Const " ++ show n
    Const (CDouble d) -> ind ++ "Const " ++ show d
    IdVar x           -> ind ++ "IdVar " ++ x
    Lit s             -> ind ++ "Lit " ++ show s
    IntDouble e1      -> base "IntDouble" [ppExpr (i+2) e1]
    DoubleInt e1      -> base "DoubleInt" [ppExpr (i+2) e1]
    Chamada f args      -> base ("Chamada " ++ f) (map (ppExpr (i+2)) args)
  where 
    ind = ppIndent i
    base name xs = ind ++ name ++ "\n" ++ intercalate "\n" xs

ppExprR :: Int -> ExprR -> String
ppExprR i r = case r of
    Req a b  -> bin "Req" a b
    Rdif a b -> bin "Rdif" a b
    Rlt a b  -> bin "Rlt" a b
    Rgt a b  -> bin "Rgt" a b
    Rle a b  -> bin "Rle" a b
    Rge a b  -> bin "Rge" a b
  where
    bin name a b =
        ppIndent i ++ name ++ "\n"
        ++ ppExpr (i+2) a ++ "\n"
        ++ ppExpr (i+2) b

ppExprL :: Int -> ExprL -> String
ppExprL i e = case e of
    And a b -> node "And"  [ppExprL (i+2) a, ppExprL (i+2) b]
    Or  a b -> node "Or"   [ppExprL (i+2) a, ppExprL (i+2) b]
    Not a   -> node "Not"  [ppExprL (i+2) a]
    Rel r   -> node "Rel"  [ppExprR (i+2) r]
  where
    node n xs = ppIndent i ++ n ++ "\n" ++ intercalate "\n" xs

ppCmd :: Int -> Comando -> String
ppCmd i c = case c of
    Atrib x e       -> ind ++ "Atrib " ++ x ++ "\n" ++ ppExpr (i+2) e
    Imp e           -> ind ++ "Print\n" ++ ppExpr (i+2) e
    Leitura x       -> ind ++ "Read " ++ x
    Ret Nothing     -> ind ++ "Return"
    Ret (Just e)    -> ind ++ "Return\n" ++ ppExpr (i+2) e
    Proc f args     -> ind ++ "Proc " ++ f ++ "\n" ++ intercalate "\n" (map (ppExpr (i+2)) args)
    If cond b1 b2   ->
        ind ++ "If\n"
        ++ ppExprL (i+2) cond ++ "\n"
        ++ ppBloco (i+2) b1 ++ "\n"
        ++ ppBloco (i+2) b2
    While cond b ->
        ind ++ "While\n"
        ++ ppExprL (i+2) cond ++ "\n"
        ++ ppBloco (i+2) b
    For a cond inc b ->
        ind ++ "For\n"
        ++ ppCmd (i+2) a ++ "\n"
        ++ ppExprL (i+2) cond ++ "\n"
        ++ ppCmd (i+2) inc ++ "\n"
        ++ ppBloco (i+2) b
  where
      ind = ppIndent i

ppBloco :: Int -> [Comando] -> String
ppBloco i cmds =
    ppIndent i ++ "{\n"
    ++ intercalate "\n" (map (ppCmd (i+2)) cmds)
    ++ "\n" ++ ppIndent i ++ "}"

ppFunc :: (Id,[Var],Bloco) -> String
ppFunc (nome, vars, bloco) =
    "Function " ++ nome ++ "\n"
    ++ "Vars: " ++ show vars ++ "\n"
    ++ ppBloco 2 bloco

printAST :: Programa -> IO ()
printAST (Prog funs defs vars bloco) = do
    putStrLn "\n==================== AST FINAL ====================\n"
    mapM_ (putStrLn . ppFunc) defs
    putStrLn "\n--- MAIN ---"
    putStrLn (ppBloco 0 bloco)

-- ============================================================
-- MAIN
-- ============================================================

main :: IO ()
main = do
    putStrLn "Lendo teste.j--_"
    contents <- readFile "teste.j--_"

    let tokens = L.alexScanTokens contents
    let prog = calc tokens

    putStrLn "\n----- ANALISE SEMANTICA -----"

    case verificaPrograma prog of
        Left err -> do
            putStrLn "\nERRO SEMANTICO:"
            putStrLn err

        Right (progFinal, warns) -> do
            mapM_ putStrLn warns
            printAST progFinal
