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

	%_10 = load i32, i32* %sz
	%_11 = bitcast i8* %this to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 3
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i32 (i8*, i32)*
	%_16 = call i32 %_15(i8* %this, i32 %_10)
	store i32 %_16, i32* %aux01

	%_18 = bitcast i8* %this to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 1
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32 (i8*)*
	%_23 = call i32 %_22(i8* %this)
	store i32 %_23, i32* %aux02

	call void (i32) @print_int(i32 9999)

	%_25 = bitcast i8* %this to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 2
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*, i32)*
	%_30 = call i32 %_29(i8* %this, i32 8)
	call void (i32) @print_int(i32 %_30)

	%_32 = bitcast i8* %this to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 2
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i32 (i8*, i32)*
	%_37 = call i32 %_36(i8* %this, i32 12)
	call void (i32) @print_int(i32 %_37)

	%_39 = bitcast i8* %this to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 2
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i32 (i8*, i32)*
	%_44 = call i32 %_43(i8* %this, i32 17)
	call void (i32) @print_int(i32 %_44)

	%_46 = bitcast i8* %this to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 2
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i32 (i8*, i32)*
	%_51 = call i32 %_50(i8* %this, i32 50)
	call void (i32) @print_int(i32 %_51)

	ret i32 55
}

define i32 @LS.Print(i8* %this) {
	%j = alloca i32

	store i32 1, i32* %j

	br label %L0
L0:
	%_53 = load i32, i32* %j
	%_55 = getelementptr i8, i8* %this, i32 16
	%_56 = bitcast i8* %_55 to i32*
	%_54 = load i32, i32* %_56
	%_57 = icmp slt i32 %_53, %_54
	br i1 %_57, label %L1, label %L2
L1:
	%_59 = getelementptr i8, i8* %this, i32 8
	%_60 = bitcast i8* %_59 to i32**
	%_58 = load i32*, i32** %_60
	%_61 = load i32, i32* %j
	%_63 = load i32, i32* %_58
	%_64 = icmp sge i32 %_61, 0
	%_65 = icmp slt i32 %_61, %_63
	%_66 = and i1 %_64, %_65
	br i1 %_66, label %L3, label %L4
L4:
	call void @throw_oob()
	br label %L3
L3:
	%_67 = add i32 1, %_61
	%_68 = getelementptr i32, i32* %_58, i32 %_67
	%_69 = load i32, i32* %_68
	call void (i32) @print_int(i32 %_69)

	%_71 = load i32, i32* %j
	%_72 = add i32 %_71, 1
	store i32 %_72, i32* %j


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
	%_73 = load i32, i32* %j
	%_75 = getelementptr i8, i8* %this, i32 16
	%_76 = bitcast i8* %_75 to i32*
	%_74 = load i32, i32* %_76
	%_77 = icmp slt i32 %_73, %_74
	br i1 %_77, label %L6, label %L7
L6:
	%_79 = getelementptr i8, i8* %this, i32 8
	%_80 = bitcast i8* %_79 to i32**
	%_78 = load i32*, i32** %_80
	%_81 = load i32, i32* %j
	%_83 = load i32, i32* %_78
	%_84 = icmp sge i32 %_81, 0
	%_85 = icmp slt i32 %_81, %_83
	%_86 = and i1 %_84, %_85
	br i1 %_86, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_87 = add i32 1, %_81
	%_88 = getelementptr i32, i32* %_78, i32 %_87
	%_89 = load i32, i32* %_88
	store i32 %_89, i32* %aux01

	%_91 = load i32, i32* %num
	%_92 = add i32 %_91, 1
	store i32 %_92, i32* %aux02

	%_93 = load i32, i32* %aux01
	%_94 = load i32, i32* %num
	%_95 = icmp slt i32 %_93, %_94
	br i1 %_95, label %L10, label %L11
L10:
	store i32 0, i32* %nt

	br label %L12
L11:
	%_96 = load i32, i32* %aux01
	%_97 = load i32, i32* %aux02
	%_98 = icmp slt i32 %_96, %_97
	br i1 %_98, label %L13, label %L14
L13:
	br label %L15
L14:
	br label %L15
L15:
	%_99 = phi i1 [0, %L13], [1, %L14]
	br i1 %_99, label %L16, label %L17
L16:
	store i32 0, i32* %nt

	br label %L18
L17:
	store i1 1, i1* %ls01

	store i32 1, i32* %ifound

	%_101 = getelementptr i8, i8* %this, i32 16
	%_102 = bitcast i8* %_101 to i32*
	%_100 = load i32, i32* %_102
	store i32 %_100, i32* %j


	br label %L18
L18:

	br label %L12
L12:

	%_103 = load i32, i32* %j
	%_104 = add i32 %_103, 1
	store i32 %_104, i32* %j


	br label %L5
L7:

	%_105 = load i32, i32* %ifound
	ret i32 %_105
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32

	%_106 = load i32, i32* %sz
	%_107 = getelementptr i8, i8* %this, i32 16
	%_108 = bitcast i8* %_107 to i32*
	store i32 %_106, i32* %_108

	%_109 = load i32, i32* %sz
	%_110 = add i32 1, %_109
	%_111 = icmp sge i32 %_110, 1
	br i1 %_111, label %L19, label %L20
L20:
	call void @throw_nsz()
	br label %L19
L19:
	%_112 = call i8* @calloc(i32 %_110, i32 4)
	%_113 = bitcast i8* %_112 to i32*
	store i32 %_109, i32* %_113
	%_114 = getelementptr i8, i8* %this, i32 8
	%_115 = bitcast i8* %_114 to i32**
	store i32* %_113, i32** %_115

	store i32 1, i32* %j

	%_117 = getelementptr i8, i8* %this, i32 16
	%_118 = bitcast i8* %_117 to i32*
	%_116 = load i32, i32* %_118
	%_119 = add i32 %_116, 1
	store i32 %_119, i32* %k

	br label %L21
L21:
	%_120 = load i32, i32* %j
	%_122 = getelementptr i8, i8* %this, i32 16
	%_123 = bitcast i8* %_122 to i32*
	%_121 = load i32, i32* %_123
	%_124 = icmp slt i32 %_120, %_121
	br i1 %_124, label %L22, label %L23
L22:
	%_125 = load i32, i32* %j
	%_126 =  mul i32 2, %_125
	store i32 %_126, i32* %aux01

	%_127 = load i32, i32* %k
	%_128 =  sub i32 %_127, 3
	store i32 %_128, i32* %aux02

	%_129 = load i32, i32* %j
	%_133 = getelementptr i8, i8* %this, i32 8
	%_134 = bitcast i8* %_133 to i32**
	%_135 = load i32*, i32** %_134
	%_137 = load i32, i32* %_135
	%_138 = icmp sge i32 %_129, 0
	%_139 = icmp slt i32 %_129, %_137
	%_140 = and i1 %_139, %_140
	br i1 %_140, label %L24, label %L25
L25:
	call void @throw_oob()
	br label %L24
L24:
	%_141 = add i32 1, %_129
	%_130 = load i32, i32* %aux01
	%_131 = load i32, i32* %aux02
	%_132 = add i32 %_130, %_131
	%_143 = getelementptr i32, i32* %_135, i32 %_141
	store i32 %_132, i32* %_143

	%_144 = load i32, i32* %j
	%_145 = add i32 %_144, 1
	store i32 %_145, i32* %j

	%_146 = load i32, i32* %k
	%_147 =  sub i32 %_146, 1
	store i32 %_147, i32* %k


	br label %L21
L23:

	ret i32 0
}

