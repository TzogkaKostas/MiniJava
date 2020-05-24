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
	%_20 = getelementptr i8*, i8** %_19, i32 2
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32 (i8*)*
	%_23 = call i32 %_22(i8* %this)
	store i32 %_23, i32* %aux01

	call void (i32) @print_int(i32 99999)

	%_25 = bitcast i8* %this to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 1
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*)*
	%_30 = call i32 %_29(i8* %this)
	store i32 %_30, i32* %aux01

	%_32 = bitcast i8* %this to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 2
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i32 (i8*)*
	%_37 = call i32 %_36(i8* %this)
	store i32 %_37, i32* %aux01

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

	%_40 = getelementptr i8, i8* %this, i32 16
	%_41 = bitcast i8* %_40 to i32*
	%_39 = load i32, i32* %_41
	%_42 =  sub i32 %_39, 1
	store i32 %_42, i32* %i

	%_43 =  sub i32 0, 1
	store i32 %_43, i32* %aux02

	br label %L0
L0:
	%_44 = load i32, i32* %aux02
	%_45 = load i32, i32* %i
	%_46 = icmp slt i32 %_44, %_45
	br i1 %_46, label %L1, label %L2
L1:
	store i32 1, i32* %j

	br label %L3
L3:
	%_47 = load i32, i32* %j
	%_48 = load i32, i32* %i
	%_49 = add i32 %_48, 1
	%_50 = icmp slt i32 %_47, %_49
	br i1 %_50, label %L4, label %L5
L4:
	%_51 = load i32, i32* %j
	%_52 =  sub i32 %_51, 1
	store i32 %_52, i32* %aux07

	%_54 = getelementptr i8, i8* %this, i32 8
	%_55 = bitcast i8* %_54 to i32**
	%_53 = load i32*, i32** %_55
	%_56 = load i32, i32* %aux07
	%_58 = load i32, i32* %_53
	%_59 = icmp sge i32 %_56, 0
	%_60 = icmp slt i32 %_56, %_58
	%_61 = and i1 %_59, %_60
	br i1 %_61, label %L6, label %L7
L7:
	call void @throw_oob()
	br label %L6
L6:
	%_62 = add i32 1, %_56
	%_63 = getelementptr i32, i32* %_53, i32 %_62
	%_64 = load i32, i32* %_63
	store i32 %_64, i32* %aux04

	%_67 = getelementptr i8, i8* %this, i32 8
	%_68 = bitcast i8* %_67 to i32**
	%_66 = load i32*, i32** %_68
	%_69 = load i32, i32* %j
	%_71 = load i32, i32* %_66
	%_72 = icmp sge i32 %_69, 0
	%_73 = icmp slt i32 %_69, %_71
	%_74 = and i1 %_72, %_73
	br i1 %_74, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_75 = add i32 1, %_69
	%_76 = getelementptr i32, i32* %_66, i32 %_75
	%_77 = load i32, i32* %_76
	store i32 %_77, i32* %aux05

	%_79 = load i32, i32* %aux05
	%_80 = load i32, i32* %aux04
	%_81 = icmp slt i32 %_79, %_80
	br i1 %_81, label %L10, label %L11
L10:
	%_82 = load i32, i32* %j
	%_83 =  sub i32 %_82, 1
	store i32 %_83, i32* %aux06

	%_85 = getelementptr i8, i8* %this, i32 8
	%_86 = bitcast i8* %_85 to i32**
	%_84 = load i32*, i32** %_86
	%_87 = load i32, i32* %aux06
	%_89 = load i32, i32* %_84
	%_90 = icmp sge i32 %_87, 0
	%_91 = icmp slt i32 %_87, %_89
	%_92 = and i1 %_90, %_91
	br i1 %_92, label %L13, label %L14
L14:
	call void @throw_oob()
	br label %L13
L13:
	%_93 = add i32 1, %_87
	%_94 = getelementptr i32, i32* %_84, i32 %_93
	%_95 = load i32, i32* %_94
	store i32 %_95, i32* %t

	%_97 = load i32, i32* %aux06
	%_111 = getelementptr i8, i8* %this, i32 8
	%_112 = bitcast i8* %_111 to i32**
	%_113 = load i32*, i32** %_112
	%_115 = load i32, i32* %_113
	%_116 = icmp sge i32 %_97, 0
	%_117 = icmp slt i32 %_97, %_115
	%_118 = and i1 %_117, %_118
	br i1 %_118, label %L17, label %L18
L18:
	call void @throw_oob()
	br label %L17
L17:
	%_119 = add i32 1, %_97
	%_99 = getelementptr i8, i8* %this, i32 8
	%_100 = bitcast i8* %_99 to i32**
	%_98 = load i32*, i32** %_100
	%_101 = load i32, i32* %j
	%_103 = load i32, i32* %_98
	%_104 = icmp sge i32 %_101, 0
	%_105 = icmp slt i32 %_101, %_103
	%_106 = and i1 %_104, %_105
	br i1 %_106, label %L15, label %L16
L16:
	call void @throw_oob()
	br label %L15
L15:
	%_107 = add i32 1, %_101
	%_108 = getelementptr i32, i32* %_98, i32 %_107
	%_109 = load i32, i32* %_108
	%_121 = getelementptr i32, i32* %_113, i32 %_119
	store i32 %_109, i32* %_121

	%_122 = load i32, i32* %j
	%_124 = getelementptr i8, i8* %this, i32 8
	%_125 = bitcast i8* %_124 to i32**
	%_126 = load i32*, i32** %_125
	%_128 = load i32, i32* %_126
	%_129 = icmp sge i32 %_122, 0
	%_130 = icmp slt i32 %_122, %_128
	%_131 = and i1 %_130, %_131
	br i1 %_131, label %L19, label %L20
L20:
	call void @throw_oob()
	br label %L19
L19:
	%_132 = add i32 1, %_122
	%_123 = load i32, i32* %t
	%_134 = getelementptr i32, i32* %_126, i32 %_132
	store i32 %_123, i32* %_134


	br label %L12
L11:
	store i32 0, i32* %nt

	br label %L12
L12:

	%_135 = load i32, i32* %j
	%_136 = add i32 %_135, 1
	store i32 %_136, i32* %j


	br label %L3
L5:

	%_137 = load i32, i32* %i
	%_138 =  sub i32 %_137, 1
	store i32 %_138, i32* %i


	br label %L0
L2:

	ret i32 0
}

define i32 @BBS.Print(i8* %this) {
	%j = alloca i32

	store i32 0, i32* %j

	br label %L21
L21:
	%_139 = load i32, i32* %j
	%_141 = getelementptr i8, i8* %this, i32 16
	%_142 = bitcast i8* %_141 to i32*
	%_140 = load i32, i32* %_142
	%_143 = icmp slt i32 %_139, %_140
	br i1 %_143, label %L22, label %L23
L22:
	%_145 = getelementptr i8, i8* %this, i32 8
	%_146 = bitcast i8* %_145 to i32**
	%_144 = load i32*, i32** %_146
	%_147 = load i32, i32* %j
	%_149 = load i32, i32* %_144
	%_150 = icmp sge i32 %_147, 0
	%_151 = icmp slt i32 %_147, %_149
	%_152 = and i1 %_150, %_151
	br i1 %_152, label %L24, label %L25
L25:
	call void @throw_oob()
	br label %L24
L24:
	%_153 = add i32 1, %_147
	%_154 = getelementptr i32, i32* %_144, i32 %_153
	%_155 = load i32, i32* %_154
	call void (i32) @print_int(i32 %_155)

	%_157 = load i32, i32* %j
	%_158 = add i32 %_157, 1
	store i32 %_158, i32* %j


	br label %L21
L23:

	ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz

	%_159 = load i32, i32* %sz
	%_160 = getelementptr i8, i8* %this, i32 16
	%_161 = bitcast i8* %_160 to i32*
	store i32 %_159, i32* %_161

	%_162 = load i32, i32* %sz
	%_163 = add i32 1, %_162
	%_164 = icmp sge i32 %_163, 1
	br i1 %_164, label %L26, label %L27
L27:
	call void @throw_nsz()
	br label %L26
L26:
	%_165 = call i8* @calloc(i32 %_163, i32 4)
	%_166 = bitcast i8* %_165 to i32*
	store i32 %_162, i32* %_166
	%_167 = getelementptr i8, i8* %this, i32 8
	%_168 = bitcast i8* %_167 to i32**
	store i32* %_166, i32** %_168

	%_169 = getelementptr i8, i8* %this, i32 8
	%_170 = bitcast i8* %_169 to i32**
	%_171 = load i32*, i32** %_170
	%_173 = load i32, i32* %_171
	%_174 = icmp sge i32 0, 0
	%_175 = icmp slt i32 0, %_173
	%_176 = and i1 %_175, %_176
	br i1 %_176, label %L28, label %L29
L29:
	call void @throw_oob()
	br label %L28
L28:
	%_177 = add i32 1, 0
	%_179 = getelementptr i32, i32* %_171, i32 %_177
	store i32 20, i32* %_179

	%_180 = getelementptr i8, i8* %this, i32 8
	%_181 = bitcast i8* %_180 to i32**
	%_182 = load i32*, i32** %_181
	%_184 = load i32, i32* %_182
	%_185 = icmp sge i32 1, 0
	%_186 = icmp slt i32 1, %_184
	%_187 = and i1 %_186, %_187
	br i1 %_187, label %L30, label %L31
L31:
	call void @throw_oob()
	br label %L30
L30:
	%_188 = add i32 1, 1
	%_190 = getelementptr i32, i32* %_182, i32 %_188
	store i32 7, i32* %_190

	%_191 = getelementptr i8, i8* %this, i32 8
	%_192 = bitcast i8* %_191 to i32**
	%_193 = load i32*, i32** %_192
	%_195 = load i32, i32* %_193
	%_196 = icmp sge i32 2, 0
	%_197 = icmp slt i32 2, %_195
	%_198 = and i1 %_197, %_198
	br i1 %_198, label %L32, label %L33
L33:
	call void @throw_oob()
	br label %L32
L32:
	%_199 = add i32 1, 2
	%_201 = getelementptr i32, i32* %_193, i32 %_199
	store i32 12, i32* %_201

	%_202 = getelementptr i8, i8* %this, i32 8
	%_203 = bitcast i8* %_202 to i32**
	%_204 = load i32*, i32** %_203
	%_206 = load i32, i32* %_204
	%_207 = icmp sge i32 3, 0
	%_208 = icmp slt i32 3, %_206
	%_209 = and i1 %_208, %_209
	br i1 %_209, label %L34, label %L35
L35:
	call void @throw_oob()
	br label %L34
L34:
	%_210 = add i32 1, 3
	%_212 = getelementptr i32, i32* %_204, i32 %_210
	store i32 18, i32* %_212

	%_213 = getelementptr i8, i8* %this, i32 8
	%_214 = bitcast i8* %_213 to i32**
	%_215 = load i32*, i32** %_214
	%_217 = load i32, i32* %_215
	%_218 = icmp sge i32 4, 0
	%_219 = icmp slt i32 4, %_217
	%_220 = and i1 %_219, %_220
	br i1 %_220, label %L36, label %L37
L37:
	call void @throw_oob()
	br label %L36
L36:
	%_221 = add i32 1, 4
	%_223 = getelementptr i32, i32* %_215, i32 %_221
	store i32 2, i32* %_223

	%_224 = getelementptr i8, i8* %this, i32 8
	%_225 = bitcast i8* %_224 to i32**
	%_226 = load i32*, i32** %_225
	%_228 = load i32, i32* %_226
	%_229 = icmp sge i32 5, 0
	%_230 = icmp slt i32 5, %_228
	%_231 = and i1 %_230, %_231
	br i1 %_231, label %L38, label %L39
L39:
	call void @throw_oob()
	br label %L38
L38:
	%_232 = add i32 1, 5
	%_234 = getelementptr i32, i32* %_226, i32 %_232
	store i32 11, i32* %_234

	%_235 = getelementptr i8, i8* %this, i32 8
	%_236 = bitcast i8* %_235 to i32**
	%_237 = load i32*, i32** %_236
	%_239 = load i32, i32* %_237
	%_240 = icmp sge i32 6, 0
	%_241 = icmp slt i32 6, %_239
	%_242 = and i1 %_241, %_242
	br i1 %_242, label %L40, label %L41
L41:
	call void @throw_oob()
	br label %L40
L40:
	%_243 = add i32 1, 6
	%_245 = getelementptr i32, i32* %_237, i32 %_243
	store i32 6, i32* %_245

	%_246 = getelementptr i8, i8* %this, i32 8
	%_247 = bitcast i8* %_246 to i32**
	%_248 = load i32*, i32** %_247
	%_250 = load i32, i32* %_248
	%_251 = icmp sge i32 7, 0
	%_252 = icmp slt i32 7, %_250
	%_253 = and i1 %_252, %_253
	br i1 %_253, label %L42, label %L43
L43:
	call void @throw_oob()
	br label %L42
L42:
	%_254 = add i32 1, 7
	%_256 = getelementptr i32, i32* %_248, i32 %_254
	store i32 9, i32* %_256

	%_257 = getelementptr i8, i8* %this, i32 8
	%_258 = bitcast i8* %_257 to i32**
	%_259 = load i32*, i32** %_258
	%_261 = load i32, i32* %_259
	%_262 = icmp sge i32 8, 0
	%_263 = icmp slt i32 8, %_261
	%_264 = and i1 %_263, %_264
	br i1 %_264, label %L44, label %L45
L45:
	call void @throw_oob()
	br label %L44
L44:
	%_265 = add i32 1, 8
	%_267 = getelementptr i32, i32* %_259, i32 %_265
	store i32 19, i32* %_267

	%_268 = getelementptr i8, i8* %this, i32 8
	%_269 = bitcast i8* %_268 to i32**
	%_270 = load i32*, i32** %_269
	%_272 = load i32, i32* %_270
	%_273 = icmp sge i32 9, 0
	%_274 = icmp slt i32 9, %_272
	%_275 = and i1 %_274, %_275
	br i1 %_275, label %L46, label %L47
L47:
	call void @throw_oob()
	br label %L46
L46:
	%_276 = add i32 1, 9
	%_278 = getelementptr i32, i32* %_270, i32 %_276
	store i32 5, i32* %_278

	ret i32 0
}

