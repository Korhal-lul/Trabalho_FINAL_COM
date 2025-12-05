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
happyExpList = Happy_Data_Array.listArray (0,412) ([0,0,0,62,0,0,0,1920,0,0,0,57344,3,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,4534,0,0,0,28039,4,0,0,0,0,0,0,0,16384,0,0,0,46656,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,4,57360,1,0,256,0,0,0,16384,0,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,0,64,16384,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,32768,7168,0,0,0,48,32768,7,0,1024,0,480,0,0,0,16384,0,0,64,0,30,0,0,0,1024,0,0,132,24576,1,0,8448,0,88,0,0,0,0,0,0,3,64,0,0,768,0,0,0,0,0,0,0,0,64,0,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24576,0,0,0,0,0,0,0,0,0,0,0,0,16384,4534,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,8960,0,0,0,0,4,24576,1,0,256,0,88,0,16384,0,5632,0,0,16,32768,5,0,0,0,0,0,0,26,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50224,7,0,0,16384,8,5632,0,0,16,32768,5,0,26624,0,0,0,0,33,22528,0,0,0,16384,0,0,8960,0,0,0,0,8,0,0,0,512,0,0,0,3072,0,1,0,0,0,64,0,0,2048,2048,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0,0,4096,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,1792,0,0,0,0,0,0,0,256,0,120,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,4,0,0,0,256,0,0,32768,16385,0,0,0,0,2,0,0,8448,0,88,0,16384,8,5632,0,0,0,0,0,0,26624,0,0,0,12288,1990,0,0,0,64,0,22,0,4096,0,1408,0,0,4,24576,1,0,256,0,88,0,16384,0,5632,0,0,16,32768,5,0,0,512,0,0,49152,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,24576,283,0,12288,0,0,0,0,12,0,0,0,768,0,0,0,49152,0,0,0,0,48,0,0,0,3072,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,1024,0,0,0,55552,70,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,1,30720,0,0,0,32,0,0,0,0,0,0,49152,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","Programa","ListaFuncoes","Funcao","TipoRetorno","DeclParametros","Parametro","BlocoPrincipal","Declaracoes","Declaracao","Tipo","ListaId","Bloco","ListaCmd","Comando","CmdSe","CmdEnquanto","AtribFor","CmdAtrib","CmdEscrita","CmdLeitura","ChamadaProc","ChamadaFuncao","ListaParametros","Retorno","ExpressaoLogica","LTermo","LFator","ExpressaoRelacional","ExpressaoAritmetica","Term","Factor","'+'","'-'","'*'","'/'","'('","')'","'/='","'&&'","'||'","'!'","'=='","'>='","'>'","'<='","'<'","'void'","'int'","'double'","'string'","'{'","'}'","','","';'","'return'","'if'","'else'","'while'","'for'","'='","'print'","'read'","Int","Double","Literal","Id","%eof"]
        bit_start = st * 70
        bit_end = (st + 1) * 70
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..69]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (50) = happyShift action_6
action_0 (51) = happyShift action_7
action_0 (52) = happyShift action_8
action_0 (53) = happyShift action_9
action_0 (54) = happyShift action_12
action_0 (4) = happyGoto action_10
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (10) = happyGoto action_11
action_0 (13) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (50) = happyShift action_6
action_1 (51) = happyShift action_7
action_1 (52) = happyShift action_8
action_1 (53) = happyShift action_9
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (13) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (50) = happyShift action_6
action_2 (51) = happyShift action_7
action_2 (52) = happyShift action_8
action_2 (53) = happyShift action_9
action_2 (54) = happyShift action_12
action_2 (6) = happyGoto action_34
action_2 (7) = happyGoto action_4
action_2 (10) = happyGoto action_35
action_2 (13) = happyGoto action_5
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_4

action_4 (69) = happyShift action_33
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_7

action_6 _ = happyReduce_8

action_7 _ = happyReduce_17

action_8 _ = happyReduce_18

action_9 _ = happyReduce_19

action_10 (70) = happyAccept
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_2

action_12 (51) = happyShift action_7
action_12 (52) = happyShift action_8
action_12 (53) = happyShift action_9
action_12 (58) = happyShift action_26
action_12 (59) = happyShift action_27
action_12 (61) = happyShift action_28
action_12 (62) = happyShift action_29
action_12 (64) = happyShift action_30
action_12 (65) = happyShift action_31
action_12 (69) = happyShift action_32
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

action_13 (51) = happyShift action_7
action_13 (52) = happyShift action_8
action_13 (53) = happyShift action_9
action_13 (58) = happyShift action_26
action_13 (59) = happyShift action_27
action_13 (61) = happyShift action_28
action_13 (62) = happyShift action_29
action_13 (64) = happyShift action_30
action_13 (65) = happyShift action_31
action_13 (69) = happyShift action_32
action_13 (12) = happyGoto action_59
action_13 (13) = happyGoto action_15
action_13 (16) = happyGoto action_60
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

action_14 _ = happyReduce_15

action_15 (69) = happyShift action_58
action_15 (14) = happyGoto action_57
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (55) = happyShift action_56
action_16 (58) = happyShift action_26
action_16 (59) = happyShift action_27
action_16 (61) = happyShift action_28
action_16 (62) = happyShift action_29
action_16 (64) = happyShift action_30
action_16 (65) = happyShift action_31
action_16 (69) = happyShift action_32
action_16 (17) = happyGoto action_55
action_16 (18) = happyGoto action_18
action_16 (19) = happyGoto action_19
action_16 (21) = happyGoto action_20
action_16 (22) = happyGoto action_21
action_16 (23) = happyGoto action_22
action_16 (24) = happyGoto action_23
action_16 (25) = happyGoto action_24
action_16 (27) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_24

action_18 _ = happyReduce_25

action_19 _ = happyReduce_26

action_20 _ = happyReduce_27

action_21 _ = happyReduce_28

action_22 _ = happyReduce_29

action_23 _ = happyReduce_30

action_24 (57) = happyShift action_54
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_31

action_26 (39) = happyShift action_48
action_26 (57) = happyShift action_49
action_26 (66) = happyShift action_50
action_26 (67) = happyShift action_51
action_26 (68) = happyShift action_52
action_26 (69) = happyShift action_53
action_26 (25) = happyGoto action_44
action_26 (32) = happyGoto action_45
action_26 (33) = happyGoto action_46
action_26 (34) = happyGoto action_47
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (39) = happyShift action_43
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (39) = happyShift action_42
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (39) = happyShift action_41
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (39) = happyShift action_40
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (39) = happyShift action_39
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (39) = happyShift action_37
action_32 (63) = happyShift action_38
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (39) = happyShift action_36
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_3

action_35 _ = happyReduce_1

action_36 (40) = happyShift action_93
action_36 (51) = happyShift action_7
action_36 (52) = happyShift action_8
action_36 (53) = happyShift action_9
action_36 (8) = happyGoto action_90
action_36 (9) = happyGoto action_91
action_36 (13) = happyGoto action_92
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (39) = happyShift action_48
action_37 (40) = happyShift action_88
action_37 (66) = happyShift action_50
action_37 (67) = happyShift action_51
action_37 (68) = happyShift action_89
action_37 (69) = happyShift action_53
action_37 (25) = happyGoto action_44
action_37 (26) = happyGoto action_86
action_37 (32) = happyGoto action_87
action_37 (33) = happyGoto action_46
action_37 (34) = happyGoto action_47
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (39) = happyShift action_48
action_38 (66) = happyShift action_50
action_38 (67) = happyShift action_51
action_38 (68) = happyShift action_85
action_38 (69) = happyShift action_53
action_38 (25) = happyGoto action_44
action_38 (32) = happyGoto action_84
action_38 (33) = happyGoto action_46
action_38 (34) = happyGoto action_47
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (69) = happyShift action_83
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (39) = happyShift action_48
action_40 (66) = happyShift action_50
action_40 (67) = happyShift action_51
action_40 (68) = happyShift action_82
action_40 (69) = happyShift action_53
action_40 (25) = happyGoto action_44
action_40 (32) = happyGoto action_81
action_40 (33) = happyGoto action_46
action_40 (34) = happyGoto action_47
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (69) = happyShift action_80
action_41 (21) = happyGoto action_79
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (39) = happyShift action_76
action_42 (44) = happyShift action_77
action_42 (66) = happyShift action_50
action_42 (67) = happyShift action_51
action_42 (69) = happyShift action_53
action_42 (25) = happyGoto action_44
action_42 (28) = happyGoto action_78
action_42 (29) = happyGoto action_72
action_42 (30) = happyGoto action_73
action_42 (31) = happyGoto action_74
action_42 (32) = happyGoto action_75
action_42 (33) = happyGoto action_46
action_42 (34) = happyGoto action_47
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (39) = happyShift action_76
action_43 (44) = happyShift action_77
action_43 (66) = happyShift action_50
action_43 (67) = happyShift action_51
action_43 (69) = happyShift action_53
action_43 (25) = happyGoto action_44
action_43 (28) = happyGoto action_71
action_43 (29) = happyGoto action_72
action_43 (30) = happyGoto action_73
action_43 (31) = happyGoto action_74
action_43 (32) = happyGoto action_75
action_43 (33) = happyGoto action_46
action_43 (34) = happyGoto action_47
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_75

action_45 (35) = happyShift action_68
action_45 (36) = happyShift action_69
action_45 (57) = happyShift action_70
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (37) = happyShift action_66
action_46 (38) = happyShift action_67
action_46 _ = happyReduce_68

action_47 _ = happyReduce_71

action_48 (39) = happyShift action_48
action_48 (66) = happyShift action_50
action_48 (67) = happyShift action_51
action_48 (69) = happyShift action_53
action_48 (25) = happyGoto action_44
action_48 (32) = happyGoto action_65
action_48 (33) = happyGoto action_46
action_48 (34) = happyGoto action_47
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_52

action_50 _ = happyReduce_72

action_51 _ = happyReduce_73

action_52 (57) = happyShift action_64
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (39) = happyShift action_37
action_53 _ = happyReduce_74

action_54 _ = happyReduce_43

action_55 _ = happyReduce_23

action_56 _ = happyReduce_13

action_57 (56) = happyShift action_62
action_57 (57) = happyShift action_63
action_57 _ = happyFail (happyExpListPerState 57)

action_58 _ = happyReduce_21

action_59 _ = happyReduce_14

action_60 (55) = happyShift action_61
action_60 (58) = happyShift action_26
action_60 (59) = happyShift action_27
action_60 (61) = happyShift action_28
action_60 (62) = happyShift action_29
action_60 (64) = happyShift action_30
action_60 (65) = happyShift action_31
action_60 (69) = happyShift action_32
action_60 (17) = happyGoto action_55
action_60 (18) = happyGoto action_18
action_60 (19) = happyGoto action_19
action_60 (21) = happyGoto action_20
action_60 (22) = happyGoto action_21
action_60 (23) = happyGoto action_22
action_60 (24) = happyGoto action_23
action_60 (25) = happyGoto action_24
action_60 (27) = happyGoto action_25
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_12

action_62 (69) = happyShift action_124
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_16

action_64 _ = happyReduce_51

action_65 (35) = happyShift action_68
action_65 (36) = happyShift action_69
action_65 (40) = happyShift action_123
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (39) = happyShift action_48
action_66 (66) = happyShift action_50
action_66 (67) = happyShift action_51
action_66 (69) = happyShift action_53
action_66 (25) = happyGoto action_44
action_66 (34) = happyGoto action_122
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (39) = happyShift action_48
action_67 (66) = happyShift action_50
action_67 (67) = happyShift action_51
action_67 (69) = happyShift action_53
action_67 (25) = happyGoto action_44
action_67 (34) = happyGoto action_121
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (39) = happyShift action_48
action_68 (66) = happyShift action_50
action_68 (67) = happyShift action_51
action_68 (69) = happyShift action_53
action_68 (25) = happyGoto action_44
action_68 (33) = happyGoto action_120
action_68 (34) = happyGoto action_47
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (39) = happyShift action_48
action_69 (66) = happyShift action_50
action_69 (67) = happyShift action_51
action_69 (69) = happyShift action_53
action_69 (25) = happyGoto action_44
action_69 (33) = happyGoto action_119
action_69 (34) = happyGoto action_47
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_50

action_71 (40) = happyShift action_118
action_71 (42) = happyShift action_107
action_71 (43) = happyShift action_108
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_55

action_73 _ = happyReduce_57

action_74 _ = happyReduce_59

action_75 (35) = happyShift action_68
action_75 (36) = happyShift action_69
action_75 (41) = happyShift action_112
action_75 (45) = happyShift action_113
action_75 (46) = happyShift action_114
action_75 (47) = happyShift action_115
action_75 (48) = happyShift action_116
action_75 (49) = happyShift action_117
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (39) = happyShift action_76
action_76 (44) = happyShift action_77
action_76 (66) = happyShift action_50
action_76 (67) = happyShift action_51
action_76 (69) = happyShift action_53
action_76 (25) = happyGoto action_44
action_76 (28) = happyGoto action_110
action_76 (29) = happyGoto action_72
action_76 (30) = happyGoto action_73
action_76 (31) = happyGoto action_74
action_76 (32) = happyGoto action_111
action_76 (33) = happyGoto action_46
action_76 (34) = happyGoto action_47
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (39) = happyShift action_76
action_77 (66) = happyShift action_50
action_77 (67) = happyShift action_51
action_77 (69) = happyShift action_53
action_77 (25) = happyGoto action_44
action_77 (30) = happyGoto action_109
action_77 (31) = happyGoto action_74
action_77 (32) = happyGoto action_75
action_77 (33) = happyGoto action_46
action_77 (34) = happyGoto action_47
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (40) = happyShift action_106
action_78 (42) = happyShift action_107
action_78 (43) = happyShift action_108
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (39) = happyShift action_76
action_79 (44) = happyShift action_77
action_79 (66) = happyShift action_50
action_79 (67) = happyShift action_51
action_79 (69) = happyShift action_53
action_79 (25) = happyGoto action_44
action_79 (28) = happyGoto action_105
action_79 (29) = happyGoto action_72
action_79 (30) = happyGoto action_73
action_79 (31) = happyGoto action_74
action_79 (32) = happyGoto action_75
action_79 (33) = happyGoto action_46
action_79 (34) = happyGoto action_47
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (63) = happyShift action_38
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (35) = happyShift action_68
action_81 (36) = happyShift action_69
action_81 (40) = happyShift action_104
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (40) = happyShift action_103
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (40) = happyShift action_102
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (35) = happyShift action_68
action_84 (36) = happyShift action_69
action_84 (57) = happyShift action_101
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (57) = happyShift action_100
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (40) = happyShift action_98
action_86 (56) = happyShift action_99
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (35) = happyShift action_68
action_87 (36) = happyShift action_69
action_87 _ = happyReduce_49

action_88 _ = happyReduce_45

action_89 _ = happyReduce_48

action_90 (40) = happyShift action_96
action_90 (56) = happyShift action_97
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_10

action_92 (69) = happyShift action_95
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (54) = happyShift action_12
action_93 (10) = happyGoto action_94
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_6

action_95 _ = happyReduce_11

action_96 (54) = happyShift action_12
action_96 (10) = happyGoto action_144
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (51) = happyShift action_7
action_97 (52) = happyShift action_8
action_97 (53) = happyShift action_9
action_97 (9) = happyGoto action_143
action_97 (13) = happyGoto action_92
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_44

action_99 (39) = happyShift action_48
action_99 (66) = happyShift action_50
action_99 (67) = happyShift action_51
action_99 (68) = happyShift action_142
action_99 (69) = happyShift action_53
action_99 (25) = happyGoto action_44
action_99 (32) = happyGoto action_141
action_99 (33) = happyGoto action_46
action_99 (34) = happyGoto action_47
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_39

action_101 _ = happyReduce_38

action_102 (57) = happyShift action_140
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (57) = happyShift action_139
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (57) = happyShift action_138
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (42) = happyShift action_107
action_105 (43) = happyShift action_108
action_105 (57) = happyShift action_137
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (54) = happyShift action_126
action_106 (15) = happyGoto action_136
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (39) = happyShift action_76
action_107 (44) = happyShift action_77
action_107 (66) = happyShift action_50
action_107 (67) = happyShift action_51
action_107 (69) = happyShift action_53
action_107 (25) = happyGoto action_44
action_107 (29) = happyGoto action_135
action_107 (30) = happyGoto action_73
action_107 (31) = happyGoto action_74
action_107 (32) = happyGoto action_75
action_107 (33) = happyGoto action_46
action_107 (34) = happyGoto action_47
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (39) = happyShift action_76
action_108 (44) = happyShift action_77
action_108 (66) = happyShift action_50
action_108 (67) = happyShift action_51
action_108 (69) = happyShift action_53
action_108 (25) = happyGoto action_44
action_108 (29) = happyGoto action_134
action_108 (30) = happyGoto action_73
action_108 (31) = happyGoto action_74
action_108 (32) = happyGoto action_75
action_108 (33) = happyGoto action_46
action_108 (34) = happyGoto action_47
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_56

action_110 (40) = happyShift action_133
action_110 (42) = happyShift action_107
action_110 (43) = happyShift action_108
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (35) = happyShift action_68
action_111 (36) = happyShift action_69
action_111 (40) = happyShift action_123
action_111 (41) = happyShift action_112
action_111 (45) = happyShift action_113
action_111 (46) = happyShift action_114
action_111 (47) = happyShift action_115
action_111 (48) = happyShift action_116
action_111 (49) = happyShift action_117
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (39) = happyShift action_48
action_112 (66) = happyShift action_50
action_112 (67) = happyShift action_51
action_112 (69) = happyShift action_53
action_112 (25) = happyGoto action_44
action_112 (32) = happyGoto action_132
action_112 (33) = happyGoto action_46
action_112 (34) = happyGoto action_47
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (39) = happyShift action_48
action_113 (66) = happyShift action_50
action_113 (67) = happyShift action_51
action_113 (69) = happyShift action_53
action_113 (25) = happyGoto action_44
action_113 (32) = happyGoto action_131
action_113 (33) = happyGoto action_46
action_113 (34) = happyGoto action_47
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (39) = happyShift action_48
action_114 (66) = happyShift action_50
action_114 (67) = happyShift action_51
action_114 (69) = happyShift action_53
action_114 (25) = happyGoto action_44
action_114 (32) = happyGoto action_130
action_114 (33) = happyGoto action_46
action_114 (34) = happyGoto action_47
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (39) = happyShift action_48
action_115 (66) = happyShift action_50
action_115 (67) = happyShift action_51
action_115 (69) = happyShift action_53
action_115 (25) = happyGoto action_44
action_115 (32) = happyGoto action_129
action_115 (33) = happyGoto action_46
action_115 (34) = happyGoto action_47
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (39) = happyShift action_48
action_116 (66) = happyShift action_50
action_116 (67) = happyShift action_51
action_116 (69) = happyShift action_53
action_116 (25) = happyGoto action_44
action_116 (32) = happyGoto action_128
action_116 (33) = happyGoto action_46
action_116 (34) = happyGoto action_47
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (39) = happyShift action_48
action_117 (66) = happyShift action_50
action_117 (67) = happyShift action_51
action_117 (69) = happyShift action_53
action_117 (25) = happyGoto action_44
action_117 (32) = happyGoto action_127
action_117 (33) = happyGoto action_46
action_117 (34) = happyGoto action_47
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (54) = happyShift action_126
action_118 (15) = happyGoto action_125
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (37) = happyShift action_66
action_119 (38) = happyShift action_67
action_119 _ = happyReduce_67

action_120 (37) = happyShift action_66
action_120 (38) = happyShift action_67
action_120 _ = happyReduce_66

action_121 _ = happyReduce_70

action_122 _ = happyReduce_69

action_123 _ = happyReduce_76

action_124 _ = happyReduce_20

action_125 (60) = happyShift action_148
action_125 _ = happyReduce_32

action_126 (58) = happyShift action_26
action_126 (59) = happyShift action_27
action_126 (61) = happyShift action_28
action_126 (62) = happyShift action_29
action_126 (64) = happyShift action_30
action_126 (65) = happyShift action_31
action_126 (69) = happyShift action_32
action_126 (16) = happyGoto action_147
action_126 (17) = happyGoto action_17
action_126 (18) = happyGoto action_18
action_126 (19) = happyGoto action_19
action_126 (21) = happyGoto action_20
action_126 (22) = happyGoto action_21
action_126 (23) = happyGoto action_22
action_126 (24) = happyGoto action_23
action_126 (25) = happyGoto action_24
action_126 (27) = happyGoto action_25
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (35) = happyShift action_68
action_127 (36) = happyShift action_69
action_127 _ = happyReduce_63

action_128 (35) = happyShift action_68
action_128 (36) = happyShift action_69
action_128 _ = happyReduce_64

action_129 (35) = happyShift action_68
action_129 (36) = happyShift action_69
action_129 _ = happyReduce_62

action_130 (35) = happyShift action_68
action_130 (36) = happyShift action_69
action_130 _ = happyReduce_61

action_131 (35) = happyShift action_68
action_131 (36) = happyShift action_69
action_131 _ = happyReduce_60

action_132 (35) = happyShift action_68
action_132 (36) = happyShift action_69
action_132 _ = happyReduce_65

action_133 _ = happyReduce_58

action_134 _ = happyReduce_54

action_135 _ = happyReduce_53

action_136 _ = happyReduce_34

action_137 (69) = happyShift action_146
action_137 (20) = happyGoto action_145
action_137 _ = happyFail (happyExpListPerState 137)

action_138 _ = happyReduce_40

action_139 _ = happyReduce_41

action_140 _ = happyReduce_42

action_141 (35) = happyShift action_68
action_141 (36) = happyShift action_69
action_141 _ = happyReduce_46

action_142 _ = happyReduce_47

action_143 _ = happyReduce_9

action_144 _ = happyReduce_5

action_145 (40) = happyShift action_152
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (63) = happyShift action_151
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (55) = happyShift action_150
action_147 (58) = happyShift action_26
action_147 (59) = happyShift action_27
action_147 (61) = happyShift action_28
action_147 (62) = happyShift action_29
action_147 (64) = happyShift action_30
action_147 (65) = happyShift action_31
action_147 (69) = happyShift action_32
action_147 (17) = happyGoto action_55
action_147 (18) = happyGoto action_18
action_147 (19) = happyGoto action_19
action_147 (21) = happyGoto action_20
action_147 (22) = happyGoto action_21
action_147 (23) = happyGoto action_22
action_147 (24) = happyGoto action_23
action_147 (25) = happyGoto action_24
action_147 (27) = happyGoto action_25
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (54) = happyShift action_126
action_148 (15) = happyGoto action_149
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_33

action_150 _ = happyReduce_22

action_151 (39) = happyShift action_48
action_151 (66) = happyShift action_50
action_151 (67) = happyShift action_51
action_151 (68) = happyShift action_155
action_151 (69) = happyShift action_53
action_151 (25) = happyGoto action_44
action_151 (32) = happyGoto action_154
action_151 (33) = happyGoto action_46
action_151 (34) = happyGoto action_47
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (54) = happyShift action_126
action_152 (15) = happyGoto action_153
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_35

action_154 (35) = happyShift action_68
action_154 (36) = happyShift action_69
action_154 _ = happyReduce_36

action_155 _ = happyReduce_37

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

happyReduce_12 = happyReduce 4 10 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 ((happy_var_2, happy_var_3)
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (([], happy_var_2)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  11 happyReduction_14
happyReduction_14 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1++happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  11 happyReduction_15
happyReduction_15 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  12 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (map (\x -> x:#: (happy_var_1,0)) happy_var_2
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  13 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn13
		 (T_Int
	)

happyReduce_18 = happySpecReduce_1  13 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn13
		 (T_Double
	)

happyReduce_19 = happySpecReduce_1  13 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn13
		 (T_Str
	)

happyReduce_20 = happySpecReduce_3  14 happyReduction_20
happyReduction_20 (HappyTerminal (CID happy_var_3))
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  14 happyReduction_21
happyReduction_21 (HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  15 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  16 happyReduction_23
happyReduction_23 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1++[happy_var_2]
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  16 happyReduction_24
happyReduction_24 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  17 happyReduction_25
happyReduction_25 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  17 happyReduction_26
happyReduction_26 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  17 happyReduction_28
happyReduction_28 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  17 happyReduction_30
happyReduction_30 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  17 happyReduction_31
happyReduction_31 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happyReduce 5 18 happyReduction_32
happyReduction_32 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (If happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 7 18 happyReduction_33
happyReduction_33 ((HappyAbsSyn15  happy_var_7) `HappyStk`
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

happyReduce_34 = happyReduce 5 19 happyReduction_34
happyReduction_34 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 8 19 happyReduction_35
happyReduction_35 ((HappyAbsSyn15  happy_var_8) `HappyStk`
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

happyReduce_36 = happySpecReduce_3  20 happyReduction_36
happyReduction_36 (HappyAbsSyn32  happy_var_3)
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn20
		 (Atrib happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 (HappyTerminal (CLITERAL happy_var_3))
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn20
		 (Atrib happy_var_1 (Lit happy_var_3)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happyReduce 4 21 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Atrib happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 4 21 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyTerminal (CLITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Atrib happy_var_1 (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 5 22 happyReduction_40
happyReduction_40 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Imp happy_var_3
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 5 22 happyReduction_41
happyReduction_41 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CLITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Imp (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 5 23 happyReduction_42
happyReduction_42 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Leitura happy_var_3
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_2  24 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (Proc (fst happy_var_1) (snd happy_var_1)
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 25 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (CID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 ((happy_var_1,happy_var_3)
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_3  25 happyReduction_45
happyReduction_45 _
	_
	(HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn25
		 ((happy_var_1,[])
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  26 happyReduction_46
happyReduction_46 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  26 happyReduction_47
happyReduction_47 (HappyTerminal (CLITERAL happy_var_3))
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 ++ [Lit happy_var_3]
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  26 happyReduction_48
happyReduction_48 (HappyTerminal (CLITERAL happy_var_1))
	 =  HappyAbsSyn26
		 ([(Lit happy_var_1)]
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  26 happyReduction_49
happyReduction_49 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  27 happyReduction_50
happyReduction_50 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (Ret (Just happy_var_2)
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  27 happyReduction_51
happyReduction_51 _
	(HappyTerminal (CLITERAL happy_var_2))
	_
	 =  HappyAbsSyn27
		 (Ret (Just (Lit happy_var_2))
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  27 happyReduction_52
happyReduction_52 _
	_
	 =  HappyAbsSyn27
		 (Ret (Nothing)
	)

happyReduce_53 = happySpecReduce_3  28 happyReduction_53
happyReduction_53 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (And happy_var_1 happy_var_3
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  28 happyReduction_54
happyReduction_54 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Or happy_var_1 happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  28 happyReduction_55
happyReduction_55 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  29 happyReduction_56
happyReduction_56 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (Not happy_var_2
	)
happyReduction_56 _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  29 happyReduction_57
happyReduction_57 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  30 happyReduction_58
happyReduction_58 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (happy_var_2
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  30 happyReduction_59
happyReduction_59 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn30
		 (Rel happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  31 happyReduction_60
happyReduction_60 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Req happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  31 happyReduction_61
happyReduction_61 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rge happy_var_1 happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  31 happyReduction_62
happyReduction_62 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rgt happy_var_1 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  31 happyReduction_63
happyReduction_63 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rlt happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  31 happyReduction_64
happyReduction_64 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rle happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  31 happyReduction_65
happyReduction_65 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rdif happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  32 happyReduction_66
happyReduction_66 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Add happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  32 happyReduction_67
happyReduction_67 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  32 happyReduction_68
happyReduction_68 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  33 happyReduction_69
happyReduction_69 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  33 happyReduction_70
happyReduction_70 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (Div happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  33 happyReduction_71
happyReduction_71 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  34 happyReduction_72
happyReduction_72 (HappyTerminal (CINT happy_var_1))
	 =  HappyAbsSyn34
		 (Const (CInt happy_var_1)
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  34 happyReduction_73
happyReduction_73 (HappyTerminal (CDOUBLE happy_var_1))
	 =  HappyAbsSyn34
		 (Const (CDouble happy_var_1)
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  34 happyReduction_74
happyReduction_74 (HappyTerminal (CID happy_var_1))
	 =  HappyAbsSyn34
		 (IdVar happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  34 happyReduction_75
happyReduction_75 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn34
		 (Chamada (fst happy_var_1) (snd happy_var_1)
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  34 happyReduction_76
happyReduction_76 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn34
		 (happy_var_2
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 70 70 notHappyAtAll (HappyState action) sts stk []

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
	T_EQUAL -> cont 45;
	T_GREATERE -> cont 46;
	T_GREATER -> cont 47;
	T_LESSE -> cont 48;
	T_LESS -> cont 49;
	T_VOID -> cont 50;
	T_INT -> cont 51;
	T_DOUBLE -> cont 52;
	T_STR -> cont 53;
	T_LB -> cont 54;
	T_RB -> cont 55;
	T_COMMA -> cont 56;
	T_SEMI -> cont 57;
	T_RET -> cont 58;
	T_IF -> cont 59;
	T_ELSE -> cont 60;
	T_WHILE -> cont 61;
	T_FOR -> cont 62;
	T_ATRIB -> cont 63;
	T_PRINT -> cont 64;
	T_READ -> cont 65;
	CINT happy_dollar_dollar -> cont 66;
	CDOUBLE happy_dollar_dollar -> cont 67;
	CLITERAL happy_dollar_dollar -> cont 68;
	CID happy_dollar_dollar -> cont 69;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 70 tk tks = happyError' (tks, explist)
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
