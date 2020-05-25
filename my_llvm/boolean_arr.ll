@.LetTheFunBegin_vtable = global [0 x i8*] []

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i8* (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*, i1)* @A.bar to i8*),
	i8* bitcast (i8* (i8*)* @A.another to i8*)
]

@.B_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @B.fill_arr to i8*),
	i8* bitcast (i32 (i8*)* @B.get_a to i8*),
	i8* bitcast (i1 (i8*)* @B.get_c to i8*)
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
	%b = alloca i8*
	%c = alloca i8*
	%d = alloca i32
	%a = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = add i32 4, 2
	%_4 = icmp sge i32 %_3, 4
	br i1 %_4, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_5 = call i8* @calloc(i32 1, i32 %_3)
	%_6 = bitcast i8* %_5 to i32*
	store i32 2, i32* %_6
	store i8* %_5, i8** %c

	%_9 = load i8*, i8** %c
	%_10 = bitcast i8* %_9 to i32*
	%_11 = load i32, i32* %_10
	%_12 = icmp sge i32 1, 0
	%_13 = icmp slt i32 1, %_11
	%_14 = and i1 %_13, %_14
	br i1 %_14, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_15 = add i32 4, 1
	%_16 = zext i1 0 to i8	%_17 = getelementptr i8, i8* %_9, i32 %_15
	store i8 0, i8* %_17

	%_18 = load i8*, i8** %c
	%_19 = bitcast i8* %_18 to i32*	%_20 = load i32, i32* %_19
	%_21 = icmp sge i32 1, 0
	%_22 = icmp slt i32 1, %_20
	%_23 = and i1 %_21, %_22
	br i1 %_23, label %L4, label %L5
L5:
	call void @throw_oob()
	br label %L4
L4:
	%_24 = add i32 1, 1
	%_25 = getelementptr i8, i8* %_18, i32 %_24
	%_26 = load i8, i8* %_25
	%_27 = trunc i8 %_26 to i1
	br i1 %_27, label %L6, label %L7
L6:
	call void (i32) @print_int(i32 1)


	br label %L8
L7:
	%_28 = load i8*, i8** %a
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 0
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i8* (i8*)*
	%_34 = call i8* %_33(i8* %_28)
	%_35 = trunc i8 %_34 to i1
	%_36 = bitcast i8* %_35 to i32*	%_37 = load i32, i32* %_36
	%_38 = icmp sge i32 2, 0
	%_39 = icmp slt i32 2, %_37
	%_40 = and i1 %_38, %_39
	br i1 %_40, label %L9, label %L10
L10:
	call void @throw_oob()
	br label %L9
L9:
	%_41 = add i32 1, 2
	%_42 = getelementptr i8, i8* %_35, i32 %_41
	%_43 = load i8, i8* %_42
	%_44 = trunc i8 %_43 to i1
	br i1 %_44, label %L11, label %L12
L11:
	call void (i32) @print_int(i32 10)


	br label %L13
L12:
	call void (i32) @print_int(i32 20)


	br label %L13
L13:


	br label %L8
L8:

	%_45 = load i8*, i8** %a
	%_46 = load i8*, i8** %c
	%_47 = bitcast i8* %_46 to i32*	%_48 = load i32, i32* %_47
	%_49 = icmp sge i32 1, 0
	%_50 = icmp slt i32 1, %_48
	%_51 = and i1 %_49, %_50
	br i1 %_51, label %L14, label %L15
L15:
	call void @throw_oob()
	br label %L14
L14:
	%_52 = add i32 1, 1
	%_53 = getelementptr i8, i8* %_46, i32 %_52
	%_54 = load i8, i8* %_53
	%_55 = trunc i8 %_54 to i1
	%_56 = bitcast i8* %_45 to i8***
	%_57 = load i8**, i8*** %_56
	%_58 = getelementptr i8*, i8** %_57, i32 1
	%_59 = load i8*, i8** %_58
	%_60 = bitcast i8* %_59 to i32 (i8*, i1)*
	%_61 = call i32 %_60(i8* %_45, i1 %_55)
	store i32 %_61, i32* %d

	%_63 = load i32, i32* %d
	call void (i32) @print_int(i32 %_63)

	%_64 = load i8*, i8** %a
	%_65 = load i8*, i8** %a
	%_66 = bitcast i8* %_65 to i8***
	%_67 = load i8**, i8*** %_66
	%_68 = getelementptr i8*, i8** %_67, i32 0
	%_69 = load i8*, i8** %_68
	%_70 = bitcast i8* %_69 to i8* (i8*)*
	%_71 = call i8* %_70(i8* %_65)
	%_72 = trunc i8 %_71 to i1
	%_73 = bitcast i8* %_72 to i32*	%_74 = load i32, i32* %_73
	%_75 = icmp sge i32 2, 0
	%_76 = icmp slt i32 2, %_74
	%_77 = and i1 %_75, %_76
	br i1 %_77, label %L16, label %L17
L17:
	call void @throw_oob()
	br label %L16
L16:
	%_78 = add i32 1, 2
	%_79 = getelementptr i8, i8* %_72, i32 %_78
	%_80 = load i8, i8* %_79
	%_81 = trunc i8 %_80 to i1
	%_82 = bitcast i8* %_64 to i8***
	%_83 = load i8**, i8*** %_82
	%_84 = getelementptr i8*, i8** %_83, i32 1
	%_85 = load i8*, i8** %_84
	%_86 = bitcast i8* %_85 to i32 (i8*, i1)*
	%_87 = call i32 %_86(i8* %_64, i1 %_81)
	store i32 %_87, i32* %d

	%_89 = load i32, i32* %d
	call void (i32) @print_int(i32 %_89)

	%_90 = call i8* @calloc(i32 1, i32 21)
	%_91 = bitcast i8* %_90 to i8***
	%_92 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_92, i8*** %_91
	store i8* %_90, i8** %b

	%_93 = load i8*, i8** %b
	%_94 = bitcast i8* %_93 to i8***
	%_95 = load i8**, i8*** %_94
	%_96 = getelementptr i8*, i8** %_95, i32 0
	%_97 = load i8*, i8** %_96
	%_98 = bitcast i8* %_97 to i32 (i8*)*
	%_99 = call i32 %_98(i8* %_93)
	call void (i32) @print_int(i32 %_99)

	%_101 = load i8*, i8** %b
	%_102 = bitcast i8* %_101 to i8***
	%_103 = load i8**, i8*** %_102
	%_104 = getelementptr i8*, i8** %_103, i32 1
	%_105 = load i8*, i8** %_104
	%_106 = bitcast i8* %_105 to i32 (i8*)*
	%_107 = call i32 %_106(i8* %_101)
	call void (i32) @print_int(i32 %_107)

	%_109 = load i8*, i8** %b
	%_110 = bitcast i8* %_109 to i8***
	%_111 = load i8**, i8*** %_110
	%_112 = getelementptr i8*, i8** %_111, i32 2
	%_113 = load i8*, i8** %_112
	%_114 = bitcast i8* %_113 to i1 (i8*)*
	%_115 = call i1 %_114(i8* %_109)
	br i1 %_115, label %L18, label %L19
L18:
	store i32 1, i32* %d


	br label %L20
L19:
	store i32 0, i32* %d


	br label %L20
L20:

	%_117 = load i32, i32* %d
	call void (i32) @print_int(i32 %_117)

	%_130 = load i8*, i8** %c
	%_131 = bitcast i8* %_130 to i32*
	%_132 = load i32, i32* %_131
	%_133 = icmp sge i32 2, 0
	%_134 = icmp slt i32 2, %_132
	%_135 = and i1 %_134, %_135
	br i1 %_135, label %L23, label %L24
L24:
	call void @throw_oob()
	br label %L23
L23:
	%_136 = add i32 4, 2
	%_118 = load i8*, i8** %c
	%_119 = bitcast i8* %_118 to i32*	%_120 = load i32, i32* %_119
	%_121 = icmp sge i32 1, 0
	%_122 = icmp slt i32 1, %_120
	%_123 = and i1 %_121, %_122
	br i1 %_123, label %L21, label %L22
L22:
	call void @throw_oob()
	br label %L21
L21:
	%_124 = add i32 1, 1
	%_125 = getelementptr i8, i8* %_118, i32 %_124
	%_126 = load i8, i8* %_125
	%_127 = trunc i8 %_126 to i1
	%_137 = zext i1 %_127 to i8	%_138 = getelementptr i8, i8* %_130, i32 %_136
	store i8 %_127, i8* %_138

	ret i32 0
}

define i8* @A.foo(i8* %this) {
	%b = alloca i8*

	%_139 = add i32 4, 200
	%_140 = icmp sge i32 %_139, 4
	br i1 %_140, label %L25, label %L26
L26:
	call void @throw_nsz()
	br label %L25
L25:
	%_141 = call i8* @calloc(i32 1, i32 %_139)
	%_142 = bitcast i8* %_141 to i32*
	store i32 200, i32* %_142
	store i8* %_141, i8** %b

	%_145 = load i8*, i8** %b
	%_146 = bitcast i8* %_145 to i32*
	%_147 = load i32, i32* %_146
	%_148 = icmp sge i32 2, 0
	%_149 = icmp slt i32 2, %_147
	%_150 = and i1 %_149, %_150
	br i1 %_150, label %L27, label %L28
L28:
	call void @throw_oob()
	br label %L27
L27:
	%_151 = add i32 4, 2
	%_152 = zext i1 1 to i8	%_153 = getelementptr i8, i8* %_145, i32 %_151
	store i8 1, i8* %_153

	%_154 = load i8*, i8** %b
	ret i8* %_154
}

define i32 @A.bar(i8* %this, i1 %.a) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%res = alloca i32

	%_155 = load i1, i1* %a
	br i1 %_155, label %L29, label %L30
L29:
	store i32 1, i32* %res


	br label %L31
L30:
	store i32 2, i32* %res


	br label %L31
L31:

	%_156 = load i32, i32* %res
	ret i32 %_156
}

define i8* @A.another(i8* %this) {

	%_157 = bitcast i8* %this to i8***
	%_158 = load i8**, i8*** %_157
	%_159 = getelementptr i8*, i8** %_158, i32 0
	%_160 = load i8*, i8** %_159
	%_161 = bitcast i8* %_160 to i8* (i8*)*
	%_162 = call i8* %_161(i8* %this)
	%_163 = trunc i8 %_162 to i1
	ret i8* %_163
}

define i32 @B.fill_arr(i8* %this) {
	%arr = alloca i8*
	%i = alloca i32
	%len = alloca i32

	store i32 100, i32* %len

	%_164 = load i32, i32* %len
	%_165 = add i32 4, %_164
	%_166 = icmp sge i32 %_165, 4
	br i1 %_166, label %L32, label %L33
L33:
	call void @throw_nsz()
	br label %L32
L32:
	%_167 = call i8* @calloc(i32 1, i32 %_165)
	%_168 = bitcast i8* %_167 to i32*
	store i32 %_164, i32* %_168
	store i8* %_167, i8** %arr

	store i32 0, i32* %i

	br label %L34
L34:
	%_169 = load i32, i32* %i
	%_170 = load i32, i32* %len
	%_171 = icmp slt i32 %_169, %_170
	br i1 %_171, label %L35, label %L36
L35:
	%_172 = load i32, i32* %i
	%_175 = load i8*, i8** %arr
	%_176 = bitcast i8* %_175 to i32*
	%_177 = load i32, i32* %_176
	%_178 = icmp sge i32 %_172, 0
	%_179 = icmp slt i32 %_172, %_177
	%_180 = and i1 %_179, %_180
	br i1 %_180, label %L37, label %L38
L38:
	call void @throw_oob()
	br label %L37
L37:
	%_181 = add i32 4, %_172
	%_182 = zext i1 1 to i8	%_183 = getelementptr i8, i8* %_175, i32 %_181
	store i8 1, i8* %_183

	%_184 = load i32, i32* %i
	%_185 = add i32 %_184, 1
	store i32 %_185, i32* %i


	br label %L34
L36:

	%_186 = load i8*, i8** %arr
	%_187 = getelementptr i8, i8* %this, i32 12
	%_188 = bitcast i8* %_187 to i8**
	store i8* %_186, i8** %_188

	ret i32 0
}

define i32 @B.get_a(i8* %this) {

	%_190 = getelementptr i8, i8* %this, i32 8
	%_191 = bitcast i8* %_190 to i32*
	%_189 = load i32, i32* %_191
	ret i32 %_189
}

define i1 @B.get_c(i8* %this) {

	%_193 = getelementptr i8, i8* %this, i32 20
	%_194 = bitcast i8* %_193 to i1*
	%_192 = load i1, i1* %_194
	ret i1 %_192
}

