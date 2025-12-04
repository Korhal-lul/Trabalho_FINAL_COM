{
module Lex where
import System.IO    
import Token
}

%wrapper "basic"

$digit = [0-9]              -- digits
$alpha = [A-Za-z]           -- alfabeto

@int = $digit+
@double = $digit+(\.$digit+)
@id = $alpha [$alpha  $digit]*
@literal = \"[^ \"]*\" 

tokens :-

<0> $white+ ;
<0> "+"     {\s -> T_ADD}  
<0> "-"     {\s -> T_SUB}  
<0> "*"     {\s -> T_MUL}
<0> "/="    {\s -> T_DIF}  
<0> "/"     {\s -> T_DIV}
<0> "("     {\s -> T_LPAR}
<0> ")"     {\s -> T_RPAR}
<0> "&&"    {\s -> T_AND}
<0> "||"    {\s -> T_OR}
<0> "!"     {\s -> T_NOT}
<0> "%"     {\s -> T_MOD}
<0> "**"    {\s -> T_EXP}
<0> "["     {\s -> T_LBRACKET}
<0> "]"     {\s -> T_RBRACKET}
<0> "="     {\s -> T_ATRIB}
<0> "=="    {\s -> T_EQUAL}
<0> ">="    {\s -> T_GREATERE}
<0> "<="    {\s -> T_LESSE}
<0> "<"     {\s -> T_LESS}
<0> ">"     {\s -> T_GREATER}
<0> "void"  {\s -> T_VOID} 
<0> "int"   {\s -> T_INT} 
<0> "string"{\s -> T_STR} 
<0> "double"{\s -> T_DOUBLE}
<0> "{"     {\s -> T_LB}
<0> "}"     {\s -> T_RB}
<0> ","     {\s -> T_COMMA}
<0> ";"     {\s -> T_SEMI}
<0> "return"{\s -> T_RET}
<0> "if"    {\s -> T_IF}
<0> "else"  {\s -> T_ELSE}
<0> "while" {\s -> T_WHILE}
<0> "for"   {\s -> T_FOR}
<0> "print" {\s -> T_PRINT}
<0> "read"  {\s -> T_READ}


-- constants

<0> @id         {\s -> CID s}
<0> @literal    {\s -> CLITERAL  s}
<0> @double     {\s -> CDOUBLE (read s)}
<0> @int        {\s -> CINT (read s)}


{
-- As acoes tem tipo :: String -> Token

testLex = do 
        handle <- openFile "texto.txt" ReadMode
        contents <- hGetContents handle
        print (alexScanTokens contents) 
        hClose handle
}