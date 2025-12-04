module DataTree where

type Id =  String 

data Tipo = T_Double | T_Int | T_Str | T_Void deriving (Show, Eq)

data TCons = CDouble Double | CInt Int deriving Show

data Entrada = EArit Expr | ERel ExprR | ELog ExprL | ECmd Comando | EBloco Bloco deriving Show

data Expr = Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr | Mod Expr Expr | Exp Expr Expr | Neg Expr | Const TCons | IdVar String | Chamada Id [Expr] | Lit String | IntDouble Expr | DoubleInt Expr deriving Show

data ExprR = Req Expr Expr | Rdif Expr Expr | Rlt Expr Expr | Rgt Expr Expr | Rle Expr Expr | Rge Expr Expr deriving Show

data ExprL = And ExprL ExprL | Or ExprL ExprL | Not ExprL | Rel ExprR deriving Show

data Var = Id :#: (Tipo, Int) deriving Show

data Funcao =  Id :->: ([Var], Tipo) deriving Show

data Programa = Prog[Funcao] [(Id, [Var], Bloco)] [Var] Bloco deriving Show

type Bloco = [Comando]

data Comando = 
    If ExprL Bloco Bloco
    | While ExprL Bloco
    | Atrib Id Expr
    | Leitura Id 
    | Imp Expr
    | For Comando ExprL Comando Bloco
    | Ret (Maybe Expr)
    | Proc Id [Expr]
        deriving Show

t1:: (Funcao, ([Var], Bloco)) -> (Id, [Var], Bloco) 
t1 (a:->:as,(b,c)) = (a, (fst as) ++ b,c)  