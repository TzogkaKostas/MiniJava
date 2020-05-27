@.BubbleSort_vtable = global [0 x i8*] []

@.BBS_vtable = global [4 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @BBS.Start to i8*),
	i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),
	i8* bitcast (i32 (i8*)* @BBS.Print to i8*),
	i8* bitcast (i32 (i8*, i32)* @BBS.Init to i8*)
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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
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

define i32 @BBS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32

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
	%_18 = getelementptr i8*, i8** %_17, i32 2
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32 (i8*)*
	%_21 = call i32 %_20(i8* %this)
	store i32 %_21, i32* %aux01

	call void (i32) @print_int(i32 99999)

	%_22 = bitcast i8* %this to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 1
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i32 (i8*)*
	%_27 = call i32 %_26(i8* %this)
	store i32 %_27, i32* %aux01

	%_28 = bitcast i8* %this to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 2
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i32 (i8*)*
	%_33 = call i32 %_32(i8* %this)
	store i32 %_33, i32* %aux01

	ret i32 0
}

define i32 @BBS.Sort(i8* %this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32

	%_35 = getelementptr i8, i8* %this, i32 16
	%_36 = bitcast i8* %_35 to i32*
	%_34 = load i32, i32* %_36
	%_37 = sub i32 %_34, 1
	store i32 %_37, i32* %i

	%_38 = sub i32 0, 1
	store i32 %_38, i32* %aux02

	br label %L0
L0:
	%_39 = load i32, i32* %aux02
	%_40 = load i32, i32* %i
	%_41 = icmp slt i32 %_39, %_40
	br i1 %_41, label %L1, label %L2
L1:
	store i32 1, i32* %j

	br label %L3
L3:
	%_42 = load i32, i32* %j
	%_43 = load i32, i32* %i
	%_44 = add i32 %_43, 1
	%_45 = icmp slt i32 %_42, %_44
	br i1 %_45, label %L4, label %L5
L4:
	%_46 = load i32, i32* %j
	%_47 = sub i32 %_46, 1
	store i32 %_47, i32* %aux07

	%_49 = getelementptr i8, i8* %this, i32 8
	%_50 = bitcast i8* %_49 to i32**
	%_48 = load i32*, i32** %_50
	%_51 = load i32, i32* %aux07
	%_53 = load i32, i32* %_48
	%_54 = icmp sge i32 %_51, 0
	%_55 = icmp slt i32 %_51, %_53
	%_56 = and i1 %_54, %_55
	br i1 %_56, label %L6, label %L7
L7:
	call void @throw_oob()
	br label %L6
L6:
	%_57 = add i32 1, %_51
	%_58 = getelementptr i32, i32* %_48, i32 %_57
	%_59 = load i32, i32* %_58
	store i32 %_59, i32* %aux04

	%_62 = getelementptr i8, i8* %this, i32 8
	%_63 = bitcast i8* %_62 to i32**
	%_61 = load i32*, i32** %_63
	%_64 = load i32, i32* %j
	%_66 = load i32, i32* %_61
	%_67 = icmp sge i32 %_64, 0
	%_68 = icmp slt i32 %_64, %_66
	%_69 = and i1 %_67, %_68
	br i1 %_69, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_70 = add i32 1, %_64
	%_71 = getelementptr i32, i32* %_61, i32 %_70
	%_72 = load i32, i32* %_71
	store i32 %_72, i32* %aux05

	%_74 = load i32, i32* %aux05
	%_75 = load i32, i32* %aux04
	%_76 = icmp slt i32 %_74, %_75
	br i1 %_76, label %L10, label %L11
L10:
	%_77 = load i32, i32* %j
	%_78 = sub i32 %_77, 1
	store i32 %_78, i32* %aux06

	%_80 = getelementptr i8, i8* %this, i32 8
	%_81 = bitcast i8* %_80 to i32**
	%_79 = load i32*, i32** %_81
	%_82 = load i32, i32* %aux06
	%_84 = load i32, i32* %_79
	%_85 = icmp sge i32 %_82, 0
	%_86 = icmp slt i32 %_82, %_84
	%_87 = and i1 %_85, %_86
	br i1 %_87, label %L13, label %L14
L14:
	call void @throw_oob()
	br label %L13
L13:
	%_88 = add i32 1, %_82
	%_89 = getelementptr i32, i32* %_79, i32 %_88
	%_90 = load i32, i32* %_89
	store i32 %_90, i32* %t

	%_92 = load i32, i32* %aux06
	%_106 = getelementptr i8, i8* %this, i32 8
	%_107 = bitcast i8* %_106 to i32**
	%_108 = load i32*, i32** %_107
	%_110 = load i32, i32* %_108
	%_111 = icmp sge i32 %_92, 0
	%_112 = icmp slt i32 %_92, %_110
	%_113 = and i1 %_112, %_113
	br i1 %_113, label %L17, label %L18
L18:
	call void @throw_oob()
	br label %L17
L17:
	%_114 = add i32 1, %_92
	%_94 = getelementptr i8, i8* %this, i32 8
	%_95 = bitcast i8* %_94 to i32**
	%_93 = load i32*, i32** %_95
	%_96 = load i32, i32* %j
	%_98 = load i32, i32* %_93
	%_99 = icmp sge i32 %_96, 0
	%_100 = icmp slt i32 %_96, %_98
	%_101 = and i1 %_99, %_100
	br i1 %_101, label %L15, label %L16
L16:
	call void @throw_oob()
	br label %L15
L15:
	%_102 = add i32 1, %_96
	%_103 = getelementptr i32, i32* %_93, i32 %_102
	%_104 = load i32, i32* %_103
	%_116 = getelementptr i32, i32* %_108, i32 %_114
	store i32 %_104, i32* %_116

	%_117 = load i32, i32* %j
	%_119 = getelementptr i8, i8* %this, i32 8
	%_120 = bitcast i8* %_119 to i32**
	%_121 = load i32*, i32** %_120
	%_123 = load i32, i32* %_121
	%_124 = icmp sge i32 %_117, 0
	%_125 = icmp slt i32 %_117, %_123
	%_126 = and i1 %_125, %_126
	br i1 %_126, label %L19, label %L20
L20:
	call void @throw_oob()
	br label %L19
L19:
	%_127 = add i32 1, %_117
	%_118 = load i32, i32* %t
	%_129 = getelementptr i32, i32* %_121, i32 %_127
	store i32 %_118, i32* %_129


	br label %L12
L11:
	store i32 0, i32* %nt

	br label %L12
L12:

	%_130 = load i32, i32* %j
	%_131 = add i32 %_130, 1
	store i32 %_131, i32* %j


	br label %L3
L5:

	%_132 = load i32, i32* %i
	%_133 = sub i32 %_132, 1
	store i32 %_133, i32* %i


	br label %L0
L2:

	ret i32 0
}

define i32 @BBS.Print(i8* %this) {
	%j = alloca i32

	store i32 0, i32* %j

	br label %L21
L21:
	%_134 = load i32, i32* %j
	%_136 = getelementptr i8, i8* %this, i32 16
	%_137 = bitcast i8* %_136 to i32*
	%_135 = load i32, i32* %_137
	%_138 = icmp slt i32 %_134, %_135
	br i1 %_138, label %L22, label %L23
L22:
	%_140 = getelementptr i8, i8* %this, i32 8
	%_141 = bitcast i8* %_140 to i32**
	%_139 = load i32*, i32** %_141
	%_142 = load i32, i32* %j
	%_144 = load i32, i32* %_139
	%_145 = icmp sge i32 %_142, 0
	%_146 = icmp slt i32 %_142, %_144
	%_147 = and i1 %_145, %_146
	br i1 %_147, label %L24, label %L25
L25:
	call void @throw_oob()
	br label %L24
L24:
	%_148 = add i32 1, %_142
	%_149 = getelementptr i32, i32* %_139, i32 %_148
	%_150 = load i32, i32* %_149
	call void (i32) @print_int(i32 %_150)

	%_152 = load i32, i32* %j
	%_153 = add i32 %_152, 1
	store i32 %_153, i32* %j


	br label %L21
L23:

	ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz

	%_154 = load i32, i32* %sz
	%_155 = getelementptr i8, i8* %this, i32 16
	%_156 = bitcast i8* %_155 to i32*
	store i32 %_154, i32* %_156

	%_157 = load i32, i32* %sz
	%_158 = add i32 1, %_157
	%_159 = icmp sge i32 %_158, 1
	br i1 %_159, label %L26, label %L27
L27:
	call void @throw_nsz()
	br label %L26
L26:
	%_160 = call i8* @calloc(i32 %_158, i32 4)
	%_161 = bitcast i8* %_160 to i32*
	store i32 %_157, i32* %_161
	%_162 = getelementptr i8, i8* %this, i32 8
	%_163 = bitcast i8* %_162 to i32**
	store i32* %_161, i32** %_163

	%_164 = getelementptr i8, i8* %this, i32 8
	%_165 = bitcast i8* %_164 to i32**
	%_166 = load i32*, i32** %_165
	%_168 = load i32, i32* %_166
	%_169 = icmp sge i32 0, 0
	%_170 = icmp slt i32 0, %_168
	%_171 = and i1 %_170, %_171
	br i1 %_171, label %L28, label %L29
L29:
	call void @throw_oob()
	br label %L28
L28:
	%_172 = add i32 1, 0
	%_174 = getelementptr i32, i32* %_166, i32 %_172
	store i32 20, i32* %_174

	%_175 = getelementptr i8, i8* %this, i32 8
	%_176 = bitcast i8* %_175 to i32**
	%_177 = load i32*, i32** %_176
	%_179 = load i32, i32* %_177
	%_180 = icmp sge i32 1, 0
	%_181 = icmp slt i32 1, %_179
	%_182 = and i1 %_181, %_182
	br i1 %_182, label %L30, label %L31
L31:
	call void @throw_oob()
	br label %L30
L30:
	%_183 = add i32 1, 1
	%_185 = getelementptr i32, i32* %_177, i32 %_183
	store i32 7, i32* %_185

	%_186 = getelementptr i8, i8* %this, i32 8
	%_187 = bitcast i8* %_186 to i32**
	%_188 = load i32*, i32** %_187
	%_190 = load i32, i32* %_188
	%_191 = icmp sge i32 2, 0
	%_192 = icmp slt i32 2, %_190
	%_193 = and i1 %_192, %_193
	br i1 %_193, label %L32, label %L33
L33:
	call void @throw_oob()
	br label %L32
L32:
	%_194 = add i32 1, 2
	%_196 = getelementptr i32, i32* %_188, i32 %_194
	store i32 12, i32* %_196

	%_197 = getelementptr i8, i8* %this, i32 8
	%_198 = bitcast i8* %_197 to i32**
	%_199 = load i32*, i32** %_198
	%_201 = load i32, i32* %_199
	%_202 = icmp sge i32 3, 0
	%_203 = icmp slt i32 3, %_201
	%_204 = and i1 %_203, %_204
	br i1 %_204, label %L34, label %L35
L35:
	call void @throw_oob()
	br label %L34
L34:
	%_205 = add i32 1, 3
	%_207 = getelementptr i32, i32* %_199, i32 %_205
	store i32 18, i32* %_207

	%_208 = getelementptr i8, i8* %this, i32 8
	%_209 = bitcast i8* %_208 to i32**
	%_210 = load i32*, i32** %_209
	%_212 = load i32, i32* %_210
	%_213 = icmp sge i32 4, 0
	%_214 = icmp slt i32 4, %_212
	%_215 = and i1 %_214, %_215
	br i1 %_215, label %L36, label %L37
L37:
	call void @throw_oob()
	br label %L36
L36:
	%_216 = add i32 1, 4
	%_218 = getelementptr i32, i32* %_210, i32 %_216
	store i32 2, i32* %_218

	%_219 = getelementptr i8, i8* %this, i32 8
	%_220 = bitcast i8* %_219 to i32**
	%_221 = load i32*, i32** %_220
	%_223 = load i32, i32* %_221
	%_224 = icmp sge i32 5, 0
	%_225 = icmp slt i32 5, %_223
	%_226 = and i1 %_225, %_226
	br i1 %_226, label %L38, label %L39
L39:
	call void @throw_oob()
	br label %L38
L38:
	%_227 = add i32 1, 5
	%_229 = getelementptr i32, i32* %_221, i32 %_227
	store i32 11, i32* %_229

	%_230 = getelementptr i8, i8* %this, i32 8
	%_231 = bitcast i8* %_230 to i32**
	%_232 = load i32*, i32** %_231
	%_234 = load i32, i32* %_232
	%_235 = icmp sge i32 6, 0
	%_236 = icmp slt i32 6, %_234
	%_237 = and i1 %_236, %_237
	br i1 %_237, label %L40, label %L41
L41:
	call void @throw_oob()
	br label %L40
L40:
	%_238 = add i32 1, 6
	%_240 = getelementptr i32, i32* %_232, i32 %_238
	store i32 6, i32* %_240

	%_241 = getelementptr i8, i8* %this, i32 8
	%_242 = bitcast i8* %_241 to i32**
	%_243 = load i32*, i32** %_242
	%_245 = load i32, i32* %_243
	%_246 = icmp sge i32 7, 0
	%_247 = icmp slt i32 7, %_245
	%_248 = and i1 %_247, %_248
	br i1 %_248, label %L42, label %L43
L43:
	call void @throw_oob()
	br label %L42
L42:
	%_249 = add i32 1, 7
	%_251 = getelementptr i32, i32* %_243, i32 %_249
	store i32 9, i32* %_251

	%_252 = getelementptr i8, i8* %this, i32 8
	%_253 = bitcast i8* %_252 to i32**
	%_254 = load i32*, i32** %_253
	%_256 = load i32, i32* %_254
	%_257 = icmp sge i32 8, 0
	%_258 = icmp slt i32 8, %_256
	%_259 = and i1 %_258, %_259
	br i1 %_259, label %L44, label %L45
L45:
	call void @throw_oob()
	br label %L44
L44:
	%_260 = add i32 1, 8
	%_262 = getelementptr i32, i32* %_254, i32 %_260
	store i32 19, i32* %_262

	%_263 = getelementptr i8, i8* %this, i32 8
	%_264 = bitcast i8* %_263 to i32**
	%_265 = load i32*, i32** %_264
	%_267 = load i32, i32* %_265
	%_268 = icmp sge i32 9, 0
	%_269 = icmp slt i32 9, %_267
	%_270 = and i1 %_269, %_270
	br i1 %_270, label %L46, label %L47
L47:
	call void @throw_oob()
	br label %L46
L46:
	%_271 = add i32 1, 9
	%_273 = getelementptr i32, i32* %_265, i32 %_271
	store i32 5, i32* %_273

	ret i32 0
}

