{-# OPTIONS_GHC -w #-}
module Parser where

import System.IO
import Token
import qualified Lex as L
import DataTree
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,459) ([0,0,0,992,0,0,0,32768,7,0,0,0,15872,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,7009,1,0,0,34560,1133,0,0,0,0,0,0,0,0,16384,0,0,0,25600,283,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,1024,0,7681,0,0,16,0,0,0,16384,0,0,0,0,256,0,0,0,0,4,0,0,0,4096,0,0,0,0,16448,0,4,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,32768,49152,1,0,0,768,0,1920,0,0,4,0,22,0,4096,0,30720,0,0,0,0,256,0,0,1,32768,7,0,0,0,4096,0,0,528,0,88,0,16384,8,24576,1,0,0,0,0,0,49152,0,256,0,0,3072,12,0,0,0,0,0,0,0,0,1,32768,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,1028,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,1,0,0,4096,0,0,0,0,0,0,0,0,0,36864,1133,0,0,0,0,0,0,0,0,2048,0,0,0,0,256,0,0,0,0,0,0,1024,0,5632,0,0,0,0,0,0,35840,0,0,0,0,256,0,1408,0,0,4,0,22,0,4096,0,22528,0,0,64,0,352,0,0,1,32768,5,0,1024,0,5632,0,0,0,0,0,0,32768,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,268,31,0,0,0,33,32768,5,0,1024,0,5632,0,0,416,0,0,0,16384,8,24576,1,0,0,1,16,0,49152,8,0,0,0,8192,0,0,0,0,128,0,0,0,12288,0,64,0,0,0,0,1,0,0,8195,0,0,0,32768,0,8,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,128,2048,0,0,0,0,0,0,0,0,0,4096,0,0,0,128,0,0,0,0,0,0,0,0,1,0,0,0,0,32,0,0,0,28672,0,0,0,0,0,0,0,0,1,32768,7,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,256,0,0,0,0,4,0,0,1536,4096,0,0,0,0,8,0,0,33792,0,5632,0,0,528,0,88,0,0,0,0,0,0,6656,0,0,0,49152,61464,1,0,0,4096,0,22528,0,0,64,0,352,0,0,1,32768,5,0,1024,0,5632,0,0,16,0,88,0,16384,0,24576,1,0,0,2048,0,0,0,771,0,0,0,3072,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,2,0,0,0,0,0,0,0,0,32,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,8,0,0,0,55296,70,0,3072,0,0,0,0,48,0,0,0,49152,0,0,0,0,768,0,0,0,0,12,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,7680,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,32768,0,0,0,12288,0,64,0,0,0,0,1,0,0,32,0,0,0,0,0,1024,0,0,0,36864,1133,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,7680,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","Programa","ListaFuncoes","Funcao","TipoRetorno","DeclParametros","Parametro","BlocoPrincipal","Declaracoes","Declaracao","Tipo","ListaId","Bloco","ListaCmd","Comando","CmdSe","CmdEnquanto","AtribFor","CmdAtrib","CmdEscrita","CmdLeitura","ChamadaProc","ChamadaFuncao","ListaParametros","Retorno","ExpressaoLogica","LTermo","LFator","ExpressaoRelacional","ExpressaoAritmetica","Term","Factor","'+'","'-'","'*'","'/'","'('","')'","'/='","'&&'","'||'","'!'","'%'","'**'","'['","']'","'=='","'>='","'>'","'<='","'<'","'void'","'int'","'double'","'string'","'{'","'}'","','","';'","'return'","'if'","'else'","'while'","'for'","'='","'print'","'read'","Int","Double","Literal","Id","%eof"]
        bit_start = st * 74
        bit_end = (st + 1) * 74
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..73]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (54) = happyShift action_6
action_0 (55) = happyShift action_7
action_0 (56) = happyShift action_8
action_0 (57) = happyShift action_9
action_0 (58) = happyShift action_12
action_0 (4) = happyGoto action_10
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (10) = happyGoto action_11
action_0 (13) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (54) = happyShift action_6
action_1 (55) = happyShift action_7
action_1 (56) = happyShift action_8
action_1 (57) = happyShift action_9
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (13) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (54) = happyShift action_6
action_2 (55) = happyShift action_7
action_2 (56) = happyShift action_8
action_2 (57) = happyShift action_9
action_2 (58) = happyShift action_12
action_2 (6) = happyGoto action_34
action_2 (7) = happyGoto action_4
action_2 (10) = happyGoto action_35
action_2 (13) = happyGoto action_5
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_4

action_4 (73) = happyShift action_33
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_7

action_6 _ = happyReduce_8

action_7 _ = happyReduce_19

action_8 _ = happyReduce_20

action_9 _ = happyReduce_21

action_10 (74) = happyAccept
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_2

action_12 (55) = happyShift action_7
action_12 (56) = happyShift action_8
action_12 (57) = happyShift action_9
action_12 (62) = happyShift action_26
action_12 (63) = happyShift action_27
action_12 (65) = happyShift action_28
action_12 (66) = happyShift action_29
action_12 (68) = happyShift action_30
action_12 (69) = happyShift action_31
action_12 (73) = happyShift action_32
action_12 (11) = happyGoto action_13
action_12 (12) = happyGoto action_14
action_12 (13) = happyGoto action_15
action_12 (16) = happyGoto action_16
action_12 (17) = happyGoto action_17
action_12 (18) = happyGoto action_18
action_12 (19) = happyGoto action_19
action_12 (21) = happyGoto action_20
action_12 (22) = happyGoto action_21
action_12 (23) = happyGoto action_22
action_12 (24) = happyGoto action_23
action_12 (25) = happyGoto action_24
action_12 (27) = happyGoto action_25
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (55) = happyShift action_7
action_13 (56) = happyShift action_8
action_13 (57) = happyShift action_9
action_13 (62) = happyShift action_26
action_13 (63) = happyShift action_27
action_13 (65) = happyShift action_28
action_13 (66) = happyShift action_29
action_13 (68) = happyShift action_30
action_13 (69) = happyShift action_31
action_13 (73) = happyShift action_32
action_13 (12) = happyGoto action_60
action_13 (13) = happyGoto action_15
action_13 (16) = happyGoto action_61
action_13 (17) = happyGoto action_17
action_13 (18) = happyGoto action_18
action_13 (19) = happyGoto action_19
action_13 (21) = happyGoto action_20
action_13 (22) = happyGoto action_21
action_13 (23) = happyGoto action_22
action_13 (24) = happyGoto action_23
action_13 (25) = happyGoto action_24
action_13 (27) = happyGoto action_25
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_16

action_15 (73) = happyShift action_59
action_15 (14) = happyGoto action_58
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (59) = happyShift action_57
action_16 (62) = happyShift action_26
action_16 (63) = happyShift action_27
action_16 (65) = happyShift action_28
action_16 (66) = happyShift action_29
action_16 (68) = happyShift action_30
action_16 (69) = happyShift action_31
action_16 (73) = happyShift action_32
action_16 (17) = happyGoto action_56
action_16 (18) = happyGoto action_18
action_16 (19) = happyGoto action_19
action_16 (21) = happyGoto action_20
action_16 (22) = happyGoto action_21
action_16 (23) = happyGoto action_22
action_16 (24) = happyGoto action_23
action_16 (25) = happyGoto action_24
action_16 (27) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_26

action_18 _ = happyReduce_27

action_19 _ = happyReduce_28

action_20 _ = happyReduce_29

action_21 _ = happyReduce_30

action_22 _ = happyReduce_31

action_23 _ = happyReduce_32

action_24 (61) = happyShift action_55
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_33

action_26 (39) = happyShift action_49
action_26 (61) = happyShift action_50
action_26 (70) = happyShift action_51
action_26 (71) = happyShift action_52
action_26 (72) = happyShift action_53
action_26 (73) = happyShift action_54
action_26 (25) = happyGoto action_45
action_26 (32) = happyGoto action_46
action_26 (33) = happyGoto action_47
action_26 (34) = happyGoto action_48
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (39) = happyShift action_44
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (39) = happyShift action_43
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (39) = happyShift action_42
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (39) = happyShift action_41
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (39) = happyShift action_40
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (39) = happyShift action_37
action_32 (47) = happyShift action_38
action_32 (67) = happyShift action_39
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (39) = happyShift action_36
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_3

action_35 _ = happyReduce_1

action_36 (40) = happyShift action_99
action_36 (55) = happyShift action_7
action_36 (56) = happyShift action_8
action_36 (57) = happyShift action_9
action_36 (8) = happyGoto action_96
action_36 (9) = happyGoto action_97
action_36 (13) = happyGoto action_98
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (39) = happyShift action_49
action_37 (40) = happyShift action_94
action_37 (70) = happyShift action_51
action_37 (71) = happyShift action_52
action_37 (72) = happyShift action_95
action_37 (73) = happyShift action_54
action_37 (25) = happyGoto action_45
action_37 (26) = happyGoto action_92
action_37 (32) = happyGoto action_93
action_37 (33) = happyGoto action_47
action_37 (34) = happyGoto action_48
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (39) = happyShift action_49
action_38 (70) = happyShift action_51
action_38 (71) = happyShift action_52
action_38 (73) = happyShift action_54
action_38 (25) = happyGoto action_45
action_38 (32) = happyGoto action_91
action_38 (33) = happyGoto action_47
action_38 (34) = happyGoto action_48
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (39) = happyShift action_49
action_39 (70) = happyShift action_51
action_39 (71) = happyShift action_52
action_39 (72) = happyShift action_90
action_39 (73) = happyShift action_54
action_39 (25) = happyGoto action_45
action_39 (32) = happyGoto action_89
action_39 (33) = happyGoto action_47
action_39 (34) = happyGoto action_48
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (73) = happyShift action_88
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (39) = happyShift action_49
action_41 (70) = happyShift action_51
action_41 (71) = happyShift action_52
action_41 (72) = happyShift action_87
action_41 (73) = happyShift action_54
action_41 (25) = happyGoto action_45
action_41 (32) = happyGoto action_86
action_41 (33) = happyGoto action_47
action_41 (34) = happyGoto action_48
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (73) = happyShift action_85
action_42 (21) = happyGoto action_84
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (39) = happyShift action_81
action_43 (44) = happyShift action_82
action_43 (70) = happyShift action_51
action_43 (71) = happyShift action_52
action_43 (73) = happyShift action_54
action_43 (25) = happyGoto action_45
action_43 (28) = happyGoto action_83
action_43 (29) = happyGoto action_77
action_43 (30) = happyGoto action_78
action_43 (31) = happyGoto action_79
action_43 (32) = happyGoto action_80
action_43 (33) = happyGoto action_47
action_43 (34) = happyGoto action_48
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (39) = happyShift action_81
action_44 (44) = happyShift action_82
action_44 (70) = happyShift action_51
action_44 (71) = happyShift action_52
action_44 (73) = happyShift action_54
action_44 (25) = happyGoto action_45
action_44 (28) = happyGoto action_76
action_44 (29) = happyGoto action_77
action_44 (30) = happyGoto action_78
action_44 (31) = happyGoto action_79
action_44 (32) = happyGoto action_80
action_44 (33) = happyGoto action_47
action_44 (34) = happyGoto action_48
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_81

action_46 (35) = happyShift action_73
action_46 (36) = happyShift action_74
action_46 (61) = happyShift action_75
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (37) = happyShift action_69
action_47 (38) = happyShift action_70
action_47 (45) = happyShift action_71
action_47 (46) = happyShift action_72
action_47 _ = happyReduce_72

action_48 _ = happyReduce_77

action_49 (39) = happyShift action_49
action_49 (70) = happyShift action_51
action_49 (71) = happyShift action_52
action_49 (73) = happyShift action_54
action_49 (25) = happyGoto action_45
action_49 (32) = happyGoto action_68
action_49 (33) = happyGoto action_47
action_49 (34) = happyGoto action_48
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_56

action_51 _ = happyReduce_78

action_52 _ = happyReduce_79

action_53 (61) = happyShift action_67
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (39) = happyShift action_37
action_54 (47) = happyShift action_66
action_54 _ = happyReduce_80

action_55 _ = happyReduce_47

action_56 _ = happyReduce_25

action_57 _ = happyReduce_14

action_58 (60) = happyShift action_64
action_58 (61) = happyShift action_65
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (47) = happyShift action_63
action_59 _ = happyReduce_23

action_60 _ = happyReduce_15

action_61 (59) = happyShift action_62
action_61 (62) = happyShift action_26
action_61 (63) = happyShift action_27
action_61 (65) = happyShift action_28
action_61 (66) = happyShift action_29
action_61 (68) = happyShift action_30
action_61 (69) = happyShift action_31
action_61 (73) = happyShift action_32
action_61 (17) = happyGoto action_56
action_61 (18) = happyGoto action_18
action_61 (19) = happyGoto action_19
action_61 (21) = happyGoto action_20
action_61 (22) = happyGoto action_21
action_61 (23) = happyGoto action_22
action_61 (24) = happyGoto action_23
action_61 (25) = happyGoto action_24
action_61 (27) = happyGoto action_25
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_13

action_63 (70) = happyShift action_135
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (73) = happyShift action_134
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_17

action_66 (39) = happyShift action_49
action_66 (70) = happyShift action_51
action_66 (71) = happyShift action_52
action_66 (73) = happyShift action_54
action_66 (25) = happyGoto action_45
action_66 (32) = happyGoto action_133
action_66 (33) = happyGoto action_47
action_66 (34) = happyGoto action_48
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_55

action_68 (35) = happyShift action_73
action_68 (36) = happyShift action_74
action_68 (40) = happyShift action_132
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (39) = happyShift action_49
action_69 (70) = happyShift action_51
action_69 (71) = happyShift action_52
action_69 (73) = happyShift action_54
action_69 (25) = happyGoto action_45
action_69 (34) = happyGoto action_131
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (39) = happyShift action_49
action_70 (70) = happyShift action_51
action_70 (71) = happyShift action_52
action_70 (73) = happyShift action_54
action_70 (25) = happyGoto action_45
action_70 (34) = happyGoto action_130
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (39) = happyShift action_49
action_71 (70) = happyShift action_51
action_71 (71) = happyShift action_52
action_71 (73) = happyShift action_54
action_71 (25) = happyGoto action_45
action_71 (34) = happyGoto action_129
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (39) = happyShift action_49
action_72 (70) = happyShift action_51
action_72 (71) = happyShift action_52
action_72 (73) = happyShift action_54
action_72 (25) = happyGoto action_45
action_72 (34) = happyGoto action_128
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (39) = happyShift action_49
action_73 (70) = happyShift action_51
action_73 (71) = happyShift action_52
action_73 (73) = happyShift action_54
action_73 (25) = happyGoto action_45
action_73 (33) = happyGoto action_127
action_73 (34) = happyGoto action_48
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (39) = happyShift action_49
action_74 (70) = happyShift action_51
action_74 (71) = happyShift action_52
action_74 (73) = happyShift action_54
action_74 (25) = happyGoto action_45
action_74 (33) = happyGoto action_126
action_74 (34) = happyGoto action_48
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_54

action_76 (40) = happyShift action_125
action_76 (42) = happyShift action_114
action_76 (43) = happyShift action_115
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_59

action_78 _ = happyReduce_61

action_79 _ = happyReduce_63

action_80 (35) = happyShift action_73
action_80 (36) = happyShift action_74
action_80 (41) = happyShift action_119
action_80 (49) = happyShift action_120
action_80 (50) = happyShift action_121
action_80 (51) = happyShift action_122
action_80 (52) = happyShift action_123
action_80 (53) = happyShift action_124
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (39) = happyShift action_81
action_81 (44) = happyShift action_82
action_81 (70) = happyShift action_51
action_81 (71) = happyShift action_52
action_81 (73) = happyShift action_54
action_81 (25) = happyGoto action_45
action_81 (28) = happyGoto action_117
action_81 (29) = happyGoto action_77
action_81 (30) = happyGoto action_78
action_81 (31) = happyGoto action_79
action_81 (32) = happyGoto action_118
action_81 (33) = happyGoto action_47
action_81 (34) = happyGoto action_48
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (39) = happyShift action_81
action_82 (70) = happyShift action_51
action_82 (71) = happyShift action_52
action_82 (73) = happyShift action_54
action_82 (25) = happyGoto action_45
action_82 (30) = happyGoto action_116
action_82 (31) = happyGoto action_79
action_82 (32) = happyGoto action_80
action_82 (33) = happyGoto action_47
action_82 (34) = happyGoto action_48
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (40) = happyShift action_113
action_83 (42) = happyShift action_114
action_83 (43) = happyShift action_115
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (39) = happyShift action_81
action_84 (44) = happyShift action_82
action_84 (70) = happyShift action_51
action_84 (71) = happyShift action_52
action_84 (73) = happyShift action_54
action_84 (25) = happyGoto action_45
action_84 (28) = happyGoto action_112
action_84 (29) = happyGoto action_77
action_84 (30) = happyGoto action_78
action_84 (31) = happyGoto action_79
action_84 (32) = happyGoto action_80
action_84 (33) = happyGoto action_47
action_84 (34) = happyGoto action_48
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (47) = happyShift action_38
action_85 (67) = happyShift action_39
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (35) = happyShift action_73
action_86 (36) = happyShift action_74
action_86 (40) = happyShift action_111
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (40) = happyShift action_110
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (40) = happyShift action_109
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (35) = happyShift action_73
action_89 (36) = happyShift action_74
action_89 (61) = happyShift action_108
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (61) = happyShift action_107
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (35) = happyShift action_73
action_91 (36) = happyShift action_74
action_91 (48) = happyShift action_106
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (40) = happyShift action_104
action_92 (60) = happyShift action_105
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (35) = happyShift action_73
action_93 (36) = happyShift action_74
action_93 _ = happyReduce_53

action_94 _ = happyReduce_49

action_95 _ = happyReduce_52

action_96 (40) = happyShift action_102
action_96 (60) = happyShift action_103
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_10

action_98 (73) = happyShift action_101
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (58) = happyShift action_12
action_99 (10) = happyGoto action_100
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_6

action_101 (47) = happyShift action_159
action_101 _ = happyReduce_11

action_102 (58) = happyShift action_12
action_102 (10) = happyGoto action_158
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (55) = happyShift action_7
action_103 (56) = happyShift action_8
action_103 (57) = happyShift action_9
action_103 (9) = happyGoto action_157
action_103 (13) = happyGoto action_98
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_48

action_105 (39) = happyShift action_49
action_105 (70) = happyShift action_51
action_105 (71) = happyShift action_52
action_105 (72) = happyShift action_156
action_105 (73) = happyShift action_54
action_105 (25) = happyGoto action_45
action_105 (32) = happyGoto action_155
action_105 (33) = happyGoto action_47
action_105 (34) = happyGoto action_48
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (67) = happyShift action_154
action_106 _ = happyFail (happyExpListPerState 106)

action_107 _ = happyReduce_41

action_108 _ = happyReduce_40

action_109 (61) = happyShift action_153
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (61) = happyShift action_152
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (61) = happyShift action_151
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (42) = happyShift action_114
action_112 (43) = happyShift action_115
action_112 (61) = happyShift action_150
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (58) = happyShift action_139
action_113 (15) = happyGoto action_149
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (39) = happyShift action_81
action_114 (44) = happyShift action_82
action_114 (70) = happyShift action_51
action_114 (71) = happyShift action_52
action_114 (73) = happyShift action_54
action_114 (25) = happyGoto action_45
action_114 (29) = happyGoto action_148
action_114 (30) = happyGoto action_78
action_114 (31) = happyGoto action_79
action_114 (32) = happyGoto action_80
action_114 (33) = happyGoto action_47
action_114 (34) = happyGoto action_48
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (39) = happyShift action_81
action_115 (44) = happyShift action_82
action_115 (70) = happyShift action_51
action_115 (71) = happyShift action_52
action_115 (73) = happyShift action_54
action_115 (25) = happyGoto action_45
action_115 (29) = happyGoto action_147
action_115 (30) = happyGoto action_78
action_115 (31) = happyGoto action_79
action_115 (32) = happyGoto action_80
action_115 (33) = happyGoto action_47
action_115 (34) = happyGoto action_48
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_60

action_117 (40) = happyShift action_146
action_117 (42) = happyShift action_114
action_117 (43) = happyShift action_115
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (35) = happyShift action_73
action_118 (36) = happyShift action_74
action_118 (40) = happyShift action_132
action_118 (41) = happyShift action_119
action_118 (49) = happyShift action_120
action_118 (50) = happyShift action_121
action_118 (51) = happyShift action_122
action_118 (52) = happyShift action_123
action_118 (53) = happyShift action_124
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (39) = happyShift action_49
action_119 (70) = happyShift action_51
action_119 (71) = happyShift action_52
action_119 (73) = happyShift action_54
action_119 (25) = happyGoto action_45
action_119 (32) = happyGoto action_145
action_119 (33) = happyGoto action_47
action_119 (34) = happyGoto action_48
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (39) = happyShift action_49
action_120 (70) = happyShift action_51
action_120 (71) = happyShift action_52
action_120 (73) = happyShift action_54
action_120 (25) = happyGoto action_45
action_120 (32) = happyGoto action_144
action_120 (33) = happyGoto action_47
action_120 (34) = happyGoto action_48
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (39) = happyShift action_49
action_121 (70) = happyShift action_51
action_121 (71) = happyShift action_52
action_121 (73) = happyShift action_54
action_121 (25) = happyGoto action_45
action_121 (32) = happyGoto action_143
action_121 (33) = happyGoto action_47
action_121 (34) = happyGoto action_48
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (39) = happyShift action_49
action_122 (70) = happyShift action_51
action_122 (71) = happyShift action_52
action_122 (73) = happyShift action_54
action_122 (25) = happyGoto action_45
action_122 (32) = happyGoto action_142
action_122 (33) = happyGoto action_47
action_122 (34) = happyGoto action_48
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (39) = happyShift action_49
action_123 (70) = happyShift action_51
action_123 (71) = happyShift action_52
action_123 (73) = happyShift action_54
action_123 (25) = happyGoto action_45
action_123 (32) = happyGoto action_141
action_123 (33) = happyGoto action_47
action_123 (34) = happyGoto action_48
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (39) = happyShift action_49
action_124 (70) = happyShift action_51
action_124 (71) = happyShift action_52
action_124 (73) = happyShift action_54
action_124 (25) = happyGoto action_45
action_124 (32) = happyGoto action_140
action_124 (33) = happyGoto action_47
action_124 (34) = happyGoto action_48
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (58) = happyShift action_139
action_125 (15) = happyGoto action_138
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (37) = happyShift action_69
action_126 (38) = happyShift action_70
action_126 (45) = happyShift action_71
action_126 (46) = happyShift action_72
action_126 _ = happyReduce_71

action_127 (37) = happyShift action_69
action_127 (38) = happyShift action_70
action_127 (45) = happyShift action_71
action_127 (46) = happyShift action_72
action_127 _ = happyReduce_70

action_128 _ = happyReduce_76

action_129 _ = happyReduce_75

action_130 _ = happyReduce_74

action_131 _ = happyReduce_73

action_132 _ = happyReduce_82

action_133 (35) = happyShift action_73
action_133 (36) = happyShift action_74
action_133 (48) = happyShift action_137
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_22

action_135 (48) = happyShift action_136
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (61) = happyShift action_167
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_83

action_138 (64) = happyShift action_166
action_138 _ = happyReduce_34

action_139 (62) = happyShift action_26
action_139 (63) = happyShift action_27
action_139 (65) = happyShift action_28
action_139 (66) = happyShift action_29
action_139 (68) = happyShift action_30
action_139 (69) = happyShift action_31
action_139 (73) = happyShift action_32
action_139 (16) = happyGoto action_165
action_139 (17) = happyGoto action_17
action_139 (18) = happyGoto action_18
action_139 (19) = happyGoto action_19
action_139 (21) = happyGoto action_20
action_139 (22) = happyGoto action_21
action_139 (23) = happyGoto action_22
action_139 (24) = happyGoto action_23
action_139 (25) = happyGoto action_24
action_139 (27) = happyGoto action_25
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (35) = happyShift action_73
action_140 (36) = happyShift action_74
action_140 _ = happyReduce_67

action_141 (35) = happyShift action_73
action_141 (36) = happyShift action_74
action_141 _ = happyReduce_68

action_142 (35) = happyShift action_73
action_142 (36) = happyShift action_74
action_142 _ = happyReduce_66

action_143 (35) = happyShift action_73
action_143 (36) = happyShift action_74
action_143 _ = happyReduce_65

action_144 (35) = happyShift action_73
action_144 (36) = happyShift action_74
action_144 _ = happyReduce_64

action_145 (35) = happyShift action_73
action_145 (36) = happyShift action_74
action_145 _ = happyReduce_69

action_146 _ = happyReduce_62

action_147 _ = happyReduce_58

action_148 _ = happyReduce_57

action_149 _ = happyReduce_36

action_150 (73) = happyShift action_164
action_150 (20) = happyGoto action_163
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_44

action_152 _ = happyReduce_45

action_153 _ = happyReduce_46

action_154 (39) = happyShift action_49
action_154 (70) = happyShift action_51
action_154 (71) = happyShift action_52
action_154 (72) = happyShift action_162
action_154 (73) = happyShift action_54
action_154 (25) = happyGoto action_45
action_154 (32) = happyGoto action_161
action_154 (33) = happyGoto action_47
action_154 (34) = happyGoto action_48
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (35) = happyShift action_73
action_155 (36) = happyShift action_74
action_155 _ = happyReduce_50

action_156 _ = happyReduce_51

action_157 _ = happyReduce_9

action_158 _ = happyReduce_5

action_159 (70) = happyShift action_160
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (48) = happyShift action_174
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (35) = happyShift action_73
action_161 (36) = happyShift action_74
action_161 (61) = happyShift action_173
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (61) = happyShift action_172
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (40) = happyShift action_171
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (67) = happyShift action_170
action_164 _ = happyFail (happyExpListPerState 164)

action_165 (59) = happyShift action_169
action_165 (62) = happyShift action_26
action_165 (63) = happyShift action_27
action_165 (65) = happyShift action_28
action_165 (66) = happyShift action_29
action_165 (68) = happyShift action_30
action_165 (69) = happyShift action_31
action_165 (73) = happyShift action_32
action_165 (17) = happyGoto action_56
action_165 (18) = happyGoto action_18
action_165 (19) = happyGoto action_19
action_165 (21) = happyGoto action_20
action_165 (22) = happyGoto action_21
action_165 (23) = happyGoto action_22
action_165 (24) = happyGoto action_23
action_165 (25) = happyGoto action_24
action_165 (27) = happyGoto action_25
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (58) = happyShift action_139
action_166 (15) = happyGoto action_168
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_18

action_168 _ = happyReduce_35

action_169 _ = happyReduce_24

action_170 (39) = happyShift action_49
action_170 (70) = happyShift action_51
action_170 (71) = happyShift action_52
action_170 (72) = happyShift action_177
action_170 (73) = happyShift action_54
action_170 (25) = happyGoto action_45
action_170 (32) = happyGoto action_176
action_170 (33) = happyGoto action_47
action_170 (34) = happyGoto action_48
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (58) = happyShift action_139
action_171 (15) = happyGoto action_175
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_43

action_173 _ = happyReduce_42

action_174 _ = happyReduce_12

action_175 _ = happyReduce_37

action_176 (35) = happyShift action_73
action_176 (36) = happyShift action_74
action_176 _ = happyReduce_38

action_177 _ = happyReduce_39

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Prog (map fst happy_var_1) (map t1 happy_var_1) (fst happy_var_2) (snd happy_var_2)
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn4
		 (Prog[] [] (fst happy_var_1) (snd happy_var_1)
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 ((HappyAbsSyn10  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_2:->:(happy_var_4,happy_var_1), happy_var_6)
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 6 happyReduction_6
happyReduction_6 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_2 :->:([],happy_var_1), happy_var_5)
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  7 happyReduction_7
happyReduction_7 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn7
		 (T_Void
	)

happyReduce_9 = happySpecReduce_3  8 happyReduction_9
happyReduction_9 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  9 happyReduction_11
happyReduction_11 (HappyTerminal (CID happy_var_2))
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2:#:(happy_var_1, 0)
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 5 9 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyTerminal (CINT happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_2)) `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (happy_var_2 :#: (T_Arr happy_var_1 happy_var_4, 0)
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 10 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 ((happy_var_2, happy_var_3)
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_3  10 happyReduction_14
happyReduction_14 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (([], happy_var_2)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  11 happyReduction_15
happyReduction_15 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1++happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  11 happyReduction_16
happyReduction_16 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (map (\x -> x :#: (happy_var_1, 0)) happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happyReduce 6 12 happyReduction_18
happyReduction_18 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CINT happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_2)) `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 ([ happy_var_2 :#: (T_Arr happy_var_1 happy_var_4, 0) ]
	) `HappyStk` happyRest

happyReduce_19 = happySpecReduce_1  13 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn13
		 (T_Int
	)

happyReduce_20 = happySpecReduce_1  13 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn13
		 (T_Double
	)

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 _
	 =  HappyAbsSyn13
		 (T_Str
	)

happyReduce_22 = happySpecReduce_3  14 happyReduction_22
happyReduction_22 (HappyTerminal (CID happy_var_3))
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  15 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  16 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1++[happy_var_2]
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  16 happyReduction_26
happyReduction_26 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  17 happyReduction_28
happyReduction_28 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  17 happyReduction_30
happyReduction_30 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  17 happyReduction_31
happyReduction_31 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  17 happyReduction_33
happyReduction_33 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happyReduce 5 18 happyReduction_34
happyReduction_34 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (If happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 7 18 happyReduction_35
happyReduction_35 ((HappyAbsSyn15  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 5 19 happyReduction_36
happyReduction_36 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_37 = happyReduce 8 19 happyReduction_37
happyReduction_37 ((HappyAbsSyn15  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (For happy_var_3 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_3  20 happyReduction_38
happyReduction_38 (HappyAbsSyn32  happy_var_3)
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn20
		 (Atrib happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  20 happyReduction_39
happyReduction_39 (HappyTerminal (CLITERAL happy_var_3))
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn20
		 (Atrib happy_var_1 (Lit happy_var_3)
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happyReduce 4 21 happyReduction_40
happyReduction_40 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Atrib happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 4 21 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyTerminal (CLITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Atrib happy_var_1 (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 7 21 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (ArrAssign happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_43 = happyReduce 7 21 happyReduction_43
happyReduction_43 (_ `HappyStk`
	(HappyTerminal (CLITERAL happy_var_6)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (ArrAssign happy_var_1 happy_var_3 (Lit happy_var_6)
	) `HappyStk` happyRest

happyReduce_44 = happyReduce 5 22 happyReduction_44
happyReduction_44 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Imp happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happyReduce 5 22 happyReduction_45
happyReduction_45 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CLITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Imp (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_46 = happyReduce 5 23 happyReduction_46
happyReduction_46 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Leitura happy_var_3
	) `HappyStk` happyRest

happyReduce_47 = happySpecReduce_2  24 happyReduction_47
happyReduction_47 _
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (Proc (fst happy_var_1) (snd happy_var_1)
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happyReduce 4 25 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 ((happy_var_1,happy_var_3)
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_3  25 happyReduction_49
happyReduction_49 _
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn25
		 ((happy_var_1,[])
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  26 happyReduction_50
happyReduction_50 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  26 happyReduction_51
happyReduction_51 (HappyTerminal (CLITERAL happy_var_3))
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 ++ [Lit happy_var_3]
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  26 happyReduction_52
happyReduction_52 (HappyTerminal (CLITERAL happy_var_1))
	 =  HappyAbsSyn26
		 ([(Lit happy_var_1)]
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  26 happyReduction_53
happyReduction_53 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  27 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (Ret (Just happy_var_2)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  27 happyReduction_55
happyReduction_55 _
	(HappyTerminal (CLITERAL happy_var_2))
	_
	 =  HappyAbsSyn27
		 (Ret (Just (Lit happy_var_2))
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  27 happyReduction_56
happyReduction_56 _
	_
	 =  HappyAbsSyn27
		 (Ret (Nothing)
	)

happyReduce_57 = happySpecReduce_3  28 happyReduction_57
happyReduction_57 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (And happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  28 happyReduction_58
happyReduction_58 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Or happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  28 happyReduction_59
happyReduction_59 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  29 happyReduction_60
happyReduction_60 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (Not happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  29 happyReduction_61
happyReduction_61 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  30 happyReduction_62
happyReduction_62 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (happy_var_2
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  30 happyReduction_63
happyReduction_63 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn30
		 (Rel happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  31 happyReduction_64
happyReduction_64 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Req happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  31 happyReduction_65
happyReduction_65 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rge happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  31 happyReduction_66
happyReduction_66 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rgt happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  31 happyReduction_67
happyReduction_67 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rlt happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  31 happyReduction_68
happyReduction_68 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rle happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  31 happyReduction_69
happyReduction_69 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rdif happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  32 happyReduction_70
happyReduction_70 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Add happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  32 happyReduction_71
happyReduction_71 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  32 happyReduction_72
happyReduction_72 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  33 happyReduction_73
happyReduction_73 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  33 happyReduction_74
happyReduction_74 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Div happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  33 happyReduction_75
happyReduction_75 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  33 happyReduction_76
happyReduction_76 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Exp happy_var_1 happy_var_3
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  33 happyReduction_77
happyReduction_77 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  34 happyReduction_78
happyReduction_78 (HappyTerminal (CINT happy_var_1))
	 =  HappyAbsSyn34
		 (Const (CInt happy_var_1)
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  34 happyReduction_79
happyReduction_79 (HappyTerminal (CDOUBLE happy_var_1))
	 =  HappyAbsSyn34
		 (Const (CDouble happy_var_1)
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  34 happyReduction_80
happyReduction_80 (HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn34
		 (IdVar happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  34 happyReduction_81
happyReduction_81 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn34
		 (Chamada (fst happy_var_1) (snd happy_var_1)
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  34 happyReduction_82
happyReduction_82 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn34
		 (happy_var_2
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happyReduce 4 34 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn34
		 (ArrAccess happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 74 74 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T_ADD -> cont 35;
	T_SUB -> cont 36;
	T_MUL -> cont 37;
	T_DIV -> cont 38;
	T_LPAR -> cont 39;
	T_RPAR -> cont 40;
	T_DIF -> cont 41;
	T_AND -> cont 42;
	T_OR -> cont 43;
	T_NOT -> cont 44;
	T_MOD -> cont 45;
	T_EXP -> cont 46;
	T_LBRACKET -> cont 47;
	T_RBRACKET -> cont 48;
	T_EQUAL -> cont 49;
	T_GREATERE -> cont 50;
	T_GREATER -> cont 51;
	T_LESSE -> cont 52;
	T_LESS -> cont 53;
	T_VOID -> cont 54;
	T_INT -> cont 55;
	T_DOUBLE -> cont 56;
	T_STR -> cont 57;
	T_LB -> cont 58;
	T_RB -> cont 59;
	T_COMMA -> cont 60;
	T_SEMI -> cont 61;
	T_RET -> cont 62;
	T_IF -> cont 63;
	T_ELSE -> cont 64;
	T_WHILE -> cont 65;
	T_FOR -> cont 66;
	T_ATRIB -> cont 67;
	T_PRINT -> cont 68;
	T_READ -> cont 69;
	CINT happy_dollar_dollar -> cont 70;
	CDOUBLE happy_dollar_dollar -> cont 71;
	CLITERAL happy_dollar_dollar -> cont 72;
	CID happy_dollar_dollar -> cont 73;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 74 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
calc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError s = error ("Parse error:" ++ show s)

main = do
       handle <- openFile "texto.txt" ReadMode
       contents <- hGetContents handle
       print(calc(L.alexScanTokens contents)) 
       hClose handle
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
