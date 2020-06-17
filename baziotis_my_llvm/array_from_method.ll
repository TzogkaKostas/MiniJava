@.array_from_method_vtable = global [0 x i8*] []

@.A_vtable = global [1 x i8*] [
	i8* bitcast (i32* (i8*)* @A.foo to i8*)
]

@.B_vtable = global [1 x i8*] [
	i8* bitcast (i32* (i8*)* @A.foo to i8*)
]

@.C_vtable = global [1 x i8*] [
	i8* bitcast (i32* (i8*)* @A.foo to i8*)
]

@.D_vtable = global [1 x i8*] [
	i8* bitcast (i32* (i8*)* @D.foo to i8*)
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
	%a1 = alloca i8*
	%a2 = alloca i8*
	%i = alloca i32

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a1

	%_3 = call i8* @calloc(i32 1, i32 8)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	store i8* %_3, i8** %a2

	store i32 0, i32* %i

	br label %L0
L0:
	%_6 = load i32, i32* %i
	%_7 = load i8*, i8** %a1
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 0
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32* (i8*)*
	%_13 = call i32* %_12(i8* %_7)
	%_15 = load i32, i32* %_13
	%_16 = icmp slt i32 %_6, %_15
	br i1 %_16, label %L1, label %L2
L1:
	%_17 = load i8*, i8** %a1
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 0
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32* (i8*)*
	%_23 = call i32* %_22(i8* %_17)
	%_24 = load i32, i32* %i
	%_26 = load i32, i32* %_23
	%_27 = icmp sge i32 %_24, 0
	%_28 = icmp slt i32 %_24, %_26
	%_29 = and i1 %_27, %_28
	br i1 %_29, label %L3, label %L4
L4:
	call void @throw_oob()
	br label %L3
L3:
	%_30 = add i32 1, %_24
	%_31 = getelementptr i32, i32* %_23, i32 %_30
	%_32 = load i32, i32* %_31
	call void (i32) @print_int(i32 %_32)

	%_34 = load i32, i32* %i
	%_35 = add i32 %_34, 1
	store i32 %_35, i32* %i


	br label %L0
L2:

	store i32 0, i32* %i

	br label %L5
L5:
	%_36 = load i32, i32* %i
	%_37 = load i8*, i8** %a2
	%_38 = bitcast i8* %_37 to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 0
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i32* (i8*)*
	%_43 = call i32* %_42(i8* %_37)
	%_45 = load i32, i32* %_43
	%_46 = icmp slt i32 %_36, %_45
	br i1 %_46, label %L6, label %L7
L6:
	%_47 = load i8*, i8** %a2
	%_48 = bitcast i8* %_47 to i8***
	%_49 = load i8**, i8*** %_48
	%_50 = getelementptr i8*, i8** %_49, i32 0
	%_51 = load i8*, i8** %_50
	%_52 = bitcast i8* %_51 to i32* (i8*)*
	%_53 = call i32* %_52(i8* %_47)
	%_54 = load i32, i32* %i
	%_56 = load i32, i32* %_53
	%_57 = icmp sge i32 %_54, 0
	%_58 = icmp slt i32 %_54, %_56
	%_59 = and i1 %_57, %_58
	br i1 %_59, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_60 = add i32 1, %_54
	%_61 = getelementptr i32, i32* %_53, i32 %_60
	%_62 = load i32, i32* %_61
	call void (i32) @print_int(i32 %_62)

	%_64 = load i32, i32* %i
	%_65 = add i32 %_64, 1
	store i32 %_65, i32* %i


	br label %L5
L7:

	ret i32 0
}

define i32* @A.foo(i8* %this) {
	%arr = alloca i32*

	%_66 = add i32 1, 5
	%_67 = icmp sge i32 %_66, 1
	br i1 %_67, label %L10, label %L11
L11:
	call void @throw_nsz()
	br label %L10
L10:
	%_68 = call i8* @calloc(i32 %_66, i32 4)
	%_69 = bitcast i8* %_68 to i32*
	store i32 5, i32* %_69
	store i32* %_69, i32** %arr

	%_72 = load i32*, i32** %arr
	%_74 = load i32, i32* %_72
	%_75 = icmp sge i32 0, 0
	%_76 = icmp slt i32 0, %_74
	%_77 = and i1 %_76, %_77
	br i1 %_77, label %L12, label %L13
L13:
	call void @throw_oob()
	br label %L12
L12:
	%_78 = add i32 1, 0
	%_80 = getelementptr i32, i32* %_72, i32 %_78
	store i32 11, i32* %_80

	%_83 = load i32*, i32** %arr
	%_85 = load i32, i32* %_83
	%_86 = icmp sge i32 1, 0
	%_87 = icmp slt i32 1, %_85
	%_88 = and i1 %_87, %_88
	br i1 %_88, label %L14, label %L15
L15:
	call void @throw_oob()
	br label %L14
L14:
	%_89 = add i32 1, 1
	%_91 = getelementptr i32, i32* %_83, i32 %_89
	store i32 22, i32* %_91

	%_94 = load i32*, i32** %arr
	%_96 = load i32, i32* %_94
	%_97 = icmp sge i32 2, 0
	%_98 = icmp slt i32 2, %_96
	%_99 = and i1 %_98, %_99
	br i1 %_99, label %L16, label %L17
L17:
	call void @throw_oob()
	br label %L16
L16:
	%_100 = add i32 1, 2
	%_102 = getelementptr i32, i32* %_94, i32 %_100
	store i32 33, i32* %_102

	%_105 = load i32*, i32** %arr
	%_107 = load i32, i32* %_105
	%_108 = icmp sge i32 3, 0
	%_109 = icmp slt i32 3, %_107
	%_110 = and i1 %_109, %_110
	br i1 %_110, label %L18, label %L19
L19:
	call void @throw_oob()
	br label %L18
L18:
	%_111 = add i32 1, 3
	%_113 = getelementptr i32, i32* %_105, i32 %_111
	store i32 44, i32* %_113

	%_116 = load i32*, i32** %arr
	%_118 = load i32, i32* %_116
	%_119 = icmp sge i32 4, 0
	%_120 = icmp slt i32 4, %_118
	%_121 = and i1 %_120, %_121
	br i1 %_121, label %L20, label %L21
L21:
	call void @throw_oob()
	br label %L20
L20:
	%_122 = add i32 1, 4
	%_124 = getelementptr i32, i32* %_116, i32 %_122
	store i32 55, i32* %_124

	%_125 = load i32*, i32** %arr
	ret i32* %_125
}

define i32* @D.foo(i8* %this) {
	%arr = alloca i32*

	%_126 = add i32 1, 5
	%_127 = icmp sge i32 %_126, 1
	br i1 %_127, label %L22, label %L23
L23:
	call void @throw_nsz()
	br label %L22
L22:
	%_128 = call i8* @calloc(i32 %_126, i32 4)
	%_129 = bitcast i8* %_128 to i32*
	store i32 5, i32* %_129
	store i32* %_129, i32** %arr

	%_132 = load i32*, i32** %arr
	%_134 = load i32, i32* %_132
	%_135 = icmp sge i32 0, 0
	%_136 = icmp slt i32 0, %_134
	%_137 = and i1 %_136, %_137
	br i1 %_137, label %L24, label %L25
L25:
	call void @throw_oob()
	br label %L24
L24:
	%_138 = add i32 1, 0
	%_140 = getelementptr i32, i32* %_132, i32 %_138
	store i32 111, i32* %_140

	%_143 = load i32*, i32** %arr
	%_145 = load i32, i32* %_143
	%_146 = icmp sge i32 1, 0
	%_147 = icmp slt i32 1, %_145
	%_148 = and i1 %_147, %_148
	br i1 %_148, label %L26, label %L27
L27:
	call void @throw_oob()
	br label %L26
L26:
	%_149 = add i32 1, 1
	%_151 = getelementptr i32, i32* %_143, i32 %_149
	store i32 222, i32* %_151

	%_154 = load i32*, i32** %arr
	%_156 = load i32, i32* %_154
	%_157 = icmp sge i32 2, 0
	%_158 = icmp slt i32 2, %_156
	%_159 = and i1 %_158, %_159
	br i1 %_159, label %L28, label %L29
L29:
	call void @throw_oob()
	br label %L28
L28:
	%_160 = add i32 1, 2
	%_162 = getelementptr i32, i32* %_154, i32 %_160
	store i32 333, i32* %_162

	%_165 = load i32*, i32** %arr
	%_167 = load i32, i32* %_165
	%_168 = icmp sge i32 3, 0
	%_169 = icmp slt i32 3, %_167
	%_170 = and i1 %_169, %_170
	br i1 %_170, label %L30, label %L31
L31:
	call void @throw_oob()
	br label %L30
L30:
	%_171 = add i32 1, 3
	%_173 = getelementptr i32, i32* %_165, i32 %_171
	store i32 444, i32* %_173

	%_176 = load i32*, i32** %arr
	%_178 = load i32, i32* %_176
	%_179 = icmp sge i32 4, 0
	%_180 = icmp slt i32 4, %_178
	%_181 = and i1 %_180, %_181
	br i1 %_181, label %L32, label %L33
L33:
	call void @throw_oob()
	br label %L32
L32:
	%_182 = add i32 1, 4
	%_184 = getelementptr i32, i32* %_176, i32 %_182
	store i32 555, i32* %_184

	%_185 = load i32*, i32** %arr
	ret i32* %_185
}

