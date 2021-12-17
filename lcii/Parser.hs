{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import DataType
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.11

data HappyAbsSyn t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22
	= HappyTerminal (Token)
	| HappyErrorToken Int
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

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,664) ([0,50240,33280,24,0,0,4128,0,0,4096,4,34816,16392,1008,0,3140,34848,1,0,0,0,0,33617,57887,0,35200,3073,49,0,0,4096,0,0,0,8,0,0,2048,0,6280,4160,3,0,0,0,0,0,0,0,0,4,0,32768,12456,16132,0,17600,34304,31,0,0,2048,0,0,0,4,34816,16392,1008,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,8192,0,0,8192,61546,7235,0,0,0,0,0,64,0,0,3148,34942,3,0,0,128,0,0,24576,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,512,1,4352,6016,128,0,0,8320,0,21568,41496,31,0,8,0,0,512,0,0,0,0,2,0,34636,63521,1,0,0,0,0,0,16384,0,0,0,0,0,0,6144,0,8736,49408,15,4096,32785,2016,0,136,188,6,17408,32269,906,0,128,0,0,0,4,0,0,16,0,0,0,4096,0,24576,61562,7235,0,0,0,0,0,0,512,0,0,256,0,0,0,0,0,785,25096,0,34944,1025,49,0,0,0,0,544,752,16,4096,32817,1568,0,0,0,2,0,32,0,0,34,47,1,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,273,32264,0,34944,1024,63,0,0,0,0,8736,49408,15,0,0,1024,0,0,0,0,0,32,0,0,0,0,0,0,8192,0,0,512,0,0,4096,0,0,0,0,0,0,0,0,0,0,1,0,0,4096,256,0,1024,17,0,0,0,16384,0,2176,3008,64,0,0,0,0,32768,2048,0,0,0,0,0,136,188,4,17408,24064,512,0,0,0,0,4352,6016,128,0,0,0,0,0,0,0,0,512,0,0,0,0,0,34816,17166,1008,0,8,0,0,41472,4291,252,0,273,32264,0,0,0,0,0,1024,0,0,0,0,0,0,132,0,0,7816,4348,7,2048,0,0,0,1954,50239,1,4352,2051,98,32768,49576,28959,0,50240,33280,24,0,0,0,0,0,0,4,34816,16408,784,0,3140,34848,1,41472,20674,252,0,273,32264,0,0,0,0,0,0,4096,0,8736,49408,15,0,0,0,0,17408,0,0,2048,0,0,0,4352,0,0,4352,6016,128,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,4096,30721,2049,0,0,0,2,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32800,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_happyParseExp","%start_happyParseTypeContext","%start_happyParseEnv","%start_happyParseTerm","Start","exps","recExps","caseExps","inj","exp","prod","sum","type","typeContext","env","decl","terms","recTerms","caseTerms","term","'('","')'","'['","']'","'{'","'}'","'.'","','","'\955'","'\923'","':'","'->'","'=>'","'+'","'-'","'\8704'","INT","BOOL","UNIT","'case'","'<'","'>'","'='","'of'","'Empty'","'succ'","'pred'","'true'","'false'","NUM","ID","TyID","%eof"]
        bit_start = st * 55
        bit_end = (st + 1) * 55
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..54]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (23) = happyShift action_7
action_0 (27) = happyShift action_8
action_0 (31) = happyShift action_9
action_0 (32) = happyShift action_10
action_0 (42) = happyShift action_11
action_0 (48) = happyShift action_12
action_0 (52) = happyShift action_13
action_0 (53) = happyShift action_14
action_0 (11) = happyGoto action_5
action_0 (12) = happyGoto action_33
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (47) = happyShift action_31
action_1 (54) = happyShift action_32
action_1 (16) = happyGoto action_30
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (47) = happyShift action_28
action_2 (53) = happyShift action_29
action_2 (17) = happyGoto action_26
action_2 (18) = happyGoto action_27
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (23) = happyShift action_16
action_3 (27) = happyShift action_17
action_3 (31) = happyShift action_18
action_3 (42) = happyShift action_19
action_3 (48) = happyShift action_20
action_3 (49) = happyShift action_21
action_3 (50) = happyShift action_22
action_3 (51) = happyShift action_23
action_3 (52) = happyShift action_24
action_3 (53) = happyShift action_25
action_3 (22) = happyGoto action_15
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (23) = happyShift action_7
action_4 (27) = happyShift action_8
action_4 (31) = happyShift action_9
action_4 (32) = happyShift action_10
action_4 (42) = happyShift action_11
action_4 (48) = happyShift action_12
action_4 (52) = happyShift action_13
action_4 (53) = happyShift action_14
action_4 (11) = happyGoto action_5
action_4 (12) = happyGoto action_6
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_24

action_6 (23) = happyShift action_36
action_6 (27) = happyShift action_37
action_6 (29) = happyShift action_38
action_6 (31) = happyShift action_9
action_6 (32) = happyShift action_10
action_6 (38) = happyShift action_39
action_6 (39) = happyShift action_40
action_6 (40) = happyShift action_41
action_6 (41) = happyShift action_42
action_6 (42) = happyShift action_11
action_6 (43) = happyShift action_43
action_6 (48) = happyShift action_12
action_6 (52) = happyShift action_13
action_6 (53) = happyShift action_14
action_6 (54) = happyShift action_44
action_6 (11) = happyGoto action_5
action_6 (12) = happyGoto action_34
action_6 (15) = happyGoto action_35
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (23) = happyShift action_7
action_7 (24) = happyShift action_66
action_7 (27) = happyShift action_8
action_7 (31) = happyShift action_9
action_7 (32) = happyShift action_10
action_7 (42) = happyShift action_11
action_7 (43) = happyShift action_67
action_7 (48) = happyShift action_12
action_7 (52) = happyShift action_13
action_7 (53) = happyShift action_14
action_7 (11) = happyGoto action_5
action_7 (12) = happyGoto action_65
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (53) = happyShift action_64
action_8 (9) = happyGoto action_63
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (53) = happyShift action_62
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (54) = happyShift action_61
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (23) = happyShift action_7
action_11 (27) = happyShift action_8
action_11 (31) = happyShift action_9
action_11 (32) = happyShift action_10
action_11 (42) = happyShift action_11
action_11 (48) = happyShift action_12
action_11 (52) = happyShift action_13
action_11 (53) = happyShift action_14
action_11 (11) = happyGoto action_5
action_11 (12) = happyGoto action_60
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_28

action_13 _ = happyReduce_17

action_14 (33) = happyShift action_59
action_14 _ = happyReduce_16

action_15 (23) = happyShift action_16
action_15 (27) = happyShift action_17
action_15 (29) = happyShift action_56
action_15 (31) = happyShift action_18
action_15 (36) = happyShift action_57
action_15 (37) = happyShift action_58
action_15 (42) = happyShift action_19
action_15 (48) = happyShift action_20
action_15 (49) = happyShift action_21
action_15 (50) = happyShift action_22
action_15 (51) = happyShift action_23
action_15 (52) = happyShift action_24
action_15 (53) = happyShift action_25
action_15 (55) = happyAccept
action_15 (22) = happyGoto action_55
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (23) = happyShift action_16
action_16 (24) = happyShift action_53
action_16 (27) = happyShift action_17
action_16 (31) = happyShift action_18
action_16 (42) = happyShift action_19
action_16 (43) = happyShift action_54
action_16 (48) = happyShift action_20
action_16 (49) = happyShift action_21
action_16 (50) = happyShift action_22
action_16 (51) = happyShift action_23
action_16 (52) = happyShift action_24
action_16 (53) = happyShift action_25
action_16 (22) = happyGoto action_52
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (53) = happyShift action_51
action_17 (20) = happyGoto action_50
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (53) = happyShift action_49
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (23) = happyShift action_16
action_19 (27) = happyShift action_17
action_19 (31) = happyShift action_18
action_19 (42) = happyShift action_19
action_19 (48) = happyShift action_20
action_19 (49) = happyShift action_21
action_19 (50) = happyShift action_22
action_19 (51) = happyShift action_23
action_19 (52) = happyShift action_24
action_19 (53) = happyShift action_25
action_19 (22) = happyGoto action_48
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_68

action_21 _ = happyReduce_69

action_22 _ = happyReduce_72

action_23 _ = happyReduce_73

action_24 _ = happyReduce_59

action_25 _ = happyReduce_58

action_26 (55) = happyAccept
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (30) = happyShift action_47
action_27 _ = happyReduce_46

action_28 _ = happyReduce_48

action_29 (33) = happyShift action_46
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (55) = happyAccept
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_45

action_32 (30) = happyShift action_45
action_32 _ = happyReduce_43

action_33 (23) = happyShift action_36
action_33 (27) = happyShift action_37
action_33 (29) = happyShift action_38
action_33 (31) = happyShift action_9
action_33 (32) = happyShift action_10
action_33 (38) = happyShift action_39
action_33 (39) = happyShift action_40
action_33 (40) = happyShift action_41
action_33 (41) = happyShift action_42
action_33 (42) = happyShift action_11
action_33 (43) = happyShift action_43
action_33 (48) = happyShift action_12
action_33 (52) = happyShift action_13
action_33 (53) = happyShift action_14
action_33 (54) = happyShift action_44
action_33 (55) = happyAccept
action_33 (11) = happyGoto action_5
action_33 (12) = happyGoto action_34
action_33 (15) = happyGoto action_35
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (29) = happyShift action_38
action_34 (38) = happyShift action_39
action_34 (39) = happyShift action_40
action_34 (40) = happyShift action_41
action_34 (41) = happyShift action_42
action_34 (43) = happyShift action_43
action_34 (48) = happyShift action_12
action_34 (54) = happyShift action_44
action_34 (11) = happyGoto action_5
action_34 (12) = happyGoto action_34
action_34 (15) = happyGoto action_35
action_34 _ = happyReduce_21

action_35 (34) = happyShift action_103
action_35 _ = happyReduce_27

action_36 (23) = happyShift action_36
action_36 (24) = happyShift action_66
action_36 (27) = happyShift action_37
action_36 (31) = happyShift action_9
action_36 (32) = happyShift action_10
action_36 (38) = happyShift action_39
action_36 (39) = happyShift action_40
action_36 (40) = happyShift action_41
action_36 (41) = happyShift action_42
action_36 (42) = happyShift action_11
action_36 (43) = happyShift action_102
action_36 (48) = happyShift action_12
action_36 (52) = happyShift action_13
action_36 (53) = happyShift action_14
action_36 (54) = happyShift action_44
action_36 (11) = happyGoto action_5
action_36 (12) = happyGoto action_65
action_36 (15) = happyGoto action_101
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (53) = happyShift action_100
action_37 (9) = happyGoto action_63
action_37 (14) = happyGoto action_99
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (52) = happyShift action_97
action_38 (53) = happyShift action_98
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (54) = happyShift action_96
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_34

action_41 _ = happyReduce_35

action_42 _ = happyReduce_42

action_43 (53) = happyShift action_95
action_43 (14) = happyGoto action_94
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_36

action_45 (47) = happyShift action_31
action_45 (54) = happyShift action_32
action_45 (16) = happyGoto action_93
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (23) = happyShift action_77
action_46 (27) = happyShift action_78
action_46 (38) = happyShift action_39
action_46 (39) = happyShift action_40
action_46 (40) = happyShift action_41
action_46 (41) = happyShift action_42
action_46 (43) = happyShift action_43
action_46 (54) = happyShift action_44
action_46 (15) = happyGoto action_92
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (47) = happyShift action_28
action_47 (53) = happyShift action_29
action_47 (17) = happyGoto action_91
action_47 (18) = happyGoto action_27
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (23) = happyShift action_16
action_48 (27) = happyShift action_17
action_48 (29) = happyShift action_56
action_48 (31) = happyShift action_18
action_48 (36) = happyShift action_57
action_48 (37) = happyShift action_58
action_48 (42) = happyShift action_19
action_48 (46) = happyShift action_90
action_48 (48) = happyShift action_20
action_48 (49) = happyShift action_21
action_48 (50) = happyShift action_22
action_48 (51) = happyShift action_23
action_48 (52) = happyShift action_24
action_48 (53) = happyShift action_25
action_48 (22) = happyGoto action_55
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (29) = happyShift action_89
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (28) = happyShift action_88
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (45) = happyShift action_87
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (23) = happyShift action_16
action_52 (24) = happyShift action_85
action_52 (27) = happyShift action_17
action_52 (29) = happyShift action_56
action_52 (30) = happyShift action_86
action_52 (31) = happyShift action_18
action_52 (36) = happyShift action_57
action_52 (37) = happyShift action_58
action_52 (42) = happyShift action_19
action_52 (48) = happyShift action_20
action_52 (49) = happyShift action_21
action_52 (50) = happyShift action_22
action_52 (51) = happyShift action_23
action_52 (52) = happyShift action_24
action_52 (53) = happyShift action_25
action_52 (22) = happyGoto action_55
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_56

action_54 (53) = happyShift action_84
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (29) = happyShift action_56
action_55 (36) = happyShift action_57
action_55 (37) = happyShift action_58
action_55 (48) = happyShift action_20
action_55 (49) = happyShift action_21
action_55 (50) = happyShift action_22
action_55 (51) = happyShift action_23
action_55 (22) = happyGoto action_55
action_55 _ = happyReduce_63

action_56 (52) = happyShift action_82
action_56 (53) = happyShift action_83
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (23) = happyShift action_16
action_57 (27) = happyShift action_17
action_57 (31) = happyShift action_18
action_57 (42) = happyShift action_19
action_57 (48) = happyShift action_20
action_57 (49) = happyShift action_21
action_57 (50) = happyShift action_22
action_57 (51) = happyShift action_23
action_57 (52) = happyShift action_24
action_57 (53) = happyShift action_25
action_57 (22) = happyGoto action_81
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (23) = happyShift action_16
action_58 (27) = happyShift action_17
action_58 (31) = happyShift action_18
action_58 (42) = happyShift action_19
action_58 (48) = happyShift action_20
action_58 (49) = happyShift action_21
action_58 (50) = happyShift action_22
action_58 (51) = happyShift action_23
action_58 (52) = happyShift action_24
action_58 (53) = happyShift action_25
action_58 (22) = happyGoto action_80
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (23) = happyShift action_77
action_59 (27) = happyShift action_78
action_59 (38) = happyShift action_39
action_59 (39) = happyShift action_40
action_59 (40) = happyShift action_41
action_59 (41) = happyShift action_42
action_59 (43) = happyShift action_43
action_59 (53) = happyShift action_79
action_59 (54) = happyShift action_44
action_59 (15) = happyGoto action_76
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (23) = happyShift action_36
action_60 (27) = happyShift action_37
action_60 (29) = happyShift action_38
action_60 (31) = happyShift action_9
action_60 (32) = happyShift action_10
action_60 (38) = happyShift action_39
action_60 (39) = happyShift action_40
action_60 (40) = happyShift action_41
action_60 (41) = happyShift action_42
action_60 (42) = happyShift action_11
action_60 (43) = happyShift action_43
action_60 (46) = happyShift action_75
action_60 (48) = happyShift action_12
action_60 (52) = happyShift action_13
action_60 (53) = happyShift action_14
action_60 (54) = happyShift action_44
action_60 (11) = happyGoto action_5
action_60 (12) = happyGoto action_34
action_60 (15) = happyGoto action_35
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (29) = happyShift action_74
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (33) = happyShift action_73
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (28) = happyShift action_72
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (45) = happyShift action_71
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (23) = happyShift action_36
action_65 (24) = happyShift action_69
action_65 (27) = happyShift action_37
action_65 (29) = happyShift action_38
action_65 (30) = happyShift action_70
action_65 (31) = happyShift action_9
action_65 (32) = happyShift action_10
action_65 (38) = happyShift action_39
action_65 (39) = happyShift action_40
action_65 (40) = happyShift action_41
action_65 (41) = happyShift action_42
action_65 (42) = happyShift action_11
action_65 (43) = happyShift action_43
action_65 (48) = happyShift action_12
action_65 (52) = happyShift action_13
action_65 (53) = happyShift action_14
action_65 (54) = happyShift action_44
action_65 (11) = happyGoto action_5
action_65 (12) = happyGoto action_34
action_65 (15) = happyGoto action_35
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_12

action_67 (53) = happyShift action_68
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (45) = happyShift action_126
action_68 _ = happyFail (happyExpListPerState 68)

action_69 _ = happyReduce_13

action_70 (23) = happyShift action_7
action_70 (27) = happyShift action_8
action_70 (31) = happyShift action_9
action_70 (32) = happyShift action_10
action_70 (42) = happyShift action_11
action_70 (48) = happyShift action_12
action_70 (52) = happyShift action_13
action_70 (53) = happyShift action_14
action_70 (8) = happyGoto action_124
action_70 (11) = happyGoto action_5
action_70 (12) = happyGoto action_125
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (23) = happyShift action_7
action_71 (27) = happyShift action_8
action_71 (31) = happyShift action_9
action_71 (32) = happyShift action_10
action_71 (42) = happyShift action_11
action_71 (48) = happyShift action_12
action_71 (52) = happyShift action_13
action_71 (53) = happyShift action_14
action_71 (11) = happyGoto action_5
action_71 (12) = happyGoto action_123
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_22

action_73 (23) = happyShift action_77
action_73 (27) = happyShift action_78
action_73 (38) = happyShift action_39
action_73 (39) = happyShift action_40
action_73 (40) = happyShift action_41
action_73 (41) = happyShift action_42
action_73 (43) = happyShift action_43
action_73 (54) = happyShift action_44
action_73 (15) = happyGoto action_122
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (23) = happyShift action_7
action_74 (27) = happyShift action_8
action_74 (31) = happyShift action_9
action_74 (32) = happyShift action_10
action_74 (42) = happyShift action_11
action_74 (48) = happyShift action_12
action_74 (52) = happyShift action_13
action_74 (53) = happyShift action_14
action_74 (11) = happyGoto action_5
action_74 (12) = happyGoto action_121
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (53) = happyShift action_120
action_75 (10) = happyGoto action_119
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (34) = happyShift action_103
action_76 _ = happyReduce_14

action_77 (23) = happyShift action_77
action_77 (27) = happyShift action_78
action_77 (38) = happyShift action_39
action_77 (39) = happyShift action_40
action_77 (40) = happyShift action_41
action_77 (41) = happyShift action_42
action_77 (43) = happyShift action_43
action_77 (54) = happyShift action_44
action_77 (15) = happyGoto action_101
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (53) = happyShift action_95
action_78 (14) = happyGoto action_99
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_15

action_80 (23) = happyShift action_16
action_80 (27) = happyShift action_17
action_80 (29) = happyShift action_56
action_80 (31) = happyShift action_18
action_80 (36) = happyShift action_57
action_80 (37) = happyShift action_58
action_80 (42) = happyShift action_19
action_80 (48) = happyShift action_20
action_80 (49) = happyShift action_21
action_80 (50) = happyShift action_22
action_80 (51) = happyShift action_23
action_80 (52) = happyShift action_24
action_80 (53) = happyShift action_25
action_80 (22) = happyGoto action_55
action_80 _ = happyReduce_71

action_81 (23) = happyShift action_16
action_81 (27) = happyShift action_17
action_81 (29) = happyShift action_56
action_81 (31) = happyShift action_18
action_81 (36) = happyShift action_57
action_81 (37) = happyShift action_58
action_81 (42) = happyShift action_19
action_81 (48) = happyShift action_20
action_81 (49) = happyShift action_21
action_81 (50) = happyShift action_22
action_81 (51) = happyShift action_23
action_81 (52) = happyShift action_24
action_81 (53) = happyShift action_25
action_81 (22) = happyGoto action_55
action_81 _ = happyReduce_70

action_82 _ = happyReduce_62

action_83 _ = happyReduce_65

action_84 (45) = happyShift action_118
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_57

action_86 (23) = happyShift action_16
action_86 (27) = happyShift action_17
action_86 (31) = happyShift action_18
action_86 (42) = happyShift action_19
action_86 (48) = happyShift action_20
action_86 (49) = happyShift action_21
action_86 (50) = happyShift action_22
action_86 (51) = happyShift action_23
action_86 (52) = happyShift action_24
action_86 (53) = happyShift action_25
action_86 (19) = happyGoto action_116
action_86 (22) = happyGoto action_117
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (23) = happyShift action_16
action_87 (27) = happyShift action_17
action_87 (31) = happyShift action_18
action_87 (42) = happyShift action_19
action_87 (48) = happyShift action_20
action_87 (49) = happyShift action_21
action_87 (50) = happyShift action_22
action_87 (51) = happyShift action_23
action_87 (52) = happyShift action_24
action_87 (53) = happyShift action_25
action_87 (22) = happyGoto action_115
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_64

action_89 (23) = happyShift action_16
action_89 (27) = happyShift action_17
action_89 (31) = happyShift action_18
action_89 (42) = happyShift action_19
action_89 (48) = happyShift action_20
action_89 (49) = happyShift action_21
action_89 (50) = happyShift action_22
action_89 (51) = happyShift action_23
action_89 (52) = happyShift action_24
action_89 (53) = happyShift action_25
action_89 (22) = happyGoto action_114
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (53) = happyShift action_113
action_90 (21) = happyGoto action_112
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_47

action_92 (34) = happyShift action_103
action_92 _ = happyReduce_49

action_93 _ = happyReduce_44

action_94 (44) = happyShift action_111
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (33) = happyShift action_108
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (29) = happyShift action_110
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_20

action_98 _ = happyReduce_23

action_99 (28) = happyShift action_109
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (33) = happyShift action_108
action_100 (45) = happyShift action_71
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (24) = happyShift action_106
action_101 (30) = happyShift action_107
action_101 (34) = happyShift action_103
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (53) = happyShift action_105
action_102 (14) = happyGoto action_94
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (23) = happyShift action_77
action_103 (27) = happyShift action_78
action_103 (38) = happyShift action_39
action_103 (39) = happyShift action_40
action_103 (40) = happyShift action_41
action_103 (41) = happyShift action_42
action_103 (43) = happyShift action_43
action_103 (54) = happyShift action_44
action_103 (15) = happyGoto action_104
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (34) = happyShift action_103
action_104 _ = happyReduce_37

action_105 (33) = happyShift action_108
action_105 (45) = happyShift action_126
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_33

action_107 (23) = happyShift action_77
action_107 (27) = happyShift action_78
action_107 (38) = happyShift action_39
action_107 (39) = happyShift action_40
action_107 (40) = happyShift action_41
action_107 (41) = happyShift action_42
action_107 (43) = happyShift action_43
action_107 (54) = happyShift action_44
action_107 (13) = happyGoto action_140
action_107 (15) = happyGoto action_141
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (23) = happyShift action_77
action_108 (27) = happyShift action_78
action_108 (38) = happyShift action_39
action_108 (39) = happyShift action_40
action_108 (40) = happyShift action_41
action_108 (41) = happyShift action_42
action_108 (43) = happyShift action_43
action_108 (54) = happyShift action_44
action_108 (15) = happyGoto action_139
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_39

action_110 (23) = happyShift action_77
action_110 (27) = happyShift action_78
action_110 (38) = happyShift action_39
action_110 (39) = happyShift action_40
action_110 (40) = happyShift action_41
action_110 (41) = happyShift action_42
action_110 (43) = happyShift action_43
action_110 (54) = happyShift action_44
action_110 (15) = happyGoto action_138
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_40

action_112 _ = happyReduce_67

action_113 (35) = happyShift action_137
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (23) = happyShift action_16
action_114 (27) = happyShift action_17
action_114 (29) = happyShift action_56
action_114 (31) = happyShift action_18
action_114 (36) = happyShift action_57
action_114 (37) = happyShift action_58
action_114 (42) = happyShift action_19
action_114 (48) = happyShift action_20
action_114 (49) = happyShift action_21
action_114 (50) = happyShift action_22
action_114 (51) = happyShift action_23
action_114 (52) = happyShift action_24
action_114 (53) = happyShift action_25
action_114 (22) = happyGoto action_55
action_114 _ = happyReduce_60

action_115 (23) = happyShift action_16
action_115 (27) = happyShift action_17
action_115 (29) = happyShift action_56
action_115 (30) = happyShift action_136
action_115 (31) = happyShift action_18
action_115 (36) = happyShift action_57
action_115 (37) = happyShift action_58
action_115 (42) = happyShift action_19
action_115 (48) = happyShift action_20
action_115 (49) = happyShift action_21
action_115 (50) = happyShift action_22
action_115 (51) = happyShift action_23
action_115 (52) = happyShift action_24
action_115 (53) = happyShift action_25
action_115 (22) = happyGoto action_55
action_115 _ = happyReduce_52

action_116 (24) = happyShift action_135
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (23) = happyShift action_16
action_117 (27) = happyShift action_17
action_117 (29) = happyShift action_56
action_117 (30) = happyShift action_134
action_117 (31) = happyShift action_18
action_117 (36) = happyShift action_57
action_117 (37) = happyShift action_58
action_117 (42) = happyShift action_19
action_117 (48) = happyShift action_20
action_117 (49) = happyShift action_21
action_117 (50) = happyShift action_22
action_117 (51) = happyShift action_23
action_117 (52) = happyShift action_24
action_117 (53) = happyShift action_25
action_117 (22) = happyGoto action_55
action_117 _ = happyReduce_50

action_118 (23) = happyShift action_16
action_118 (27) = happyShift action_17
action_118 (31) = happyShift action_18
action_118 (42) = happyShift action_19
action_118 (48) = happyShift action_20
action_118 (49) = happyShift action_21
action_118 (50) = happyShift action_22
action_118 (51) = happyShift action_23
action_118 (52) = happyShift action_24
action_118 (53) = happyShift action_25
action_118 (22) = happyGoto action_133
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_25

action_120 (35) = happyShift action_132
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (23) = happyShift action_36
action_121 (27) = happyShift action_37
action_121 (29) = happyShift action_38
action_121 (31) = happyShift action_9
action_121 (32) = happyShift action_10
action_121 (38) = happyShift action_39
action_121 (39) = happyShift action_40
action_121 (40) = happyShift action_41
action_121 (41) = happyShift action_42
action_121 (42) = happyShift action_11
action_121 (43) = happyShift action_43
action_121 (48) = happyShift action_12
action_121 (52) = happyShift action_13
action_121 (53) = happyShift action_14
action_121 (54) = happyShift action_44
action_121 (11) = happyGoto action_5
action_121 (12) = happyGoto action_34
action_121 (15) = happyGoto action_35
action_121 _ = happyReduce_26

action_122 (29) = happyShift action_131
action_122 (34) = happyShift action_103
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (23) = happyShift action_36
action_123 (27) = happyShift action_37
action_123 (29) = happyShift action_38
action_123 (30) = happyShift action_130
action_123 (31) = happyShift action_9
action_123 (32) = happyShift action_10
action_123 (38) = happyShift action_39
action_123 (39) = happyShift action_40
action_123 (40) = happyShift action_41
action_123 (41) = happyShift action_42
action_123 (42) = happyShift action_11
action_123 (43) = happyShift action_43
action_123 (48) = happyShift action_12
action_123 (52) = happyShift action_13
action_123 (53) = happyShift action_14
action_123 (54) = happyShift action_44
action_123 (11) = happyGoto action_5
action_123 (12) = happyGoto action_34
action_123 (15) = happyGoto action_35
action_123 _ = happyReduce_7

action_124 (24) = happyShift action_129
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (23) = happyShift action_36
action_125 (27) = happyShift action_37
action_125 (29) = happyShift action_38
action_125 (30) = happyShift action_128
action_125 (31) = happyShift action_9
action_125 (32) = happyShift action_10
action_125 (38) = happyShift action_39
action_125 (39) = happyShift action_40
action_125 (40) = happyShift action_41
action_125 (41) = happyShift action_42
action_125 (42) = happyShift action_11
action_125 (43) = happyShift action_43
action_125 (48) = happyShift action_12
action_125 (52) = happyShift action_13
action_125 (53) = happyShift action_14
action_125 (54) = happyShift action_44
action_125 (11) = happyGoto action_5
action_125 (12) = happyGoto action_34
action_125 (15) = happyGoto action_35
action_125 _ = happyReduce_5

action_126 (23) = happyShift action_7
action_126 (27) = happyShift action_8
action_126 (31) = happyShift action_9
action_126 (32) = happyShift action_10
action_126 (42) = happyShift action_11
action_126 (48) = happyShift action_12
action_126 (52) = happyShift action_13
action_126 (53) = happyShift action_14
action_126 (11) = happyGoto action_5
action_126 (12) = happyGoto action_127
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (23) = happyShift action_36
action_127 (27) = happyShift action_37
action_127 (29) = happyShift action_38
action_127 (31) = happyShift action_9
action_127 (32) = happyShift action_10
action_127 (38) = happyShift action_39
action_127 (39) = happyShift action_40
action_127 (40) = happyShift action_41
action_127 (41) = happyShift action_42
action_127 (42) = happyShift action_11
action_127 (43) = happyShift action_43
action_127 (44) = happyShift action_153
action_127 (48) = happyShift action_12
action_127 (52) = happyShift action_13
action_127 (53) = happyShift action_14
action_127 (54) = happyShift action_44
action_127 (11) = happyGoto action_5
action_127 (12) = happyGoto action_34
action_127 (15) = happyGoto action_35
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (23) = happyShift action_7
action_128 (27) = happyShift action_8
action_128 (31) = happyShift action_9
action_128 (32) = happyShift action_10
action_128 (42) = happyShift action_11
action_128 (48) = happyShift action_12
action_128 (52) = happyShift action_13
action_128 (53) = happyShift action_14
action_128 (8) = happyGoto action_152
action_128 (11) = happyGoto action_5
action_128 (12) = happyGoto action_125
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_19

action_130 (53) = happyShift action_64
action_130 (9) = happyGoto action_151
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (23) = happyShift action_7
action_131 (27) = happyShift action_8
action_131 (31) = happyShift action_9
action_131 (32) = happyShift action_10
action_131 (42) = happyShift action_11
action_131 (48) = happyShift action_12
action_131 (52) = happyShift action_13
action_131 (53) = happyShift action_14
action_131 (11) = happyGoto action_5
action_131 (12) = happyGoto action_150
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (23) = happyShift action_7
action_132 (27) = happyShift action_8
action_132 (31) = happyShift action_9
action_132 (32) = happyShift action_10
action_132 (42) = happyShift action_11
action_132 (48) = happyShift action_12
action_132 (52) = happyShift action_13
action_132 (53) = happyShift action_14
action_132 (11) = happyGoto action_5
action_132 (12) = happyGoto action_149
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (23) = happyShift action_16
action_133 (27) = happyShift action_17
action_133 (29) = happyShift action_56
action_133 (31) = happyShift action_18
action_133 (36) = happyShift action_57
action_133 (37) = happyShift action_58
action_133 (42) = happyShift action_19
action_133 (44) = happyShift action_148
action_133 (48) = happyShift action_20
action_133 (49) = happyShift action_21
action_133 (50) = happyShift action_22
action_133 (51) = happyShift action_23
action_133 (52) = happyShift action_24
action_133 (53) = happyShift action_25
action_133 (22) = happyGoto action_55
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (23) = happyShift action_16
action_134 (27) = happyShift action_17
action_134 (31) = happyShift action_18
action_134 (42) = happyShift action_19
action_134 (48) = happyShift action_20
action_134 (49) = happyShift action_21
action_134 (50) = happyShift action_22
action_134 (51) = happyShift action_23
action_134 (52) = happyShift action_24
action_134 (53) = happyShift action_25
action_134 (19) = happyGoto action_147
action_134 (22) = happyGoto action_117
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_61

action_136 (53) = happyShift action_51
action_136 (20) = happyGoto action_146
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (23) = happyShift action_16
action_137 (27) = happyShift action_17
action_137 (31) = happyShift action_18
action_137 (42) = happyShift action_19
action_137 (48) = happyShift action_20
action_137 (49) = happyShift action_21
action_137 (50) = happyShift action_22
action_137 (51) = happyShift action_23
action_137 (52) = happyShift action_24
action_137 (53) = happyShift action_25
action_137 (22) = happyGoto action_145
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (34) = happyShift action_103
action_138 _ = happyReduce_41

action_139 (30) = happyShift action_144
action_139 (34) = happyShift action_103
action_139 _ = happyReduce_31

action_140 (24) = happyShift action_143
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (30) = happyShift action_142
action_141 (34) = happyShift action_103
action_141 _ = happyReduce_29

action_142 (23) = happyShift action_77
action_142 (27) = happyShift action_78
action_142 (38) = happyShift action_39
action_142 (39) = happyShift action_40
action_142 (40) = happyShift action_41
action_142 (41) = happyShift action_42
action_142 (43) = happyShift action_43
action_142 (54) = happyShift action_44
action_142 (13) = happyGoto action_159
action_142 (15) = happyGoto action_141
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_38

action_144 (53) = happyShift action_95
action_144 (14) = happyGoto action_158
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (23) = happyShift action_16
action_145 (27) = happyShift action_17
action_145 (29) = happyShift action_56
action_145 (30) = happyShift action_157
action_145 (31) = happyShift action_18
action_145 (36) = happyShift action_57
action_145 (37) = happyShift action_58
action_145 (42) = happyShift action_19
action_145 (48) = happyShift action_20
action_145 (49) = happyShift action_21
action_145 (50) = happyShift action_22
action_145 (51) = happyShift action_23
action_145 (52) = happyShift action_24
action_145 (53) = happyShift action_25
action_145 (22) = happyGoto action_55
action_145 _ = happyReduce_54

action_146 _ = happyReduce_53

action_147 _ = happyReduce_51

action_148 (24) = happyShift action_156
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (23) = happyShift action_36
action_149 (27) = happyShift action_37
action_149 (29) = happyShift action_38
action_149 (30) = happyShift action_155
action_149 (31) = happyShift action_9
action_149 (32) = happyShift action_10
action_149 (38) = happyShift action_39
action_149 (39) = happyShift action_40
action_149 (40) = happyShift action_41
action_149 (41) = happyShift action_42
action_149 (42) = happyShift action_11
action_149 (43) = happyShift action_43
action_149 (48) = happyShift action_12
action_149 (52) = happyShift action_13
action_149 (53) = happyShift action_14
action_149 (54) = happyShift action_44
action_149 (11) = happyGoto action_5
action_149 (12) = happyGoto action_34
action_149 (15) = happyGoto action_35
action_149 _ = happyReduce_9

action_150 (23) = happyShift action_36
action_150 (27) = happyShift action_37
action_150 (29) = happyShift action_38
action_150 (31) = happyShift action_9
action_150 (32) = happyShift action_10
action_150 (38) = happyShift action_39
action_150 (39) = happyShift action_40
action_150 (40) = happyShift action_41
action_150 (41) = happyShift action_42
action_150 (42) = happyShift action_11
action_150 (43) = happyShift action_43
action_150 (48) = happyShift action_12
action_150 (52) = happyShift action_13
action_150 (53) = happyShift action_14
action_150 (54) = happyShift action_44
action_150 (11) = happyGoto action_5
action_150 (12) = happyGoto action_34
action_150 (15) = happyGoto action_35
action_150 _ = happyReduce_18

action_151 _ = happyReduce_8

action_152 _ = happyReduce_6

action_153 (33) = happyShift action_154
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (23) = happyShift action_77
action_154 (27) = happyShift action_78
action_154 (38) = happyShift action_39
action_154 (39) = happyShift action_40
action_154 (40) = happyShift action_41
action_154 (41) = happyShift action_42
action_154 (43) = happyShift action_43
action_154 (54) = happyShift action_44
action_154 (15) = happyGoto action_162
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (53) = happyShift action_120
action_155 (10) = happyGoto action_161
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_66

action_157 (53) = happyShift action_113
action_157 (21) = happyGoto action_160
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_32

action_159 _ = happyReduce_30

action_160 _ = happyReduce_55

action_161 _ = happyReduce_10

action_162 (24) = happyShift action_163
action_162 (34) = happyShift action_103
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_11

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  8 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  9 happyReduction_7
happyReduction_7 (HappyAbsSyn12  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn9
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 5 9 happyReduction_8
happyReduction_8 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_3  10 happyReduction_9
happyReduction_9 (HappyAbsSyn12  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn10
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 5 10 happyReduction_10
happyReduction_10 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 9 11 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Inj happy_var_3 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_2  12 happyReduction_12
happyReduction_12 _
	_
	 =  HappyAbsSyn12
		 (U
	)

happyReduce_13 = happySpecReduce_3  12 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  12 happyReduction_14
happyReduction_14 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn12
		 (C happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  12 happyReduction_15
happyReduction_15 (HappyTerminal (ID happy_var_3))
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn12
		 (C happy_var_1 (TyVar happy_var_3)
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  12 happyReduction_16
happyReduction_16 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn12
		 (V happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  12 happyReduction_17
happyReduction_17 (HappyTerminal (Num happy_var_1))
	 =  HappyAbsSyn12
		 (N happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 6 12 happyReduction_18
happyReduction_18 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (L happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 5 12 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (T (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  12 happyReduction_20
happyReduction_20 (HappyTerminal (Num happy_var_3))
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (P happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  12 happyReduction_21
happyReduction_21 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (A happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  12 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (R happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  12 happyReduction_23
happyReduction_23 (HappyTerminal (ID happy_var_3))
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (F happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  12 happyReduction_24
happyReduction_24 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happyReduce 4 12 happyReduction_25
happyReduction_25 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 4 12 happyReduction_26
happyReduction_26 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TyID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (TyL happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_2  12 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (TyA happy_var_1 happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  12 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn12
		 (TyL "T1" (TyL "T2" (TyL "T3" (L "n" (((TyVar "T1") :=> (TyVar "T2")) :=> ((TyVar "T3") :=> (TyVar "T1"))) (L "f" ((TyVar "T1") :=> (TyVar "T2")) (L "x" (TyVar "T3") (A (V "f") (A (A (V "n") (V "f")) (V "x"))))))))
	)

happyReduce_29 = happySpecReduce_1  13 happyReduction_29
happyReduction_29 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  13 happyReduction_30
happyReduction_30 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  14 happyReduction_31
happyReduction_31 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn14
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happyReduce 5 14 happyReduction_32
happyReduction_32 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_3  15 happyReduction_33
happyReduction_33 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  15 happyReduction_34
happyReduction_34 _
	 =  HappyAbsSyn15
		 (INT
	)

happyReduce_35 = happySpecReduce_1  15 happyReduction_35
happyReduction_35 _
	 =  HappyAbsSyn15
		 (BOOL
	)

happyReduce_36 = happySpecReduce_1  15 happyReduction_36
happyReduction_36 (HappyTerminal (TyID happy_var_1))
	 =  HappyAbsSyn15
		 (TyVar happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 :=> happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happyReduce 5 15 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Prod (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_3  15 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (Rec happy_var_2
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  15 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (Var happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 4 15 happyReduction_41
happyReduction_41 ((HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TyID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Poly happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_1  15 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn15
		 (Unit
	)

happyReduce_43 = happySpecReduce_1  16 happyReduction_43
happyReduction_43 (HappyTerminal (TyID happy_var_1))
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  16 happyReduction_44
happyReduction_44 (HappyAbsSyn16  happy_var_3)
	_
	(HappyTerminal (TyID happy_var_1))
	 =  HappyAbsSyn16
		 (happy_var_1 : happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  16 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn16
		 ([]
	)

happyReduce_46 = happySpecReduce_1  17 happyReduction_46
happyReduction_46 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  17 happyReduction_47
happyReduction_47 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 : happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  17 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn17
		 ([]
	)

happyReduce_49 = happySpecReduce_3  18 happyReduction_49
happyReduction_49 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn18
		 ((happy_var_1,happy_var_3)
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  19 happyReduction_50
happyReduction_50 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  19 happyReduction_51
happyReduction_51 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 : happy_var_3
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  20 happyReduction_52
happyReduction_52 (HappyAbsSyn22  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn20
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happyReduce 5 20 happyReduction_53
happyReduction_53 ((HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_3  21 happyReduction_54
happyReduction_54 (HappyAbsSyn22  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn21
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happyReduce 5 21 happyReduction_55
happyReduction_55 ((HappyAbsSyn21  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_56 = happySpecReduce_2  22 happyReduction_56
happyReduction_56 _
	_
	 =  HappyAbsSyn22
		 (U
	)

happyReduce_57 = happySpecReduce_3  22 happyReduction_57
happyReduction_57 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (happy_var_2
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  22 happyReduction_58
happyReduction_58 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn22
		 (V happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  22 happyReduction_59
happyReduction_59 (HappyTerminal (Num happy_var_1))
	 =  HappyAbsSyn22
		 (N happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happyReduce 4 22 happyReduction_60
happyReduction_60 ((HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (L happy_var_2 Unit happy_var_4
	) `HappyStk` happyRest

happyReduce_61 = happyReduce 5 22 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (T (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_62 = happySpecReduce_3  22 happyReduction_62
happyReduction_62 (HappyTerminal (Num happy_var_3))
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (P happy_var_1 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_2  22 happyReduction_63
happyReduction_63 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (A happy_var_1 happy_var_2
	)
happyReduction_63 _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  22 happyReduction_64
happyReduction_64 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (R happy_var_2
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  22 happyReduction_65
happyReduction_65 (HappyTerminal (ID happy_var_3))
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (F happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happyReduce 7 22 happyReduction_66
happyReduction_66 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Inj happy_var_3 happy_var_5 Unit
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 4 22 happyReduction_67
happyReduction_67 ((HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_68 = happySpecReduce_1  22 happyReduction_68
happyReduction_68 _
	 =  HappyAbsSyn22
		 (L "n" Unit (L "f" Unit (L "x" Unit (A (V "f") (A (A (V "n") (V "f")) (V "x")))))
	)

happyReduce_69 = happySpecReduce_1  22 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn22
		 (L "n" Unit (L "f" Unit (L "x" Unit (A (A (A (V "n") (L "g" Unit (L "h" Unit (A (V "h") (A (V "g") (V "f")))))) (L "u" Unit (V "x"))) (L "u" Unit (V "u")))))
	)

happyReduce_70 = happySpecReduce_3  22 happyReduction_70
happyReduction_70 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (A (A (L "m" Unit (L "n" Unit (A (A (V "m") (L "n" Unit (L "f" Unit (L "x" Unit (A (V "f") (A (A (V "n") (V "f")) (V "x"))))))) (V "n")))) happy_var_1) happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  22 happyReduction_71
happyReduction_71 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (A (A (L "m" Unit (L "n" Unit (A (A (V "n") ((L "n" Unit (L "f" Unit (L "x" Unit (A (A (A (V "n") (L "g" Unit (L "h" Unit (A (V "h") (A (V "g") (V "f")))))) (L "u" Unit (V "x"))) (L "u" Unit (V "u")))))))) (V "m")))) happy_var_1) happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  22 happyReduction_72
happyReduction_72 _
	 =  HappyAbsSyn22
		 ((L "x" Unit (L "y" Unit (V "x")))
	)

happyReduce_73 = happySpecReduce_1  22 happyReduction_73
happyReduction_73 _
	 =  HappyAbsSyn22
		 ((L "x" Unit (L "y" Unit (V "y")))
	)

happyNewToken action sts stk [] =
	action 55 55 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	LPar -> cont 23;
	RPar -> cont 24;
	LSBracket -> cont 25;
	RSBracket -> cont 26;
	LBrace -> cont 27;
	RBrace -> cont 28;
	TDot -> cont 29;
	TCom -> cont 30;
	TLam -> cont 31;
	TLLam -> cont 32;
	TCol -> cont 33;
	TArrow -> cont 34;
	TLArrow -> cont 35;
	TPlus -> cont 36;
	TMinus -> cont 37;
	TAll -> cont 38;
	TINT -> cont 39;
	TBOOL -> cont 40;
	TUNIT -> cont 41;
	TCase -> cont 42;
	LAngle -> cont 43;
	RAngle -> cont 44;
	TEqual -> cont 45;
	TOf -> cont 46;
	Empty -> cont 47;
	TSucc -> cont 48;
	TPred -> cont 49;
	TTrue -> cont 50;
	TFalse -> cont 51;
	Num happy_dollar_dollar -> cont 52;
	ID happy_dollar_dollar -> cont 53;
	TyID happy_dollar_dollar -> cont 54;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 55 tk tks = happyError' (tks, explist)
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
happyParseExp tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn12 z -> happyReturn z; _other -> notHappyAtAll })

happyParseTypeContext tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn16 z -> happyReturn z; _other -> notHappyAtAll })

happyParseEnv tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn17 z -> happyReturn z; _other -> notHappyAtAll })

happyParseTerm tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_3 tks) (\x -> case x of {HappyAbsSyn22 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError [] = error "Parse error at EOF"
parseError (t:ts) = error $ "Parse error: " ++ show t

parseExp         = happyParseExp . alexScanTokens
parseTypeContext = happyParseTypeContext . alexScanTokens
parseEnv         = happyParseEnv . alexScanTokens
parseTerm        = happyParseTerm . alexScanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8336_0/ghc_2.h" #-}
































































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
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

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

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

{-# LINE 333 "templates/GenericTemplate.hs" #-}
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
