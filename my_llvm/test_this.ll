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

	%_13 = load i8*, i8** %e
	%_14 = bitcast i8* %_13 to i8***
	%_15 = load i8**, i8*** %_14
	%_16 = getelementptr i8*, i8** %_15, i32 9
	%_17 = load i8*, i8** %_16
	%_18 = bitcast i8* %_17 to i32 (i8*)*
	%_19 = call i32 %_18(i8* %_13)
	call void (i32) @print_int(i32 %_19)

	%_20 = load i8*, i8** %f
	%_21 = load i8*, i8** %e
	%_22 = bitcast i8* %_20 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 0
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i32 (i8*, i8*)*
	%_27 = call i32 %_26(i8* %_20, i8* %_21)
	call void (i32) @print_int(i32 %_27)

	ret i32 0
}

define i32 @A.InitA(i8* %this) {

	%_28 = getelementptr i8, i8* %this, i32 8
	%_29 = bitcast i8* %_28 to i32*
	store i32 1024, i32* %_29

	%_31 = getelementptr i8, i8* %this, i32 8
	%_32 = bitcast i8* %_31 to i32*
	%_30 = load i32, i32* %_32
	ret i32 %_30
}

define i32 @A.f1(i8* %this) {

	ret i32 1
}

define i32 @B.InitB(i8* %this) {

	%_33 = getelementptr i8, i8* %this, i32 12
	%_34 = bitcast i8* %_33 to i32*
	store i32 2048, i32* %_34

	%_36 = getelementptr i8, i8* %this, i32 12
	%_37 = bitcast i8* %_36 to i32*
	%_35 = load i32, i32* %_37
	%_38 = bitcast i8* %this to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 0
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i32 (i8*)*
	%_43 = call i32 %_42(i8* %this)
	%_44 = add i32 %_35, %_43
	ret i32 %_44
}

define i32 @B.f2(i8* %this) {

	%_45 = bitcast i8* %this to i8***
	%_46 = load i8**, i8*** %_45
	%_47 = getelementptr i8*, i8** %_46, i32 1
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i32 (i8*)*
	%_50 = call i32 %_49(i8* %this)
	%_51 = add i32 2, %_50
	ret i32 %_51
}

define i32 @C.InitC(i8* %this) {

	%_52 = getelementptr i8, i8* %this, i32 16
	%_53 = bitcast i8* %_52 to i32*
	store i32 4096, i32* %_53

	%_55 = getelementptr i8, i8* %this, i32 16
	%_56 = bitcast i8* %_55 to i32*
	%_54 = load i32, i32* %_56
	%_57 = bitcast i8* %this to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 2
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i32 (i8*)*
	%_62 = call i32 %_61(i8* %this)
	%_63 = add i32 %_54, %_62
	ret i32 %_63
}

define i32 @C.f3(i8* %this) {

	%_64 = bitcast i8* %this to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 3
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i32 (i8*)*
	%_69 = call i32 %_68(i8* %this)
	%_70 = add i32 3, %_69
	ret i32 %_70
}

define i32 @D.InitD(i8* %this) {

	%_71 = getelementptr i8, i8* %this, i32 20
	%_72 = bitcast i8* %_71 to i32*
	store i32 8192, i32* %_72

	%_74 = getelementptr i8, i8* %this, i32 20
	%_75 = bitcast i8* %_74 to i32*
	%_73 = load i32, i32* %_75
	%_76 = bitcast i8* %this to i8***
	%_77 = load i8**, i8*** %_76
	%_78 = getelementptr i8*, i8** %_77, i32 4
	%_79 = load i8*, i8** %_78
	%_80 = bitcast i8* %_79 to i32 (i8*)*
	%_81 = call i32 %_80(i8* %this)
	%_82 = add i32 %_73, %_81
	ret i32 %_82
}

define i32 @D.f4(i8* %this) {

	%_83 = bitcast i8* %this to i8***
	%_84 = load i8**, i8*** %_83
	%_85 = getelementptr i8*, i8** %_84, i32 5
	%_86 = load i8*, i8** %_85
	%_87 = bitcast i8* %_86 to i32 (i8*)*
	%_88 = call i32 %_87(i8* %this)
	%_89 = add i32 4, %_88
	ret i32 %_89
}

define i32 @E.InitE(i8* %this) {

	%_90 = getelementptr i8, i8* %this, i32 24
	%_91 = bitcast i8* %_90 to i32*
	store i32 16384, i32* %_91

	%_93 = getelementptr i8, i8* %this, i32 24
	%_94 = bitcast i8* %_93 to i32*
	%_92 = load i32, i32* %_94
	%_95 = bitcast i8* %this to i8***
	%_96 = load i8**, i8*** %_95
	%_97 = getelementptr i8*, i8** %_96, i32 6
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i32 (i8*)*
	%_100 = call i32 %_99(i8* %this)
	%_101 = add i32 %_92, %_100
	ret i32 %_101
}

define i32 @E.f5(i8* %this) {

	%_102 = bitcast i8* %this to i8***
	%_103 = load i8**, i8*** %_102
	%_104 = getelementptr i8*, i8** %_103, i32 7
	%_105 = load i8*, i8** %_104
	%_106 = bitcast i8* %_105 to i32 (i8*)*
	%_107 = call i32 %_106(i8* %this)
	%_108 = add i32 5, %_107
	ret i32 %_108
}

define i32 @F.InitF(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e

	%_109 = load i8*, i8** %e
	%_110 = getelementptr i8, i8* %this, i32 8
	%_111 = bitcast i8* %_110 to i8**
	store i8* %_109, i8** %_111

	%_112 = load i8*, i8** %e
	%_113 = bitcast i8* %_112 to i8***
	%_114 = load i8**, i8*** %_113
	%_115 = getelementptr i8*, i8** %_114, i32 9
	%_116 = load i8*, i8** %_115
	%_117 = bitcast i8* %_116 to i32 (i8*)*
	%_118 = call i32 %_117(i8* %_112)
	ret i32 %_118
}

