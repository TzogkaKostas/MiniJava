@.QuickSort_vtable = global [0 x i8*] []

@.QS_vtable = global [4 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @QS.Start to i8*),
	i8* bitcast (i32 (i8*, i32, i32)* @QS.Sort to i8*),
	i8* bitcast (i32 (i8*)* @QS.Print to i8*),
	i8* bitcast (i32 (i8*, i32)* @QS.Init to i8*)
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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0
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

define i32 @QS.Start(i8* %this, i32 %.sz) {
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

	call void (i32) @print_int(i32 9999)

	%_26 = getelementptr i8, i8* %this, i32 16
	%_27 = bitcast i8* %_26 to i32*
	%_25 = load i32, i32* %_27
	%_28 =  sub i32 %_25, 1
	store i32 %_28, i32* %aux01

	%_29 = load i32, i32* %aux01
	%_30 = bitcast i8* %this to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 1
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i32 (i8*, i32, i32)*
	%_35 = call i32 %_34(i8* %this, i32 0, i32 %_29)
	store i32 %_35, i32* %aux01

	%_37 = bitcast i8* %this to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 2
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i32 (i8*)*
	%_42 = call i32 %_41(i8* %this)
	store i32 %_42, i32* %aux01

	ret i32 0
}

define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
	%left = alloca i32
	store i32 %.left, i32* %left
	%right = alloca i32
	store i32 %.right, i32* %right
	%v = alloca i32
	%i = alloca i32
	%j = alloca i32
	%nt = alloca i32
	%t = alloca i32
	%cont01 = alloca i1
	%cont02 = alloca i1
	%aux03 = alloca i32

	store i32 0, i32* %t

	%_44 = load i32, i32* %left
	%_45 = load i32, i32* %right
	%_46 = icmp slt i32 %_44, %_45
	br i1 %_46, label %L0, label %L1
L0:
	%_48 = getelementptr i8, i8* %this, i32 8
	%_49 = bitcast i8* %_48 to i32**
	%_47 = load i32*, i32** %_49
	%_50 = load i32, i32* %right
	%_52 = load i32, i32* %_47
	%_53 = icmp sge i32 %_50, 0
	%_54 = icmp slt i32 %_50, %_52
	%_55 = and i1 %_53, %_54
	br i1 %_55, label %L3, label %L4
L4:
	call void @throw_oob()
	br label %L3
L3:
	%_56 = add i32 1, %_50
	%_57 = getelementptr i32, i32* %_47, i32 %_56
	%_58 = load i32, i32* %_57
	store i32 %_58, i32* %v

	%_60 = load i32, i32* %left
	%_61 =  sub i32 %_60, 1
	store i32 %_61, i32* %i

	%_62 = load i32, i32* %right
	store i32 %_62, i32* %j

	store i1 1, i1* %cont01

	br label %L5
L5:
	%_63 = load i1, i1* %cont01
	br i1 %_63, label %L6, label %L7
L6:
	store i1 1, i1* %cont02

	br label %L8
L8:
	%_64 = load i1, i1* %cont02
	br i1 %_64, label %L9, label %L10
L9:
	%_65 = load i32, i32* %i
	%_66 = add i32 %_65, 1
	store i32 %_66, i32* %i

	%_68 = getelementptr i8, i8* %this, i32 8
	%_69 = bitcast i8* %_68 to i32**
	%_67 = load i32*, i32** %_69
	%_70 = load i32, i32* %i
	%_72 = load i32, i32* %_67
	%_73 = icmp sge i32 %_70, 0
	%_74 = icmp slt i32 %_70, %_72
	%_75 = and i1 %_73, %_74
	br i1 %_75, label %L11, label %L12
L12:
	call void @throw_oob()
	br label %L11
L11:
	%_76 = add i32 1, %_70
	%_77 = getelementptr i32, i32* %_67, i32 %_76
	%_78 = load i32, i32* %_77
	store i32 %_78, i32* %aux03

	%_80 = load i32, i32* %aux03
	%_81 = load i32, i32* %v
	%_82 = icmp slt i32 %_80, %_81
	br i1 %_82, label %L13, label %L14
L13:
	br label %L15
L14:
	br label %L15
L15:
	%_83 = phi i1 [0, %L13], [1, %L14]
	br i1 %_83, label %L16, label %L17
L16:
	store i1 0, i1* %cont02

	br label %L18
L17:
	store i1 1, i1* %cont02

	br label %L18
L18:


	br label %L8
L10:

	store i1 1, i1* %cont02

	br label %L19
L19:
	%_84 = load i1, i1* %cont02
	br i1 %_84, label %L20, label %L21
L20:
	%_85 = load i32, i32* %j
	%_86 =  sub i32 %_85, 1
	store i32 %_86, i32* %j

	%_88 = getelementptr i8, i8* %this, i32 8
	%_89 = bitcast i8* %_88 to i32**
	%_87 = load i32*, i32** %_89
	%_90 = load i32, i32* %j
	%_92 = load i32, i32* %_87
	%_93 = icmp sge i32 %_90, 0
	%_94 = icmp slt i32 %_90, %_92
	%_95 = and i1 %_93, %_94
	br i1 %_95, label %L22, label %L23
L23:
	call void @throw_oob()
	br label %L22
L22:
	%_96 = add i32 1, %_90
	%_97 = getelementptr i32, i32* %_87, i32 %_96
	%_98 = load i32, i32* %_97
	store i32 %_98, i32* %aux03

	%_100 = load i32, i32* %v
	%_101 = load i32, i32* %aux03
	%_102 = icmp slt i32 %_100, %_101
	br i1 %_102, label %L24, label %L25
L24:
	br label %L26
L25:
	br label %L26
L26:
	%_103 = phi i1 [0, %L24], [1, %L25]
	br i1 %_103, label %L27, label %L28
L27:
	store i1 0, i1* %cont02

	br label %L29
L28:
	store i1 1, i1* %cont02

	br label %L29
L29:


	br label %L19
L21:

	%_105 = getelementptr i8, i8* %this, i32 8
	%_106 = bitcast i8* %_105 to i32**
	%_104 = load i32*, i32** %_106
	%_107 = load i32, i32* %i
	%_109 = load i32, i32* %_104
	%_110 = icmp sge i32 %_107, 0
	%_111 = icmp slt i32 %_107, %_109
	%_112 = and i1 %_110, %_111
	br i1 %_112, label %L30, label %L31
L31:
	call void @throw_oob()
	br label %L30
L30:
	%_113 = add i32 1, %_107
	%_114 = getelementptr i32, i32* %_104, i32 %_113
	%_115 = load i32, i32* %_114
	store i32 %_115, i32* %t

	%_117 = load i32, i32* %i
	%_131 = getelementptr i8, i8* %this, i32 8
	%_132 = bitcast i8* %_131 to i32**
	%_133 = load i32*, i32** %_132
	%_135 = load i32, i32* %_133
	%_136 = icmp sge i32 %_117, 0
	%_137 = icmp slt i32 %_117, %_135
	%_138 = and i1 %_137, %_138
	br i1 %_138, label %L34, label %L35
L35:
	call void @throw_oob()
	br label %L34
L34:
	%_139 = add i32 1, %_117
	%_119 = getelementptr i8, i8* %this, i32 8
	%_120 = bitcast i8* %_119 to i32**
	%_118 = load i32*, i32** %_120
	%_121 = load i32, i32* %j
	%_123 = load i32, i32* %_118
	%_124 = icmp sge i32 %_121, 0
	%_125 = icmp slt i32 %_121, %_123
	%_126 = and i1 %_124, %_125
	br i1 %_126, label %L32, label %L33
L33:
	call void @throw_oob()
	br label %L32
L32:
	%_127 = add i32 1, %_121
	%_128 = getelementptr i32, i32* %_118, i32 %_127
	%_129 = load i32, i32* %_128
	%_141 = getelementptr i32, i32* %_133, i32 %_139
	store i32 %_129, i32* %_141

	%_142 = load i32, i32* %j
	%_144 = getelementptr i8, i8* %this, i32 8
	%_145 = bitcast i8* %_144 to i32**
	%_146 = load i32*, i32** %_145
	%_148 = load i32, i32* %_146
	%_149 = icmp sge i32 %_142, 0
	%_150 = icmp slt i32 %_142, %_148
	%_151 = and i1 %_150, %_151
	br i1 %_151, label %L36, label %L37
L37:
	call void @throw_oob()
	br label %L36
L36:
	%_152 = add i32 1, %_142
	%_143 = load i32, i32* %t
	%_154 = getelementptr i32, i32* %_146, i32 %_152
	store i32 %_143, i32* %_154

	%_155 = load i32, i32* %j
	%_156 = load i32, i32* %i
	%_157 = add i32 %_156, 1
	%_158 = icmp slt i32 %_155, %_157
	br i1 %_158, label %L38, label %L39
L38:
	store i1 0, i1* %cont01

	br label %L40
L39:
	store i1 1, i1* %cont01

	br label %L40
L40:


	br label %L5
L7:

	%_159 = load i32, i32* %j
	%_173 = getelementptr i8, i8* %this, i32 8
	%_174 = bitcast i8* %_173 to i32**
	%_175 = load i32*, i32** %_174
	%_177 = load i32, i32* %_175
	%_178 = icmp sge i32 %_159, 0
	%_179 = icmp slt i32 %_159, %_177
	%_180 = and i1 %_179, %_180
	br i1 %_180, label %L43, label %L44
L44:
	call void @throw_oob()
	br label %L43
L43:
	%_181 = add i32 1, %_159
	%_161 = getelementptr i8, i8* %this, i32 8
	%_162 = bitcast i8* %_161 to i32**
	%_160 = load i32*, i32** %_162
	%_163 = load i32, i32* %i
	%_165 = load i32, i32* %_160
	%_166 = icmp sge i32 %_163, 0
	%_167 = icmp slt i32 %_163, %_165
	%_168 = and i1 %_166, %_167
	br i1 %_168, label %L41, label %L42
L42:
	call void @throw_oob()
	br label %L41
L41:
	%_169 = add i32 1, %_163
	%_170 = getelementptr i32, i32* %_160, i32 %_169
	%_171 = load i32, i32* %_170
	%_183 = getelementptr i32, i32* %_175, i32 %_181
	store i32 %_171, i32* %_183

	%_184 = load i32, i32* %i
	%_198 = getelementptr i8, i8* %this, i32 8
	%_199 = bitcast i8* %_198 to i32**
	%_200 = load i32*, i32** %_199
	%_202 = load i32, i32* %_200
	%_203 = icmp sge i32 %_184, 0
	%_204 = icmp slt i32 %_184, %_202
	%_205 = and i1 %_204, %_205
	br i1 %_205, label %L47, label %L48
L48:
	call void @throw_oob()
	br label %L47
L47:
	%_206 = add i32 1, %_184
	%_186 = getelementptr i8, i8* %this, i32 8
	%_187 = bitcast i8* %_186 to i32**
	%_185 = load i32*, i32** %_187
	%_188 = load i32, i32* %right
	%_190 = load i32, i32* %_185
	%_191 = icmp sge i32 %_188, 0
	%_192 = icmp slt i32 %_188, %_190
	%_193 = and i1 %_191, %_192
	br i1 %_193, label %L45, label %L46
L46:
	call void @throw_oob()
	br label %L45
L45:
	%_194 = add i32 1, %_188
	%_195 = getelementptr i32, i32* %_185, i32 %_194
	%_196 = load i32, i32* %_195
	%_208 = getelementptr i32, i32* %_200, i32 %_206
	store i32 %_196, i32* %_208

	%_209 = load i32, i32* %right
	%_211 = getelementptr i8, i8* %this, i32 8
	%_212 = bitcast i8* %_211 to i32**
	%_213 = load i32*, i32** %_212
	%_215 = load i32, i32* %_213
	%_216 = icmp sge i32 %_209, 0
	%_217 = icmp slt i32 %_209, %_215
	%_218 = and i1 %_217, %_218
	br i1 %_218, label %L49, label %L50
L50:
	call void @throw_oob()
	br label %L49
L49:
	%_219 = add i32 1, %_209
	%_210 = load i32, i32* %t
	%_221 = getelementptr i32, i32* %_213, i32 %_219
	store i32 %_210, i32* %_221

	%_222 = load i32, i32* %left
	%_223 = load i32, i32* %i
	%_224 =  sub i32 %_223, 1
	%_225 = bitcast i8* %this to i8***
	%_226 = load i8**, i8*** %_225
	%_227 = getelementptr i8*, i8** %_226, i32 1
	%_228 = load i8*, i8** %_227
	%_229 = bitcast i8* %_228 to i32 (i8*, i32, i32)*
	%_230 = call i32 %_229(i8* %this, i32 %_222, i32 %_224)
	store i32 %_230, i32* %nt

	%_232 = load i32, i32* %i
	%_233 = add i32 %_232, 1
	%_234 = load i32, i32* %right
	%_235 = bitcast i8* %this to i8***
	%_236 = load i8**, i8*** %_235
	%_237 = getelementptr i8*, i8** %_236, i32 1
	%_238 = load i8*, i8** %_237
	%_239 = bitcast i8* %_238 to i32 (i8*, i32, i32)*
	%_240 = call i32 %_239(i8* %this, i32 %_233, i32 %_234)
	store i32 %_240, i32* %nt


	br label %L2
L1:
	store i32 0, i32* %nt

	br label %L2
L2:

	ret i32 0
}

define i32 @QS.Print(i8* %this) {
	%j = alloca i32

	store i32 0, i32* %j

	br label %L51
L51:
	%_242 = load i32, i32* %j
	%_244 = getelementptr i8, i8* %this, i32 16
	%_245 = bitcast i8* %_244 to i32*
	%_243 = load i32, i32* %_245
	%_246 = icmp slt i32 %_242, %_243
	br i1 %_246, label %L52, label %L53
L52:
	%_248 = getelementptr i8, i8* %this, i32 8
	%_249 = bitcast i8* %_248 to i32**
	%_247 = load i32*, i32** %_249
	%_250 = load i32, i32* %j
	%_252 = load i32, i32* %_247
	%_253 = icmp sge i32 %_250, 0
	%_254 = icmp slt i32 %_250, %_252
	%_255 = and i1 %_253, %_254
	br i1 %_255, label %L54, label %L55
L55:
	call void @throw_oob()
	br label %L54
L54:
	%_256 = add i32 1, %_250
	%_257 = getelementptr i32, i32* %_247, i32 %_256
	%_258 = load i32, i32* %_257
	call void (i32) @print_int(i32 %_258)

	%_260 = load i32, i32* %j
	%_261 = add i32 %_260, 1
	store i32 %_261, i32* %j


	br label %L51
L53:

	ret i32 0
}

define i32 @QS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz

	%_262 = load i32, i32* %sz
	%_263 = getelementptr i8, i8* %this, i32 16
	%_264 = bitcast i8* %_263 to i32*
	store i32 %_262, i32* %_264

	%_265 = load i32, i32* %sz
	%_266 = add i32 1, %_265
	%_267 = icmp sge i32 %_266, 1
	br i1 %_267, label %L56, label %L57
L57:
	call void @throw_nsz()
	br label %L56
L56:
	%_268 = call i8* @calloc(i32 %_266, i32 4)
	%_269 = bitcast i8* %_268 to i32*
	store i32 %_265, i32* %_269
	%_270 = getelementptr i8, i8* %this, i32 8
	%_271 = bitcast i8* %_270 to i32**
	store i32* %_269, i32** %_271

	%_272 = getelementptr i8, i8* %this, i32 8
	%_273 = bitcast i8* %_272 to i32**
	%_274 = load i32*, i32** %_273
	%_276 = load i32, i32* %_274
	%_277 = icmp sge i32 0, 0
	%_278 = icmp slt i32 0, %_276
	%_279 = and i1 %_278, %_279
	br i1 %_279, label %L58, label %L59
L59:
	call void @throw_oob()
	br label %L58
L58:
	%_280 = add i32 1, 0
	%_282 = getelementptr i32, i32* %_274, i32 %_280
	store i32 20, i32* %_282

	%_283 = getelementptr i8, i8* %this, i32 8
	%_284 = bitcast i8* %_283 to i32**
	%_285 = load i32*, i32** %_284
	%_287 = load i32, i32* %_285
	%_288 = icmp sge i32 1, 0
	%_289 = icmp slt i32 1, %_287
	%_290 = and i1 %_289, %_290
	br i1 %_290, label %L60, label %L61
L61:
	call void @throw_oob()
	br label %L60
L60:
	%_291 = add i32 1, 1
	%_293 = getelementptr i32, i32* %_285, i32 %_291
	store i32 7, i32* %_293

	%_294 = getelementptr i8, i8* %this, i32 8
	%_295 = bitcast i8* %_294 to i32**
	%_296 = load i32*, i32** %_295
	%_298 = load i32, i32* %_296
	%_299 = icmp sge i32 2, 0
	%_300 = icmp slt i32 2, %_298
	%_301 = and i1 %_300, %_301
	br i1 %_301, label %L62, label %L63
L63:
	call void @throw_oob()
	br label %L62
L62:
	%_302 = add i32 1, 2
	%_304 = getelementptr i32, i32* %_296, i32 %_302
	store i32 12, i32* %_304

	%_305 = getelementptr i8, i8* %this, i32 8
	%_306 = bitcast i8* %_305 to i32**
	%_307 = load i32*, i32** %_306
	%_309 = load i32, i32* %_307
	%_310 = icmp sge i32 3, 0
	%_311 = icmp slt i32 3, %_309
	%_312 = and i1 %_311, %_312
	br i1 %_312, label %L64, label %L65
L65:
	call void @throw_oob()
	br label %L64
L64:
	%_313 = add i32 1, 3
	%_315 = getelementptr i32, i32* %_307, i32 %_313
	store i32 18, i32* %_315

	%_316 = getelementptr i8, i8* %this, i32 8
	%_317 = bitcast i8* %_316 to i32**
	%_318 = load i32*, i32** %_317
	%_320 = load i32, i32* %_318
	%_321 = icmp sge i32 4, 0
	%_322 = icmp slt i32 4, %_320
	%_323 = and i1 %_322, %_323
	br i1 %_323, label %L66, label %L67
L67:
	call void @throw_oob()
	br label %L66
L66:
	%_324 = add i32 1, 4
	%_326 = getelementptr i32, i32* %_318, i32 %_324
	store i32 2, i32* %_326

	%_327 = getelementptr i8, i8* %this, i32 8
	%_328 = bitcast i8* %_327 to i32**
	%_329 = load i32*, i32** %_328
	%_331 = load i32, i32* %_329
	%_332 = icmp sge i32 5, 0
	%_333 = icmp slt i32 5, %_331
	%_334 = and i1 %_333, %_334
	br i1 %_334, label %L68, label %L69
L69:
	call void @throw_oob()
	br label %L68
L68:
	%_335 = add i32 1, 5
	%_337 = getelementptr i32, i32* %_329, i32 %_335
	store i32 11, i32* %_337

	%_338 = getelementptr i8, i8* %this, i32 8
	%_339 = bitcast i8* %_338 to i32**
	%_340 = load i32*, i32** %_339
	%_342 = load i32, i32* %_340
	%_343 = icmp sge i32 6, 0
	%_344 = icmp slt i32 6, %_342
	%_345 = and i1 %_344, %_345
	br i1 %_345, label %L70, label %L71
L71:
	call void @throw_oob()
	br label %L70
L70:
	%_346 = add i32 1, 6
	%_348 = getelementptr i32, i32* %_340, i32 %_346
	store i32 6, i32* %_348

	%_349 = getelementptr i8, i8* %this, i32 8
	%_350 = bitcast i8* %_349 to i32**
	%_351 = load i32*, i32** %_350
	%_353 = load i32, i32* %_351
	%_354 = icmp sge i32 7, 0
	%_355 = icmp slt i32 7, %_353
	%_356 = and i1 %_355, %_356
	br i1 %_356, label %L72, label %L73
L73:
	call void @throw_oob()
	br label %L72
L72:
	%_357 = add i32 1, 7
	%_359 = getelementptr i32, i32* %_351, i32 %_357
	store i32 9, i32* %_359

	%_360 = getelementptr i8, i8* %this, i32 8
	%_361 = bitcast i8* %_360 to i32**
	%_362 = load i32*, i32** %_361
	%_364 = load i32, i32* %_362
	%_365 = icmp sge i32 8, 0
	%_366 = icmp slt i32 8, %_364
	%_367 = and i1 %_366, %_367
	br i1 %_367, label %L74, label %L75
L75:
	call void @throw_oob()
	br label %L74
L74:
	%_368 = add i32 1, 8
	%_370 = getelementptr i32, i32* %_362, i32 %_368
	store i32 19, i32* %_370

	%_371 = getelementptr i8, i8* %this, i32 8
	%_372 = bitcast i8* %_371 to i32**
	%_373 = load i32*, i32** %_372
	%_375 = load i32, i32* %_373
	%_376 = icmp sge i32 9, 0
	%_377 = icmp slt i32 9, %_375
	%_378 = and i1 %_377, %_378
	br i1 %_378, label %L76, label %L77
L77:
	call void @throw_oob()
	br label %L76
L76:
	%_379 = add i32 1, 9
	%_381 = getelementptr i32, i32* %_373, i32 %_379
	store i32 5, i32* %_381

	ret i32 0
}

