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
	%_37 = add i32 29347, %_35
	%_38 = icmp slt i32 %_37, 12
	br i1 %_38, label %L26, label %L25
L25:
	br label %L28
L26:
	%_39 = load i32, i32* %a
	%_40 = load i32*, i32** %arr
	%_42 = load i32, i32* %_40
	%_43 = icmp sge i32 0, 0
	%_44 = icmp slt i32 0, %_42
	%_45 = and i1 %_43, %_44
	br i1 %_45, label %L15, label %L16
L16:
	call void @throw_oob()
	br label %L15
L15:
	%_46 = add i32 1, 0
	%_47 = getelementptr i32, i32* %_40, i32 %_46
	%_48 = load i32, i32* %_47
	%_50 = icmp slt i32 %_39, %_48
	br i1 %_50, label %L18, label %L17
L17:
	br label %L20
L18:
	%_51 = bitcast i8* %this to i8***
	%_52 = load i8**, i8*** %_51
	%_53 = getelementptr i8*, i8** %_52, i32 3
	%_54 = load i8*, i8** %_53
	%_55 = bitcast i8* %_54 to i1 (i8*)*
	%_56 = call i1 %_55(i8* %this)
	br label %L19
L19:
	br label %L20
L20:
	%_58 = phi i1 [0, %L17], [%_56, %L19]
	br i1 %_58, label %L22, label %L21
L21:
	br label %L24
L22:
	%_59 = bitcast i8* %this to i8***
	%_60 = load i8**, i8*** %_59
	%_61 = getelementptr i8*, i8** %_60, i32 1
	%_62 = load i8*, i8** %_61
	%_63 = bitcast i8* %_62 to i32 (i8*)*
	%_64 = call i32 %_63(i8* %this)
	%_66 = load i32*, i32** %arr
	%_67 = bitcast i8* %this to i8***
	%_68 = load i8**, i8*** %_67
	%_69 = getelementptr i8*, i8** %_68, i32 4
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1 (i8*, i32, i32*)*
	%_72 = call i1 %_71(i8* %this, i32 %_64, i32* %_66)
	br label %L23
L23:
	br label %L24
L24:
	%_74 = phi i1 [0, %L21], [%_72, %L23]
	br label %L27
L27:
	br label %L28
L28:
	%_75 = phi i1 [0, %L25], [%_74, %L27]
	ret i1 %_75
}

define i32 @A.t5(i8* %this, i32* %.a) {
	%a = alloca i32*
	store i32* %.a, i32** %a
	%b = alloca i32

	%_76 = bitcast i8* %this to i8***
	%_77 = load i8**, i8*** %_76
	%_78 = getelementptr i8*, i8** %_77, i32 1
	%_79 = load i8*, i8** %_78
	%_80 = bitcast i8* %_79 to i32 (i8*)*
	%_81 = call i32 %_80(i8* %this)
	%_83 = load i32*, i32** %a
	%_85 = load i32, i32* %_83
	%_86 = icmp sge i32 0, 0
	%_87 = icmp slt i32 0, %_85
	%_88 = and i1 %_86, %_87
	br i1 %_88, label %L29, label %L30
L30:
	call void @throw_oob()
	br label %L29
L29:
	%_89 = add i32 1, 0
	%_90 = getelementptr i32, i32* %_83, i32 %_89
	%_91 = load i32, i32* %_90
	%_93 = add i32 1, %_91
	%_94 = icmp sge i32 %_93, 1
	br i1 %_94, label %L31, label %L32
L32:
	call void @throw_nsz()
	br label %L31
L31:
	%_95 = call i8* @calloc(i32 %_93, i32 4)
	%_96 = bitcast i8* %_95 to i32*
	store i32 %_91, i32* %_96
	%_97 = bitcast i8* %this to i8***
	%_98 = load i8**, i8*** %_97
	%_99 = getelementptr i8*, i8** %_98, i32 2
	%_100 = load i8*, i8** %_99
	%_101 = bitcast i8* %_100 to i32 (i8*, i32*)*
	%_102 = call i32 %_101(i8* %this, i32* %_96)
	%_104 = add i32 %_81, %_102
	%_105 = add i32 1, %_104
	%_106 = icmp sge i32 %_105, 1
	br i1 %_106, label %L33, label %L34
L34:
	call void @throw_nsz()
	br label %L33
L33:
	%_107 = call i8* @calloc(i32 %_105, i32 4)
	%_108 = bitcast i8* %_107 to i32*
	store i32 %_104, i32* %_108
	%_110 = load i32, i32* %_108
	%_111 = icmp sge i32 0, 0
	%_112 = icmp slt i32 0, %_110
	%_113 = and i1 %_111, %_112
	br i1 %_113, label %L35, label %L36
L36:
	call void @throw_oob()
	br label %L35
L35:
	%_114 = add i32 1, 0
	%_115 = getelementptr i32, i32* %_108, i32 %_114
	%_116 = load i32, i32* %_115
	%_118 = add i32 %_116, 10
	%_119 = add i32 1, %_118
	%_120 = icmp sge i32 %_119, 1
	br i1 %_120, label %L37, label %L38
L38:
	call void @throw_nsz()
	br label %L37
L37:
	%_121 = call i8* @calloc(i32 %_119, i32 4)
	%_122 = bitcast i8* %_121 to i32*
	store i32 %_118, i32* %_122
	%_124 = load i32, i32* %_122
	%_125 = icmp sge i32 2, 0
	%_126 = icmp slt i32 2, %_124
	%_127 = and i1 %_125, %_126
	br i1 %_127, label %L39, label %L40
L40:
	call void @throw_oob()
	br label %L39
L39:
	%_128 = add i32 1, 2
	%_129 = getelementptr i32, i32* %_122, i32 %_128
	%_130 = load i32, i32* %_129
	store i32 %_130, i32* %b

	%_132 = load i32*, i32** %a
	%_133 = load i32, i32* %b
	%_135 = load i32, i32* %_132
	%_136 = icmp sge i32 %_133, 0
	%_137 = icmp slt i32 %_133, %_135
	%_138 = and i1 %_136, %_137
	br i1 %_138, label %L41, label %L42
L42:
	call void @throw_oob()
	br label %L41
L41:
	%_139 = add i32 1, %_133
	%_140 = getelementptr i32, i32* %_132, i32 %_139
	%_141 = load i32, i32* %_140
	ret i32 %_141
}

define i1 @A.t6(i8* %this, i1 %.dummy, i32* %.arr) {
	%dummy = alloca i1
	store i1 %.dummy, i1* %dummy
	%arr = alloca i32*
	store i32* %.arr, i32** %arr
	%a = alloca i32
	%c = alloca i8*

	store i32 2, i32* %a

	%_143 = call i8* @calloc(i32 1, i32 8)
	%_144 = bitcast i8* %_143 to i8***
	%_145 = getelementptr [1 x i8*], [1 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_145, i8*** %_144
	store i8* %_143, i8** %c

	%_146 = bitcast i8* %this to i8***
	%_147 = load i8**, i8*** %_146
	%_148 = getelementptr i8*, i8** %_147, i32 1
	%_149 = load i8*, i8** %_148
	%_150 = bitcast i8* %_149 to i32 (i8*)*
	%_151 = call i32 %_150(i8* %this)
	%_153 = add i32 29347, %_151
	%_154 = icmp slt i32 %_153, 12
	br i1 %_154, label %L60, label %L59
L59:
	br label %L62
L60:
	%_155 = load i32, i32* %a
	%_156 = load i32*, i32** %arr
	%_158 = load i32, i32* %_156
	%_159 = icmp sge i32 0, 0
	%_160 = icmp slt i32 0, %_158
	%_161 = and i1 %_159, %_160
	br i1 %_161, label %L43, label %L44
L44:
	call void @throw_oob()
	br label %L43
L43:
	%_162 = add i32 1, 0
	%_163 = getelementptr i32, i32* %_156, i32 %_162
	%_164 = load i32, i32* %_163
	%_166 = icmp slt i32 %_155, %_164
	br i1 %_166, label %L46, label %L45
L45:
	br label %L48
L46:
	%_167 = bitcast i8* %this to i8***
	%_168 = load i8**, i8*** %_167
	%_169 = getelementptr i8*, i8** %_168, i32 3
	%_170 = load i8*, i8** %_169
	%_171 = bitcast i8* %_170 to i1 (i8*)*
	%_172 = call i1 %_171(i8* %this)
	br label %L47
L47:
	br label %L48
L48:
	%_174 = phi i1 [0, %L45], [%_172, %L47]
	br i1 %_174, label %L56, label %L55
L55:
	br label %L58
L56:
	%_175 = call i8* @calloc(i32 1, i32 8)
	%_176 = bitcast i8* %_175 to i8***
	%_177 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_177, i8*** %_176
	%_178 = bitcast i8* %_175 to i8***
	%_179 = load i8**, i8*** %_178
	%_180 = getelementptr i8*, i8** %_179, i32 0
	%_181 = load i8*, i8** %_180
	%_182 = bitcast i8* %_181 to i32* (i8*, i1)*
	%_183 = call i32* %_182(i8* %_175, i1 1)
	%_186 = load i32, i32* %_183
	%_187 = icmp sge i32 0, 0
	%_188 = icmp slt i32 0, %_186
	%_189 = and i1 %_187, %_188
	br i1 %_189, label %L49, label %L50
L50:
	call void @throw_oob()
	br label %L49
L49:
	%_190 = add i32 1, 0
	%_191 = getelementptr i32, i32* %_183, i32 %_190
	%_192 = load i32, i32* %_191
	%_194 = load i32*, i32** %arr
	%_195 = bitcast i8* %this to i8***
	%_196 = load i8**, i8*** %_195
	%_197 = getelementptr i8*, i8** %_196, i32 4
	%_198 = load i8*, i8** %_197
	%_199 = bitcast i8* %_198 to i1 (i8*, i32, i32*)*
	%_200 = call i1 %_199(i8* %this, i32 %_192, i32* %_194)
	%_202 = load i32*, i32** %arr
	%_204 = load i32, i32* %_202
	%_205 = icmp sge i32 0, 0
	%_206 = icmp slt i32 0, %_204
	%_207 = and i1 %_205, %_206
	br i1 %_207, label %L51, label %L52
L52:
	call void @throw_oob()
	br label %L51
L51:
	%_208 = add i32 1, 0
	%_209 = getelementptr i32, i32* %_202, i32 %_208
	%_210 = load i32, i32* %_209
	%_212 = add i32 1, %_210
	%_213 = icmp sge i32 %_212, 1
	br i1 %_213, label %L53, label %L54
L54:
	call void @throw_nsz()
	br label %L53
L53:
	%_214 = call i8* @calloc(i32 %_212, i32 4)
	%_215 = bitcast i8* %_214 to i32*
	store i32 %_210, i32* %_215
	%_216 = bitcast i8* %this to i8***
	%_217 = load i8**, i8*** %_216
	%_218 = getelementptr i8*, i8** %_217, i32 6
	%_219 = load i8*, i8** %_218
	%_220 = bitcast i8* %_219 to i1 (i8*, i1, i32*)*
	%_221 = call i1 %_220(i8* %this, i1 %_200, i32* %_215)
	br label %L57
L57:
	br label %L58
L58:
	%_223 = phi i1 [0, %L55], [%_221, %L57]
	br label %L61
L61:
	br label %L62
L62:
	%_224 = phi i1 [0, %L59], [%_223, %L61]
	ret i1 %_224
}

define i32* @C.test(i8* %this, i1 %.a) {
	%a = alloca i1
	store i1 %.a, i1* %a

	%_225 = add i32 1, 10
	%_226 = icmp sge i32 %_225, 1
	br i1 %_226, label %L63, label %L64
L64:
	call void @throw_nsz()
	br label %L63
L63:
	%_227 = call i8* @calloc(i32 %_225, i32 4)
	%_228 = bitcast i8* %_227 to i32*
	store i32 10, i32* %_228
	ret i32* %_228
}

define i32* @B.test2(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_229 = load i32, i32* %i
	%_230 = add i32 1, %_229
	%_231 = icmp sge i32 %_230, 1
	br i1 %_231, label %L65, label %L66
L66:
	call void @throw_nsz()
	br label %L65
L65:
	%_232 = call i8* @calloc(i32 %_230, i32 4)
	%_233 = bitcast i8* %_232 to i32*
	store i32 %_229, i32* %_233
	ret i32* %_233
}

