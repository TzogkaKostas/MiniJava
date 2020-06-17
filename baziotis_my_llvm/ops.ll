@.Main_vtable = global [0 x i8*] []

@.A_vtable = global [7 x i8*] [
	i8* bitcast (i1 (i8*)* @A.t to i8*),
	i8* bitcast (i32 (i8*)* @A.t2 to i8*),
	i8* bitcast (i32 (i8*, i32*)* @A.lispy to i8*),
	i8* bitcast (i1 (i8*)* @A.t3 to i8*),
	i8* bitcast (i1 (i8*, i32, i32*)* @A.t4 to i8*),
	i8* bitcast (i32 (i8*, i32*)* @A.t5 to i8*),
	i8* bitcast (i1 (i8*, i1, i32*)* @A.t6 to i8*)
]

@.C_vtable = global [1 x i8*] [
	i8* bitcast (i32* (i8*, i1)* @C.test to i8*)
]

@.B_vtable = global [2 x i8*] [
	i8* bitcast (i32* (i8*, i1)* @C.test to i8*),
	i8* bitcast (i32* (i8*, i32)* @B.test2 to i8*)
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

	ret i32 0
}

define i1 @A.t(i8* %this) {

	%_0 = icmp slt i32 1, 2
	br i1 %_0, label %L0, label %L1
L0:
	br label %L2
L1:
	br label %L2
L2:
	%_1 = phi i1 [0, %L0], [1, %L1]
	br i1 %_1, label %L8, label %L7
L7:
	br label %L10
L8:
	br i1 1, label %L4, label %L3
L3:
	br label %L6
L4:
	br label %L5
L5:
	br label %L6
L6:
	%_2 = phi i1 [0, %L3], [0, %L5]
	br label %L9
L9:
	br label %L10
L10:
	%_3 = phi i1 [0, %L7], [%_2, %L9]
	ret i1 %_3
}

define i32 @A.t2(i8* %this) {

	%_4 = add i32 1, 2
	%_5 = add i32 %_4, 3
	%_6 = add i32 %_5, 4
	ret i32 %_6
}

define i32 @A.lispy(i8* %this, i32* %.a) {
	%a = alloca i32*
	store i32* %.a, i32** %a

	%_7 = add i32 1, 2
	%_8 = load i32*, i32** %a
	%_10 = load i32, i32* %_8
	%_11 = icmp sge i32 3, 0
	%_12 = icmp slt i32 3, %_10
	%_13 = and i1 %_11, %_12
	br i1 %_13, label %L11, label %L12
L12:
	call void @throw_oob()
	br label %L11
L11:
	%_14 = add i32 1, 3
	%_15 = getelementptr i32, i32* %_8, i32 %_14
	%_16 = load i32, i32* %_15
	%_18 = add i32 %_7, %_16
	ret i32 %_18
}

define i1 @A.t3(i8* %this) {
	%a = alloca i32
	%b = alloca i32

	store i32 2, i32* %a

	store i32 2, i32* %b

	%_19 = add i32 349, 908
	%_20 = load i32, i32* %a
	%_21 = mul i32 23, %_20
	%_22 = load i32, i32* %b
	%_23 = sub i32 %_22, 2
	%_24 = sub i32 %_21, %_23
	%_25 = icmp slt i32 %_19, %_24
	ret i1 %_25
}

define i1 @A.t4(i8* %this, i32 %.a, i32* %.b) {
	%a = alloca i32
	store i32 %.a, i32* %a
	%b = alloca i32*
	store i32* %.b, i32** %b
	%arr = alloca i32*

	%_26 = add i32 1, 10
	%_27 = icmp sge i32 %_26, 1
	br i1 %_27, label %L13, label %L14
L14:
	call void @throw_nsz()
	br label %L13
L13:
	%_28 = call i8* @calloc(i32 %_26, i32 4)
	%_29 = bitcast i8* %_28 to i32*
	store i32 10, i32* %_29
	store i32* %_29, i32** %arr

	%_30 = bitcast i8* %this to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 1
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i32 (i8*)*
	%_35 = call i32 %_34(i8* %this)
	%_36 = add i32 29347, %_35
	%_37 = icmp slt i32 %_36, 12
	br i1 %_37, label %L26, label %L25
L25:
	br label %L28
L26:
	%_38 = load i32, i32* %a
	%_39 = load i32*, i32** %arr
	%_41 = load i32, i32* %_39
	%_42 = icmp sge i32 0, 0
	%_43 = icmp slt i32 0, %_41
	%_44 = and i1 %_42, %_43
	br i1 %_44, label %L15, label %L16
L16:
	call void @throw_oob()
	br label %L15
L15:
	%_45 = add i32 1, 0
	%_46 = getelementptr i32, i32* %_39, i32 %_45
	%_47 = load i32, i32* %_46
	%_49 = icmp slt i32 %_38, %_47
	br i1 %_49, label %L18, label %L17
L17:
	br label %L20
L18:
	%_50 = bitcast i8* %this to i8***
	%_51 = load i8**, i8*** %_50
	%_52 = getelementptr i8*, i8** %_51, i32 3
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i1 (i8*)*
	%_55 = call i1 %_54(i8* %this)
	br label %L19
L19:
	br label %L20
L20:
	%_56 = phi i1 [0, %L17], [%_55, %L19]
	br i1 %_56, label %L22, label %L21
L21:
	br label %L24
L22:
	%_57 = bitcast i8* %this to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 1
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i32 (i8*)*
	%_62 = call i32 %_61(i8* %this)
	%_63 = load i32*, i32** %arr
	%_64 = bitcast i8* %this to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 4
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*, i32, i32*)*
	%_69 = call i1 %_68(i8* %this, i32 %_62, i32* %_63)
	br label %L23
L23:
	br label %L24
L24:
	%_70 = phi i1 [0, %L21], [%_69, %L23]
	br label %L27
L27:
	br label %L28
L28:
	%_71 = phi i1 [0, %L25], [%_70, %L27]
	ret i1 %_71
}

define i32 @A.t5(i8* %this, i32* %.a) {
	%a = alloca i32*
	store i32* %.a, i32** %a
	%b = alloca i32

	%_72 = bitcast i8* %this to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 1
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i32 (i8*)*
	%_77 = call i32 %_76(i8* %this)
	%_78 = load i32*, i32** %a
	%_80 = load i32, i32* %_78
	%_81 = icmp sge i32 0, 0
	%_82 = icmp slt i32 0, %_80
	%_83 = and i1 %_81, %_82
	br i1 %_83, label %L29, label %L30
L30:
	call void @throw_oob()
	br label %L29
L29:
	%_84 = add i32 1, 0
	%_85 = getelementptr i32, i32* %_78, i32 %_84
	%_86 = load i32, i32* %_85
	%_88 = add i32 1, %_86
	%_89 = icmp sge i32 %_88, 1
	br i1 %_89, label %L31, label %L32
L32:
	call void @throw_nsz()
	br label %L31
L31:
	%_90 = call i8* @calloc(i32 %_88, i32 4)
	%_91 = bitcast i8* %_90 to i32*
	store i32 %_86, i32* %_91
	%_92 = bitcast i8* %this to i8***
	%_93 = load i8**, i8*** %_92
	%_94 = getelementptr i8*, i8** %_93, i32 2
	%_95 = load i8*, i8** %_94
	%_96 = bitcast i8* %_95 to i32 (i8*, i32*)*
	%_97 = call i32 %_96(i8* %this, i32* %_91)
	%_98 = add i32 %_77, %_97
	%_99 = add i32 1, %_98
	%_100 = icmp sge i32 %_99, 1
	br i1 %_100, label %L33, label %L34
L34:
	call void @throw_nsz()
	br label %L33
L33:
	%_101 = call i8* @calloc(i32 %_99, i32 4)
	%_102 = bitcast i8* %_101 to i32*
	store i32 %_98, i32* %_102
	%_104 = load i32, i32* %_102
	%_105 = icmp sge i32 0, 0
	%_106 = icmp slt i32 0, %_104
	%_107 = and i1 %_105, %_106
	br i1 %_107, label %L35, label %L36
L36:
	call void @throw_oob()
	br label %L35
L35:
	%_108 = add i32 1, 0
	%_109 = getelementptr i32, i32* %_102, i32 %_108
	%_110 = load i32, i32* %_109
	%_112 = add i32 %_110, 10
	%_113 = add i32 1, %_112
	%_114 = icmp sge i32 %_113, 1
	br i1 %_114, label %L37, label %L38
L38:
	call void @throw_nsz()
	br label %L37
L37:
	%_115 = call i8* @calloc(i32 %_113, i32 4)
	%_116 = bitcast i8* %_115 to i32*
	store i32 %_112, i32* %_116
	%_118 = load i32, i32* %_116
	%_119 = icmp sge i32 2, 0
	%_120 = icmp slt i32 2, %_118
	%_121 = and i1 %_119, %_120
	br i1 %_121, label %L39, label %L40
L40:
	call void @throw_oob()
	br label %L39
L39:
	%_122 = add i32 1, 2
	%_123 = getelementptr i32, i32* %_116, i32 %_122
	%_124 = load i32, i32* %_123
	store i32 %_124, i32* %b

	%_126 = load i32*, i32** %a
	%_127 = load i32, i32* %b
	%_129 = load i32, i32* %_126
	%_130 = icmp sge i32 %_127, 0
	%_131 = icmp slt i32 %_127, %_129
	%_132 = and i1 %_130, %_131
	br i1 %_132, label %L41, label %L42
L42:
	call void @throw_oob()
	br label %L41
L41:
	%_133 = add i32 1, %_127
	%_134 = getelementptr i32, i32* %_126, i32 %_133
	%_135 = load i32, i32* %_134
	ret i32 %_135
}

define i1 @A.t6(i8* %this, i1 %.dummy, i32* %.arr) {
	%dummy = alloca i1
	store i1 %.dummy, i1* %dummy
	%arr = alloca i32*
	store i32* %.arr, i32** %arr
	%a = alloca i32
	%c = alloca i8*

	store i32 2, i32* %a

	%_137 = call i8* @calloc(i32 1, i32 8)
	%_138 = bitcast i8* %_137 to i8***
	%_139 = getelementptr [1 x i8*], [1 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_139, i8*** %_138
	store i8* %_137, i8** %c

	%_140 = bitcast i8* %this to i8***
	%_141 = load i8**, i8*** %_140
	%_142 = getelementptr i8*, i8** %_141, i32 1
	%_143 = load i8*, i8** %_142
	%_144 = bitcast i8* %_143 to i32 (i8*)*
	%_145 = call i32 %_144(i8* %this)
	%_146 = add i32 29347, %_145
	%_147 = icmp slt i32 %_146, 12
	br i1 %_147, label %L60, label %L59
L59:
	br label %L62
L60:
	%_148 = load i32, i32* %a
	%_149 = load i32*, i32** %arr
	%_151 = load i32, i32* %_149
	%_152 = icmp sge i32 0, 0
	%_153 = icmp slt i32 0, %_151
	%_154 = and i1 %_152, %_153
	br i1 %_154, label %L43, label %L44
L44:
	call void @throw_oob()
	br label %L43
L43:
	%_155 = add i32 1, 0
	%_156 = getelementptr i32, i32* %_149, i32 %_155
	%_157 = load i32, i32* %_156
	%_159 = icmp slt i32 %_148, %_157
	br i1 %_159, label %L46, label %L45
L45:
	br label %L48
L46:
	%_160 = bitcast i8* %this to i8***
	%_161 = load i8**, i8*** %_160
	%_162 = getelementptr i8*, i8** %_161, i32 3
	%_163 = load i8*, i8** %_162
	%_164 = bitcast i8* %_163 to i1 (i8*)*
	%_165 = call i1 %_164(i8* %this)
	br label %L47
L47:
	br label %L48
L48:
	%_166 = phi i1 [0, %L45], [%_165, %L47]
	br i1 %_166, label %L56, label %L55
L55:
	br label %L58
L56:
	%_167 = call i8* @calloc(i32 1, i32 8)
	%_168 = bitcast i8* %_167 to i8***
	%_169 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_169, i8*** %_168
	%_170 = bitcast i8* %_167 to i8***
	%_171 = load i8**, i8*** %_170
	%_172 = getelementptr i8*, i8** %_171, i32 0
	%_173 = load i8*, i8** %_172
	%_174 = bitcast i8* %_173 to i32* (i8*, i1)*
	%_175 = call i32* %_174(i8* %_167, i1 1)
	%_177 = load i32, i32* %_175
	%_178 = icmp sge i32 0, 0
	%_179 = icmp slt i32 0, %_177
	%_180 = and i1 %_178, %_179
	br i1 %_180, label %L49, label %L50
L50:
	call void @throw_oob()
	br label %L49
L49:
	%_181 = add i32 1, 0
	%_182 = getelementptr i32, i32* %_175, i32 %_181
	%_183 = load i32, i32* %_182
	%_185 = load i32*, i32** %arr
	%_186 = bitcast i8* %this to i8***
	%_187 = load i8**, i8*** %_186
	%_188 = getelementptr i8*, i8** %_187, i32 4
	%_189 = load i8*, i8** %_188
	%_190 = bitcast i8* %_189 to i1 (i8*, i32, i32*)*
	%_191 = call i1 %_190(i8* %this, i32 %_183, i32* %_185)
	%_192 = load i32*, i32** %arr
	%_194 = load i32, i32* %_192
	%_195 = icmp sge i32 0, 0
	%_196 = icmp slt i32 0, %_194
	%_197 = and i1 %_195, %_196
	br i1 %_197, label %L51, label %L52
L52:
	call void @throw_oob()
	br label %L51
L51:
	%_198 = add i32 1, 0
	%_199 = getelementptr i32, i32* %_192, i32 %_198
	%_200 = load i32, i32* %_199
	%_202 = add i32 1, %_200
	%_203 = icmp sge i32 %_202, 1
	br i1 %_203, label %L53, label %L54
L54:
	call void @throw_nsz()
	br label %L53
L53:
	%_204 = call i8* @calloc(i32 %_202, i32 4)
	%_205 = bitcast i8* %_204 to i32*
	store i32 %_200, i32* %_205
	%_206 = bitcast i8* %this to i8***
	%_207 = load i8**, i8*** %_206
	%_208 = getelementptr i8*, i8** %_207, i32 6
	%_209 = load i8*, i8** %_208
	%_210 = bitcast i8* %_209 to i1 (i8*, i1, i32*)*
	%_211 = call i1 %_210(i8* %this, i1 %_191, i32* %_205)
	br label %L57
L57:
	br label %L58
L58:
	%_212 = phi i1 [0, %L55], [%_211, %L57]
	br label %L61
L61:
	br label %L62
L62:
	%_213 = phi i1 [0, %L59], [%_212, %L61]
	ret i1 %_213
}

define i32* @C.test(i8* %this, i1 %.a) {
	%a = alloca i1
	store i1 %.a, i1* %a

	%_214 = add i32 1, 10
	%_215 = icmp sge i32 %_214, 1
	br i1 %_215, label %L63, label %L64
L64:
	call void @throw_nsz()
	br label %L63
L63:
	%_216 = call i8* @calloc(i32 %_214, i32 4)
	%_217 = bitcast i8* %_216 to i32*
	store i32 10, i32* %_217
	ret i32* %_217
}

define i32* @B.test2(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_218 = load i32, i32* %i
	%_219 = add i32 1, %_218
	%_220 = icmp sge i32 %_219, 1
	br i1 %_220, label %L65, label %L66
L66:
	call void @throw_nsz()
	br label %L65
L65:
	%_221 = call i8* @calloc(i32 %_219, i32 4)
	%_222 = bitcast i8* %_221 to i32*
	store i32 %_218, i32* %_222
	ret i32* %_222
}

