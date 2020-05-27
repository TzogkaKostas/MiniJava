@.LinearSearch_vtable = global [0 x i8*] []

@.LS_vtable = global [4 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*),
	i8* bitcast (i32 (i8*)* @LS.Print to i8*),
	i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*),
	i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)
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

	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%aux02 = alloca i32

	%_9 = load i32, i32* %sz
	%_10 = bitcast i8* %this to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 3
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i32 (i8*, i32)*
	%_15 = call i32 %_14(i8* %this, i32 %_9)
	store i32 %_15, i32* %aux01

	%_16 = bitcast i8* %this to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 1
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32 (i8*)*
	%_21 = call i32 %_20(i8* %this)
	store i32 %_21, i32* %aux02

	call void (i32) @print_int(i32 9999)

	%_22 = bitcast i8* %this to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 2
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i32 (i8*, i32)*
	%_27 = call i32 %_26(i8* %this, i32 8)
	call void (i32) @print_int(i32 %_27)

	%_28 = bitcast i8* %this to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 2
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i32 (i8*, i32)*
	%_33 = call i32 %_32(i8* %this, i32 12)
	call void (i32) @print_int(i32 %_33)

	%_34 = bitcast i8* %this to i8***
	%_35 = load i8**, i8*** %_34
	%_36 = getelementptr i8*, i8** %_35, i32 2
	%_37 = load i8*, i8** %_36
	%_38 = bitcast i8* %_37 to i32 (i8*, i32)*
	%_39 = call i32 %_38(i8* %this, i32 17)
	call void (i32) @print_int(i32 %_39)

	%_40 = bitcast i8* %this to i8***
	%_41 = load i8**, i8*** %_40
	%_42 = getelementptr i8*, i8** %_41, i32 2
	%_43 = load i8*, i8** %_42
	%_44 = bitcast i8* %_43 to i32 (i8*, i32)*
	%_45 = call i32 %_44(i8* %this, i32 50)
	call void (i32) @print_int(i32 %_45)

	ret i32 55
}

define i32 @LS.Print(i8* %this) {
	%j = alloca i32

	store i32 1, i32* %j

	br label %L0
L0:
	%_46 = load i32, i32* %j
	%_48 = getelementptr i8, i8* %this, i32 16
	%_49 = bitcast i8* %_48 to i32*
	%_47 = load i32, i32* %_49
	%_50 = icmp slt i32 %_46, %_47
	br i1 %_50, label %L1, label %L2
L1:
	%_52 = getelementptr i8, i8* %this, i32 8
	%_53 = bitcast i8* %_52 to i32**
	%_51 = load i32*, i32** %_53
	%_54 = load i32, i32* %j
	%_56 = load i32, i32* %_51
	%_57 = icmp sge i32 %_54, 0
	%_58 = icmp slt i32 %_54, %_56
	%_59 = and i1 %_57, %_58
	br i1 %_59, label %L3, label %L4
L4:
	call void @throw_oob()
	br label %L3
L3:
	%_60 = add i32 1, %_54
	%_61 = getelementptr i32, i32* %_51, i32 %_60
	%_62 = load i32, i32* %_61
	call void (i32) @print_int(i32 %_62)

	%_64 = load i32, i32* %j
	%_65 = add i32 %_64, 1
	store i32 %_65, i32* %j


	br label %L0
L2:

	ret i32 0
}

define i32 @LS.Search(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%j = alloca i32
	%ls01 = alloca i1
	%ifound = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32

	store i32 1, i32* %j

	store i1 0, i1* %ls01

	store i32 0, i32* %ifound

	br label %L5
L5:
	%_66 = load i32, i32* %j
	%_68 = getelementptr i8, i8* %this, i32 16
	%_69 = bitcast i8* %_68 to i32*
	%_67 = load i32, i32* %_69
	%_70 = icmp slt i32 %_66, %_67
	br i1 %_70, label %L6, label %L7
L6:
	%_72 = getelementptr i8, i8* %this, i32 8
	%_73 = bitcast i8* %_72 to i32**
	%_71 = load i32*, i32** %_73
	%_74 = load i32, i32* %j
	%_76 = load i32, i32* %_71
	%_77 = icmp sge i32 %_74, 0
	%_78 = icmp slt i32 %_74, %_76
	%_79 = and i1 %_77, %_78
	br i1 %_79, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_80 = add i32 1, %_74
	%_81 = getelementptr i32, i32* %_71, i32 %_80
	%_82 = load i32, i32* %_81
	store i32 %_82, i32* %aux01

	%_84 = load i32, i32* %num
	%_85 = add i32 %_84, 1
	store i32 %_85, i32* %aux02

	%_86 = load i32, i32* %aux01
	%_87 = load i32, i32* %num
	%_88 = icmp slt i32 %_86, %_87
	br i1 %_88, label %L10, label %L11
L10:
	store i32 0, i32* %nt

	br label %L12
L11:
	%_89 = load i32, i32* %aux01
	%_90 = load i32, i32* %aux02
	%_91 = icmp slt i32 %_89, %_90
	br i1 %_91, label %L13, label %L14
L13:
	br label %L15
L14:
	br label %L15
L15:
	%_92 = phi i1 [0, %L13], [1, %L14]
	br i1 %_92, label %L16, label %L17
L16:
	store i32 0, i32* %nt

	br label %L18
L17:
	store i1 1, i1* %ls01

	store i32 1, i32* %ifound

	%_94 = getelementptr i8, i8* %this, i32 16
	%_95 = bitcast i8* %_94 to i32*
	%_93 = load i32, i32* %_95
	store i32 %_93, i32* %j


	br label %L18
L18:

	br label %L12
L12:

	%_96 = load i32, i32* %j
	%_97 = add i32 %_96, 1
	store i32 %_97, i32* %j


	br label %L5
L7:

	%_98 = load i32, i32* %ifound
	ret i32 %_98
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32

	%_99 = load i32, i32* %sz
	%_100 = getelementptr i8, i8* %this, i32 16
	%_101 = bitcast i8* %_100 to i32*
	store i32 %_99, i32* %_101

	%_102 = load i32, i32* %sz
	%_103 = add i32 1, %_102
	%_104 = icmp sge i32 %_103, 1
	br i1 %_104, label %L19, label %L20
L20:
	call void @throw_nsz()
	br label %L19
L19:
	%_105 = call i8* @calloc(i32 %_103, i32 4)
	%_106 = bitcast i8* %_105 to i32*
	store i32 %_102, i32* %_106
	%_107 = getelementptr i8, i8* %this, i32 8
	%_108 = bitcast i8* %_107 to i32**
	store i32* %_106, i32** %_108

	store i32 1, i32* %j

	%_110 = getelementptr i8, i8* %this, i32 16
	%_111 = bitcast i8* %_110 to i32*
	%_109 = load i32, i32* %_111
	%_112 = add i32 %_109, 1
	store i32 %_112, i32* %k

	br label %L21
L21:
	%_113 = load i32, i32* %j
	%_115 = getelementptr i8, i8* %this, i32 16
	%_116 = bitcast i8* %_115 to i32*
	%_114 = load i32, i32* %_116
	%_117 = icmp slt i32 %_113, %_114
	br i1 %_117, label %L22, label %L23
L22:
	%_118 = load i32, i32* %j
	%_119 = mul i32 2, %_118
	store i32 %_119, i32* %aux01

	%_120 = load i32, i32* %k
	%_121 = sub i32 %_120, 3
	store i32 %_121, i32* %aux02

	%_122 = load i32, i32* %j
	%_126 = getelementptr i8, i8* %this, i32 8
	%_127 = bitcast i8* %_126 to i32**
	%_128 = load i32*, i32** %_127
	%_130 = load i32, i32* %_128
	%_131 = icmp sge i32 %_122, 0
	%_132 = icmp slt i32 %_122, %_130
	%_133 = and i1 %_132, %_133
	br i1 %_133, label %L24, label %L25
L25:
	call void @throw_oob()
	br label %L24
L24:
	%_134 = add i32 1, %_122
	%_123 = load i32, i32* %aux01
	%_124 = load i32, i32* %aux02
	%_125 = add i32 %_123, %_124
	%_136 = getelementptr i32, i32* %_128, i32 %_134
	store i32 %_125, i32* %_136

	%_137 = load i32, i32* %j
	%_138 = add i32 %_137, 1
	store i32 %_138, i32* %j

	%_139 = load i32, i32* %k
	%_140 = sub i32 %_139, 1
	store i32 %_140, i32* %k


	br label %L21
L23:

	ret i32 0
}

