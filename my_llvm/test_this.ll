@.Main_vtable = global [0 x i8*] []

@.A_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*)* @A.InitA to i8*),
	i8* bitcast (i32 (i8*)* @A.f1 to i8*)
]

@.B_vtable = global [4 x i8*] [
	i8* bitcast (i32 (i8*)* @A.InitA to i8*),
	i8* bitcast (i32 (i8*)* @A.f1 to i8*),
	i8* bitcast (i32 (i8*)* @B.InitB to i8*),
	i8* bitcast (i32 (i8*)* @B.f2 to i8*)
]

@.C_vtable = global [6 x i8*] [
	i8* bitcast (i32 (i8*)* @A.InitA to i8*),
	i8* bitcast (i32 (i8*)* @A.f1 to i8*),
	i8* bitcast (i32 (i8*)* @B.InitB to i8*),
	i8* bitcast (i32 (i8*)* @B.f2 to i8*),
	i8* bitcast (i32 (i8*)* @C.InitC to i8*),
	i8* bitcast (i32 (i8*)* @C.f3 to i8*)
]

@.D_vtable = global [8 x i8*] [
	i8* bitcast (i32 (i8*)* @A.InitA to i8*),
	i8* bitcast (i32 (i8*)* @A.f1 to i8*),
	i8* bitcast (i32 (i8*)* @B.InitB to i8*),
	i8* bitcast (i32 (i8*)* @B.f2 to i8*),
	i8* bitcast (i32 (i8*)* @C.InitC to i8*),
	i8* bitcast (i32 (i8*)* @C.f3 to i8*),
	i8* bitcast (i32 (i8*)* @D.InitD to i8*),
	i8* bitcast (i32 (i8*)* @D.f4 to i8*)
]

@.E_vtable = global [10 x i8*] [
	i8* bitcast (i32 (i8*)* @A.InitA to i8*),
	i8* bitcast (i32 (i8*)* @A.f1 to i8*),
	i8* bitcast (i32 (i8*)* @B.InitB to i8*),
	i8* bitcast (i32 (i8*)* @B.f2 to i8*),
	i8* bitcast (i32 (i8*)* @C.InitC to i8*),
	i8* bitcast (i32 (i8*)* @C.f3 to i8*),
	i8* bitcast (i32 (i8*)* @D.InitD to i8*),
	i8* bitcast (i32 (i8*)* @D.f4 to i8*),
	i8* bitcast (i32 (i8*)* @E.InitE to i8*),
	i8* bitcast (i32 (i8*)* @E.f5 to i8*)
]

@.F_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*, i8*)* @F.InitF to i8*)
]

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
@_cNSZ = constant [15 x i8] c"Negative size\0a\00"

define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}

define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define void @throw_nsz() {
	%_str = bitcast [15 x i8]* @_cNSZ to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define i32 @main() {
	%e = alloca i8*
	%f = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 28)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [10 x i8*], [10 x i8*]* @.E_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %e

	%_3 = call i8* @calloc(i32 1, i32 16)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.F_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	store i8* %_3, i8** %f

	%_6 = load i8*, i8** %e
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 8
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %_6)
	call void (i32) @print_int(i32 %_12)

	%_14 = load i8*, i8** %e
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 9
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_14)
	call void (i32) @print_int(i32 %_20)

	%_22 = load i8*, i8** %f
	%_23 = load i8*, i8** %e
	%_24 = bitcast i8* %_22 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 0
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*, i8*)*
	%_29 = call i32 %_28(i8* %_22, i8* %_23)
	call void (i32) @print_int(i32 %_29)

	ret i32 0
}

define i32 @A.InitA(i8* %this) {

	%_31 = getelementptr i8, i8* %this, i32 8
	%_32 = bitcast i8* %_31 to i32*
	store i32 1024, i32* %_32

	%_34 = getelementptr i8, i8* %this, i32 8
	%_35 = bitcast i8* %_34 to i32*
	%_33 = load i32, i32* %_35
	ret i32 %_33
}

define i32 @A.f1(i8* %this) {

	ret i32 1
}

define i32 @B.InitB(i8* %this) {

	%_36 = getelementptr i8, i8* %this, i32 12
	%_37 = bitcast i8* %_36 to i32*
	store i32 2048, i32* %_37

	%_39 = getelementptr i8, i8* %this, i32 12
	%_40 = bitcast i8* %_39 to i32*
	%_38 = load i32, i32* %_40
	%_41 = bitcast i8* %this to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 0
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i32 (i8*)*
	%_46 = call i32 %_45(i8* %this)
	%_48 = add i32 %_38, %_46
	ret i32 %_48
}

define i32 @B.f2(i8* %this) {

	%_49 = bitcast i8* %this to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 1
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i32 (i8*)*
	%_54 = call i32 %_53(i8* %this)
	%_56 = add i32 2, %_54
	ret i32 %_56
}

define i32 @C.InitC(i8* %this) {

	%_57 = getelementptr i8, i8* %this, i32 16
	%_58 = bitcast i8* %_57 to i32*
	store i32 4096, i32* %_58

	%_60 = getelementptr i8, i8* %this, i32 16
	%_61 = bitcast i8* %_60 to i32*
	%_59 = load i32, i32* %_61
	%_62 = bitcast i8* %this to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 2
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i32 (i8*)*
	%_67 = call i32 %_66(i8* %this)
	%_69 = add i32 %_59, %_67
	ret i32 %_69
}

define i32 @C.f3(i8* %this) {

	%_70 = bitcast i8* %this to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 3
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i32 (i8*)*
	%_75 = call i32 %_74(i8* %this)
	%_77 = add i32 3, %_75
	ret i32 %_77
}

define i32 @D.InitD(i8* %this) {

	%_78 = getelementptr i8, i8* %this, i32 20
	%_79 = bitcast i8* %_78 to i32*
	store i32 8192, i32* %_79

	%_81 = getelementptr i8, i8* %this, i32 20
	%_82 = bitcast i8* %_81 to i32*
	%_80 = load i32, i32* %_82
	%_83 = bitcast i8* %this to i8***
	%_84 = load i8**, i8*** %_83
	%_85 = getelementptr i8*, i8** %_84, i32 4
	%_86 = load i8*, i8** %_85
	%_87 = bitcast i8* %_86 to i32 (i8*)*
	%_88 = call i32 %_87(i8* %this)
	%_90 = add i32 %_80, %_88
	ret i32 %_90
}

define i32 @D.f4(i8* %this) {

	%_91 = bitcast i8* %this to i8***
	%_92 = load i8**, i8*** %_91
	%_93 = getelementptr i8*, i8** %_92, i32 5
	%_94 = load i8*, i8** %_93
	%_95 = bitcast i8* %_94 to i32 (i8*)*
	%_96 = call i32 %_95(i8* %this)
	%_98 = add i32 4, %_96
	ret i32 %_98
}

define i32 @E.InitE(i8* %this) {

	%_99 = getelementptr i8, i8* %this, i32 24
	%_100 = bitcast i8* %_99 to i32*
	store i32 16384, i32* %_100

	%_102 = getelementptr i8, i8* %this, i32 24
	%_103 = bitcast i8* %_102 to i32*
	%_101 = load i32, i32* %_103
	%_104 = bitcast i8* %this to i8***
	%_105 = load i8**, i8*** %_104
	%_106 = getelementptr i8*, i8** %_105, i32 6
	%_107 = load i8*, i8** %_106
	%_108 = bitcast i8* %_107 to i32 (i8*)*
	%_109 = call i32 %_108(i8* %this)
	%_111 = add i32 %_101, %_109
	ret i32 %_111
}

define i32 @E.f5(i8* %this) {

	%_112 = bitcast i8* %this to i8***
	%_113 = load i8**, i8*** %_112
	%_114 = getelementptr i8*, i8** %_113, i32 7
	%_115 = load i8*, i8** %_114
	%_116 = bitcast i8* %_115 to i32 (i8*)*
	%_117 = call i32 %_116(i8* %this)
	%_119 = add i32 5, %_117
	ret i32 %_119
}

define i32 @F.InitF(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e

	%_120 = load i8*, i8** %e
	%_121 = getelementptr i8, i8* %this, i32 8
	%_122 = bitcast i8* %_121 to i8**
	store i8* %_120, i8** %_122

	%_123 = load i8*, i8** %e
	%_124 = bitcast i8* %_123 to i8***
	%_125 = load i8**, i8*** %_124
	%_126 = getelementptr i8*, i8** %_125, i32 9
	%_127 = load i8*, i8** %_126
	%_128 = bitcast i8* %_127 to i32 (i8*)*
	%_129 = call i32 %_128(i8* %_123)
	ret i32 %_129
}

