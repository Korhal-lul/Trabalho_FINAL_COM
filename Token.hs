module Token where

data Token
  = T_ADD 
  | T_SUB 
  | T_MUL 
  | T_DIV 
  | T_DIF
  | T_LPAR 
  | T_RPAR 
  | T_AND 
  | T_OR 
  | T_NOT
  | T_MOD
  | T_EXP
  | T_LBRACKET
  | T_RBRACKET
  | T_EQUAL 
  | T_GREATERE 
  | T_LESSE 
  | T_LESS 
  | T_GREATER
  | T_VOID 
  | T_INT 
  | T_STR 
  | T_DOUBLE
  | T_LB 
  | T_RB 
  | T_COMMA 
  | T_SEMI
  | T_RET 
  | T_IF 
  | T_ELSE 
  | T_WHILE 
  | T_FOR
  | T_ATRIB
  | T_PRINT 
  | T_READ
  | CID String 
  | CLITERAL String 
  | CDOUBLE Double 
  | CINT Int
  deriving (Eq, Show)