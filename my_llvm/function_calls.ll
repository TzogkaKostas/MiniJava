@.Main_vtable = global [0 x i8*] []

@.A_vtable = global [6 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @A.func_int to i8*),
	i8* bitcast (i32* (i8*, i32*)* @A.func_int_array to i8*),
	i8* bitcast (i1 (i8*, i1)* @A.func_boolean to i8*),
	i8* bitcast (i8* (i8*, i8*)* @A.func_boolean_array to i8*),
	i8* bitcast (i32 (i8*, i32)* @A.decrease to i8*),
	i8* bitcast (i32 (i8*, i32, i32*, i1, i8*, i8*)* @A.func to i8*)
]

@.B_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @B.Init to i8*),
	i8* bitcast (i32 (i8*)* @B.Print to i8*),
	i8* bitcast (i8* (i8*, i8*)* @B.getB to i8*)
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
	%a = alloca i8*
	%b = alloca i8*
	%int_array = alloca i32*
	%boolean_array = alloca i8*
	%i = alloca i32
	%flag = alloca i1

	%_0 = call i8* @calloc(i32 1, i32 12)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [6 x i8*], [6 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = call i8* @calloc(i32 1, i32 12)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	store i8* %_3, i8** %b

	%_6 = load i8*, i8** %b
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 0
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %_6)
	store i32 %_12, i32* %i

	%_14 = add i32 1, 1000
	%_15 = icmp sge i32 %_14, 1
	br i1 %_15, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_16 = call i8* @calloc(i32 %_14, i32 4)
	%_17 = bitcast i8* %_16 to i32*
	store i32 1000, i32* %_17
	store i32* %_17, i32** %int_array

	%_18 = add i32 4, 1000
	%_19 = icmp sge i32 %_18, 4
	br i1 %_19, label %L2, label %L3
L3:
	call void @throw_nsz()
	br label %L2
L2:
	%_20 = call i8* @calloc(i32 1, i32 %_18)
	%_21 = bitcast i8* %_20 to i32*
	store i32 1000, i32* %_21
	store i8* %_20, i8** %boolean_array

	store i32 0, i32* %i

	br label %L4
L4:
	%_22 = load i32, i32* %i
	%_23 = load i32*, i32** %int_array
	%_25 = load i32, i32* %_23
	%_26 = icmp slt i32 %_22, %_25
	br i1 %_26, label %L5, label %L6
L5:
	%_27 = load i32, i32* %i
	%_32 = load i32*, i32** %int_array
	%_34 = load i32, i32* %_32
	%_35 = icmp sge i32 %_27, 0
	%_36 = icmp slt i32 %_27, %_34
	%_37 = and i1 %_36, %_37
	br i1 %_37, label %L7, label %L8
L8:
	call void @throw_oob()
	br label %L7
L7:
	%_38 = add i32 1, %_27
	%_28 = load i32, i32* %i
	%_29 = mul i32 %_28, 2
	%_40 = getelementptr i32, i32* %_32, i32 %_38
	store i32 %_29, i32* %_40

	%_41 = load i32, i32* %i
	%_42 = add i32 %_41, 1
	store i32 %_42, i32* %i


	br label %L4
L6:

	store i32 0, i32* %i

	store i1 1, i1* %flag

	br label %L9
L9:
	%_43 = load i32, i32* %i
	%_44 = load i8*, i8** %boolean_array
	%_45 = bitcast i8* %_44 to i32*	%_46 = load i32, i32* %_45
	%_47 = icmp slt i32 %_43, %_46
	br i1 %_47, label %L10, label %L11
L10:
	%_48 = load i32, i32* %i
	%_52 = load i8*, i8** %boolean_array
	%_53 = bitcast i8* %_52 to i32*
	%_54 = load i32, i32* %_53
	%_55 = icmp sge i32 %_48, 0
	%_56 = icmp slt i32 %_48, %_54
	%_57 = and i1 %_56, %_57
	br i1 %_57, label %L12, label %L13
L13:
	call void @throw_oob()
	br label %L12
L12:
	%_58 = add i32 4, %_48
	%_49 = load i1, i1* %flag
	%_59 = zext i1 %_49 to i8
	%_60 = getelementptr i8, i8* %_52, i32 %_58
	store i8 %_59, i8* %_60

	%_61 = load i1, i1* %flag
	br i1 %_61, label %L14, label %L15
L14:
	br label %L16
L15:
	br label %L16
L16:
	%_62 = phi i1 [0, %L14], [1, %L15]
	store i1 %_62, i1* %flag

	%_63 = load i32, i32* %i
	%_64 = add i32 %_63, 1
	store i32 %_64, i32* %i


	br label %L9
L11:

	%_65 = load i8*, i8** %a
	%_66 = load i8*, i8** %a
	%_67 = load i8*, i8** %a
	%_68 = load i8*, i8** %a
	%_69 = load i8*, i8** %a
	%_70 = load i8*, i8** %a
	%_71 = load i8*, i8** %a
	%_72 = load i8*, i8** %a
	%_73 = bitcast i8* %_72 to i8***
	%_74 = load i8**, i8*** %_73
	%_75 = getelementptr i8*, i8** %_74, i32 0
	%_76 = load i8*, i8** %_75
	%_77 = bitcast i8* %_76 to i32 (i8*, i32)*
	%_78 = call i32 %_77(i8* %_72, i32 1024)
	%_80 = bitcast i8* %_71 to i8***
	%_81 = load i8**, i8*** %_80
	%_82 = getelementptr i8*, i8** %_81, i32 0
	%_83 = load i8*, i8** %_82
	%_84 = bitcast i8* %_83 to i32 (i8*, i32)*
	%_85 = call i32 %_84(i8* %_71, i32 %_78)
	%_87 = bitcast i8* %_70 to i8***
	%_88 = load i8**, i8*** %_87
	%_89 = getelementptr i8*, i8** %_88, i32 0
	%_90 = load i8*, i8** %_89
	%_91 = bitcast i8* %_90 to i32 (i8*, i32)*
	%_92 = call i32 %_91(i8* %_70, i32 %_85)
	%_94 = bitcast i8* %_69 to i8***
	%_95 = load i8**, i8*** %_94
	%_96 = getelementptr i8*, i8** %_95, i32 0
	%_97 = load i8*, i8** %_96
	%_98 = bitcast i8* %_97 to i32 (i8*, i32)*
	%_99 = call i32 %_98(i8* %_69, i32 %_92)
	%_101 = bitcast i8* %_68 to i8***
	%_102 = load i8**, i8*** %_101
	%_103 = getelementptr i8*, i8** %_102, i32 0
	%_104 = load i8*, i8** %_103
	%_105 = bitcast i8* %_104 to i32 (i8*, i32)*
	%_106 = call i32 %_105(i8* %_68, i32 %_99)
	%_108 = bitcast i8* %_67 to i8***
	%_109 = load i8**, i8*** %_108
	%_110 = getelementptr i8*, i8** %_109, i32 0
	%_111 = load i8*, i8** %_110
	%_112 = bitcast i8* %_111 to i32 (i8*, i32)*
	%_113 = call i32 %_112(i8* %_67, i32 %_106)
	%_115 = bitcast i8* %_66 to i8***
	%_116 = load i8**, i8*** %_115
	%_117 = getelementptr i8*, i8** %_116, i32 0
	%_118 = load i8*, i8** %_117
	%_119 = bitcast i8* %_118 to i32 (i8*, i32)*
	%_120 = call i32 %_119(i8* %_66, i32 %_113)
	%_122 = load i8*, i8** %a
	%_123 = load i8*, i8** %a
	%_124 = load i8*, i8** %a
	%_125 = load i8*, i8** %a
	%_126 = load i8*, i8** %a
	%_127 = load i8*, i8** %a
	%_128 = load i32*, i32** %int_array
	%_129 = bitcast i8* %_127 to i8***
	%_130 = load i8**, i8*** %_129
	%_131 = getelementptr i8*, i8** %_130, i32 1
	%_132 = load i8*, i8** %_131
	%_133 = bitcast i8* %_132 to i32* (i8*, i32*)*
	%_134 = call i32* %_133(i8* %_127, i32* %_128)
	%_136 = bitcast i8* %_126 to i8***
	%_137 = load i8**, i8*** %_136
	%_138 = getelementptr i8*, i8** %_137, i32 1
	%_139 = load i8*, i8** %_138
	%_140 = bitcast i8* %_139 to i32* (i8*, i32*)*
	%_141 = call i32* %_140(i8* %_126, i32* %_134)
	%_143 = bitcast i8* %_125 to i8***
	%_144 = load i8**, i8*** %_143
	%_145 = getelementptr i8*, i8** %_144, i32 1
	%_146 = load i8*, i8** %_145
	%_147 = bitcast i8* %_146 to i32* (i8*, i32*)*
	%_148 = call i32* %_147(i8* %_125, i32* %_141)
	%_150 = bitcast i8* %_124 to i8***
	%_151 = load i8**, i8*** %_150
	%_152 = getelementptr i8*, i8** %_151, i32 1
	%_153 = load i8*, i8** %_152
	%_154 = bitcast i8* %_153 to i32* (i8*, i32*)*
	%_155 = call i32* %_154(i8* %_124, i32* %_148)
	%_157 = bitcast i8* %_123 to i8***
	%_158 = load i8**, i8*** %_157
	%_159 = getelementptr i8*, i8** %_158, i32 1
	%_160 = load i8*, i8** %_159
	%_161 = bitcast i8* %_160 to i32* (i8*, i32*)*
	%_162 = call i32* %_161(i8* %_123, i32* %_155)
	%_164 = bitcast i8* %_122 to i8***
	%_165 = load i8**, i8*** %_164
	%_166 = getelementptr i8*, i8** %_165, i32 1
	%_167 = load i8*, i8** %_166
	%_168 = bitcast i8* %_167 to i32* (i8*, i32*)*
	%_169 = call i32* %_168(i8* %_122, i32* %_162)
	%_171 = load i8*, i8** %a
	%_172 = load i8*, i8** %a
	%_173 = load i8*, i8** %a
	%_174 = load i8*, i8** %a
	%_175 = load i8*, i8** %a
	%_176 = load i8*, i8** %a
	%_177 = load i8*, i8** %a
	%_178 = bitcast i8* %_177 to i8***
	%_179 = load i8**, i8*** %_178
	%_180 = getelementptr i8*, i8** %_179, i32 2
	%_181 = load i8*, i8** %_180
	%_182 = bitcast i8* %_181 to i1 (i8*, i1)*
	%_183 = call i1 %_182(i8* %_177, i1 1)
	%_185 = bitcast i8* %_176 to i8***
	%_186 = load i8**, i8*** %_185
	%_187 = getelementptr i8*, i8** %_186, i32 2
	%_188 = load i8*, i8** %_187
	%_189 = bitcast i8* %_188 to i1 (i8*, i1)*
	%_190 = call i1 %_189(i8* %_176, i1 %_183)
	%_192 = bitcast i8* %_175 to i8***
	%_193 = load i8**, i8*** %_192
	%_194 = getelementptr i8*, i8** %_193, i32 2
	%_195 = load i8*, i8** %_194
	%_196 = bitcast i8* %_195 to i1 (i8*, i1)*
	%_197 = call i1 %_196(i8* %_175, i1 %_190)
	%_199 = bitcast i8* %_174 to i8***
	%_200 = load i8**, i8*** %_199
	%_201 = getelementptr i8*, i8** %_200, i32 2
	%_202 = load i8*, i8** %_201
	%_203 = bitcast i8* %_202 to i1 (i8*, i1)*
	%_204 = call i1 %_203(i8* %_174, i1 %_197)
	%_206 = bitcast i8* %_173 to i8***
	%_207 = load i8**, i8*** %_206
	%_208 = getelementptr i8*, i8** %_207, i32 2
	%_209 = load i8*, i8** %_208
	%_210 = bitcast i8* %_209 to i1 (i8*, i1)*
	%_211 = call i1 %_210(i8* %_173, i1 %_204)
	%_213 = bitcast i8* %_172 to i8***
	%_214 = load i8**, i8*** %_213
	%_215 = getelementptr i8*, i8** %_214, i32 2
	%_216 = load i8*, i8** %_215
	%_217 = bitcast i8* %_216 to i1 (i8*, i1)*
	%_218 = call i1 %_217(i8* %_172, i1 %_211)
	%_220 = bitcast i8* %_171 to i8***
	%_221 = load i8**, i8*** %_220
	%_222 = getelementptr i8*, i8** %_221, i32 2
	%_223 = load i8*, i8** %_222
	%_224 = bitcast i8* %_223 to i1 (i8*, i1)*
	%_225 = call i1 %_224(i8* %_171, i1 %_218)
	%_227 = load i8*, i8** %a
	%_228 = load i8*, i8** %a
	%_229 = load i8*, i8** %a
	%_230 = load i8*, i8** %a
	%_231 = load i8*, i8** %a
	%_232 = load i8*, i8** %boolean_array
	%_233 = bitcast i8* %_231 to i8***
	%_234 = load i8**, i8*** %_233
	%_235 = getelementptr i8*, i8** %_234, i32 3
	%_236 = load i8*, i8** %_235
	%_237 = bitcast i8* %_236 to i8* (i8*, i8*)*
	%_238 = call i8* %_237(i8* %_231, i8* %_232)
	%_240 = bitcast i8* %_230 to i8***
	%_241 = load i8**, i8*** %_240
	%_242 = getelementptr i8*, i8** %_241, i32 3
	%_243 = load i8*, i8** %_242
	%_244 = bitcast i8* %_243 to i8* (i8*, i8*)*
	%_245 = call i8* %_244(i8* %_230, i8* %_238)
	%_247 = bitcast i8* %_229 to i8***
	%_248 = load i8**, i8*** %_247
	%_249 = getelementptr i8*, i8** %_248, i32 3
	%_250 = load i8*, i8** %_249
	%_251 = bitcast i8* %_250 to i8* (i8*, i8*)*
	%_252 = call i8* %_251(i8* %_229, i8* %_245)
	%_254 = bitcast i8* %_228 to i8***
	%_255 = load i8**, i8*** %_254
	%_256 = getelementptr i8*, i8** %_255, i32 3
	%_257 = load i8*, i8** %_256
	%_258 = bitcast i8* %_257 to i8* (i8*, i8*)*
	%_259 = call i8* %_258(i8* %_228, i8* %_252)
	%_261 = bitcast i8* %_227 to i8***
	%_262 = load i8**, i8*** %_261
	%_263 = getelementptr i8*, i8** %_262, i32 3
	%_264 = load i8*, i8** %_263
	%_265 = bitcast i8* %_264 to i8* (i8*, i8*)*
	%_266 = call i8* %_265(i8* %_227, i8* %_259)
	%_268 = load i8*, i8** %b
	%_269 = load i8*, i8** %b
	%_270 = load i8*, i8** %b
	%_271 = load i8*, i8** %b
	%_272 = load i8*, i8** %b
	%_273 = load i8*, i8** %b
	%_274 = bitcast i8* %_272 to i8***
	%_275 = load i8**, i8*** %_274
	%_276 = getelementptr i8*, i8** %_275, i32 2
	%_277 = load i8*, i8** %_276
	%_278 = bitcast i8* %_277 to i8* (i8*, i8*)*
	%_279 = call i8* %_278(i8* %_272, i8* %_273)
	%_281 = bitcast i8* %_271 to i8***
	%_282 = load i8**, i8*** %_281
	%_283 = getelementptr i8*, i8** %_282, i32 2
	%_284 = load i8*, i8** %_283
	%_285 = bitcast i8* %_284 to i8* (i8*, i8*)*
	%_286 = call i8* %_285(i8* %_271, i8* %_279)
	%_288 = bitcast i8* %_270 to i8***
	%_289 = load i8**, i8*** %_288
	%_290 = getelementptr i8*, i8** %_289, i32 2
	%_291 = load i8*, i8** %_290
	%_292 = bitcast i8* %_291 to i8* (i8*, i8*)*
	%_293 = call i8* %_292(i8* %_270, i8* %_286)
	%_295 = bitcast i8* %_269 to i8***
	%_296 = load i8**, i8*** %_295
	%_297 = getelementptr i8*, i8** %_296, i32 2
	%_298 = load i8*, i8** %_297
	%_299 = bitcast i8* %_298 to i8* (i8*, i8*)*
	%_300 = call i8* %_299(i8* %_269, i8* %_293)
	%_302 = bitcast i8* %_268 to i8***
	%_303 = load i8**, i8*** %_302
	%_304 = getelementptr i8*, i8** %_303, i32 2
	%_305 = load i8*, i8** %_304
	%_306 = bitcast i8* %_305 to i8* (i8*, i8*)*
	%_307 = call i8* %_306(i8* %_268, i8* %_300)
	%_309 = bitcast i8* %_65 to i8***
	%_310 = load i8**, i8*** %_309
	%_311 = getelementptr i8*, i8** %_310, i32 5
	%_312 = load i8*, i8** %_311
	%_313 = bitcast i8* %_312 to i32 (i8*, i32, i32*, i1, i8*, i8*)*
	%_314 = call i32 %_313(i8* %_65, i32 %_120, i32* %_169, i1 %_225, i8* %_266, i8* %_307)
	store i32 %_314, i32* %i

	ret i32 0
}

define i32 @A.func_int(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_316 = load i32, i32* %i
	%_317 = getelementptr i8, i8* %this, i32 8
	%_318 = bitcast i8* %_317 to i32*
	store i32 %_316, i32* %_318

	%_319 = load i32, i32* %i
	ret i32 %_319
}

define i32* @A.func_int_array(i8* %this, i32* %.arr) {
	%arr = alloca i32*
	store i32* %.arr, i32** %arr

	%_320 = load i32*, i32** %arr
	ret i32* %_320
}

define i1 @A.func_boolean(i8* %this, i1 %.b) {
	%b = alloca i1
	store i1 %.b, i1* %b

	%_321 = load i1, i1* %b
	ret i1 %_321
}

define i8* @A.func_boolean_array(i8* %this, i8* %.arr) {
	%arr = alloca i8*
	store i8* %.arr, i8** %arr

	%_322 = load i8*, i8** %arr
	ret i8* %_322
}

define i32 @A.decrease(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_323 = load i32, i32* %i
	%_324 = sub i32 %_323, 1
	store i32 %_324, i32* %i

	%_325 = load i32, i32* %i
	ret i32 %_325
}

define i32 @A.func(i8* %this, i32 %.i, i32* %.int_arr, i1 %.b, i8* %.b_arr, i8* %.c_b) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%int_arr = alloca i32*
	store i32* %.int_arr, i32** %int_arr
	%b = alloca i1
	store i1 %.b, i1* %b
	%b_arr = alloca i8*
	store i8* %.b_arr, i8** %b_arr
	%c_b = alloca i8*
	store i8* %.c_b, i8** %c_b
	%j = alloca i32
	%sum = alloca i32

	%_327 = getelementptr i8, i8* %this, i32 8
	%_328 = bitcast i8* %_327 to i32*
	%_326 = load i32, i32* %_328
	call void (i32) @print_int(i32 %_326)

	%_329 = load i32, i32* %i
	call void (i32) @print_int(i32 %_329)

	%_330 = load i32*, i32** %int_arr
	%_332 = load i32, i32* %_330
	call void (i32) @print_int(i32 %_332)

	store i32 0, i32* %j

	store i32 0, i32* %sum

	br label %L17
L17:
	%_333 = load i32, i32* %j
	%_334 = load i32*, i32** %int_arr
	%_336 = load i32, i32* %_334
	%_337 = icmp slt i32 %_333, %_336
	br i1 %_337, label %L18, label %L19
L18:
	%_338 = load i32*, i32** %int_arr
	%_339 = load i32, i32* %j
	%_341 = load i32, i32* %_338
	%_342 = icmp sge i32 %_339, 0
	%_343 = icmp slt i32 %_339, %_341
	%_344 = and i1 %_342, %_343
	br i1 %_344, label %L20, label %L21
L21:
	call void @throw_oob()
	br label %L20
L20:
	%_345 = add i32 1, %_339
	%_346 = getelementptr i32, i32* %_338, i32 %_345
	%_347 = load i32, i32* %_346
	%_349 = load i32, i32* %sum
	%_350 = add i32 %_347, %_349
	store i32 %_350, i32* %sum

	%_351 = load i32, i32* %j
	%_352 = add i32 %_351, 1
	store i32 %_352, i32* %j


	br label %L17
L19:

	%_353 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_353)

	%_354 = load i1, i1* %b
	br i1 %_354, label %L22, label %L23
L22:
	call void (i32) @print_int(i32 1)


	br label %L24
L23:
	call void (i32) @print_int(i32 0)


	br label %L24
L24:

	%_355 = load i8*, i8** %b_arr
	%_356 = bitcast i8* %_355 to i32*	%_357 = load i32, i32* %_356
	call void (i32) @print_int(i32 %_357)

	store i32 0, i32* %j

	store i32 0, i32* %sum

	%_358 = load i8*, i8** %b_arr
	%_359 = load i32, i32* %j
	%_360 = bitcast i8* %_358 to i32*
	%_361 = load i32, i32* %_360
	%_362 = icmp sge i32 %_359, 0
	%_363 = icmp slt i32 %_359, %_361
	%_364 = and i1 %_362, %_363
	br i1 %_364, label %L25, label %L26
L26:
	call void @throw_oob()
	br label %L25
L25:
	%_365 = add i32 4, %_359
	%_366 = getelementptr i8, i8* %_358, i32 %_365
	%_367 = load i8, i8* %_366
	%_368 = trunc i8 %_367 to i1
	br i1 %_368, label %L27, label %L28
L27:
	%_369 = load i32, i32* %sum
	%_370 = add i32 %_369, 1
	store i32 %_370, i32* %sum


	br label %L29
L28:
	%_371 = load i32, i32* %sum
	%_372 = add i32 %_371, 10
	store i32 %_372, i32* %sum


	br label %L29
L29:

	%_373 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_373)

	%_374 = load i8*, i8** %c_b
	%_375 = bitcast i8* %_374 to i8***
	%_376 = load i8**, i8*** %_375
	%_377 = getelementptr i8*, i8** %_376, i32 1
	%_378 = load i8*, i8** %_377
	%_379 = bitcast i8* %_378 to i32 (i8*)*
	%_380 = call i32 %_379(i8* %_374)
	store i32 %_380, i32* %j

	%_382 = load i32, i32* %j
	ret i32 %_382
}

define i32 @B.Init(i8* %this) {

	%_383 = getelementptr i8, i8* %this, i32 8
	%_384 = bitcast i8* %_383 to i32*
	store i32 1048576, i32* %_384

	ret i32 1
}

define i32 @B.Print(i8* %this) {

	%_386 = getelementptr i8, i8* %this, i32 8
	%_387 = bitcast i8* %_386 to i32*
	%_385 = load i32, i32* %_387
	call void (i32) @print_int(i32 %_385)

	ret i32 1
}

define i8* @B.getB(i8* %this, i8* %.b) {
	%b = alloca i8*
	store i8* %.b, i8** %b

	%_388 = load i8*, i8** %b
	ret i8* %_388
}

