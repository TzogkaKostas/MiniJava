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

	%_13 = add i32 1, 1000
	%_14 = icmp sge i32 %_13, 1
	br i1 %_14, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_15 = call i8* @calloc(i32 %_13, i32 4)
	%_16 = bitcast i8* %_15 to i32*
	store i32 1000, i32* %_16
	store i32* %_16, i32** %int_array

	%_17 = add i32 4, 1000
	%_18 = icmp sge i32 %_17, 4
	br i1 %_18, label %L2, label %L3
L3:
	call void @throw_nsz()
	br label %L2
L2:
	%_19 = call i8* @calloc(i32 1, i32 %_17)
	%_20 = bitcast i8* %_19 to i32*
	store i32 1000, i32* %_20
	store i8* %_19, i8** %boolean_array

	store i32 0, i32* %i

	br label %L4
L4:
	%_21 = load i32, i32* %i
	%_22 = load i32*, i32** %int_array
	%_24 = load i32, i32* %_22
	%_25 = icmp slt i32 %_21, %_24
	br i1 %_25, label %L5, label %L6
L5:
	%_26 = load i32, i32* %i
	%_31 = load i32*, i32** %int_array
	%_33 = load i32, i32* %_31
	%_34 = icmp sge i32 %_26, 0
	%_35 = icmp slt i32 %_26, %_33
	%_36 = and i1 %_35, %_36
	br i1 %_36, label %L7, label %L8
L8:
	call void @throw_oob()
	br label %L7
L7:
	%_37 = add i32 1, %_26
	%_27 = load i32, i32* %i
	%_28 = mul i32 %_27, 2
	%_39 = getelementptr i32, i32* %_31, i32 %_37
	store i32 %_28, i32* %_39

	%_40 = load i32, i32* %i
	%_41 = add i32 %_40, 1
	store i32 %_41, i32* %i


	br label %L4
L6:

	store i32 0, i32* %i

	store i1 1, i1* %flag

	br label %L9
L9:
	%_42 = load i32, i32* %i
	%_43 = load i8*, i8** %boolean_array
	%_44 = bitcast i8* %_43 to i32*	%_45 = load i32, i32* %_44
	%_46 = icmp slt i32 %_42, %_45
	br i1 %_46, label %L10, label %L11
L10:
	%_47 = load i32, i32* %i
	%_51 = load i8*, i8** %boolean_array
	%_52 = bitcast i8* %_51 to i32*
	%_53 = load i32, i32* %_52
	%_54 = icmp sge i32 %_47, 0
	%_55 = icmp slt i32 %_47, %_53
	%_56 = and i1 %_55, %_56
	br i1 %_56, label %L12, label %L13
L13:
	call void @throw_oob()
	br label %L12
L12:
	%_57 = add i32 4, %_47
	%_48 = load i1, i1* %flag
	%_58 = zext i1 %_48 to i8
	%_59 = getelementptr i8, i8* %_51, i32 %_57
	store i8 %_58, i8* %_59

	%_60 = load i1, i1* %flag
	br i1 %_60, label %L14, label %L15
L14:
	br label %L16
L15:
	br label %L16
L16:
	%_61 = phi i1 [0, %L14], [1, %L15]
	store i1 %_61, i1* %flag

	%_62 = load i32, i32* %i
	%_63 = add i32 %_62, 1
	store i32 %_63, i32* %i


	br label %L9
L11:

	%_64 = load i8*, i8** %a
	%_65 = load i8*, i8** %a
	%_66 = load i8*, i8** %a
	%_67 = load i8*, i8** %a
	%_68 = load i8*, i8** %a
	%_69 = load i8*, i8** %a
	%_70 = load i8*, i8** %a
	%_71 = load i8*, i8** %a
	%_72 = bitcast i8* %_71 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 0
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i32 (i8*, i32)*
	%_77 = call i32 %_76(i8* %_71, i32 1024)
	%_78 = bitcast i8* %_70 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 0
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i32 (i8*, i32)*
	%_83 = call i32 %_82(i8* %_70, i32 %_77)
	%_84 = bitcast i8* %_69 to i8***
	%_85 = load i8**, i8*** %_84
	%_86 = getelementptr i8*, i8** %_85, i32 0
	%_87 = load i8*, i8** %_86
	%_88 = bitcast i8* %_87 to i32 (i8*, i32)*
	%_89 = call i32 %_88(i8* %_69, i32 %_83)
	%_90 = bitcast i8* %_68 to i8***
	%_91 = load i8**, i8*** %_90
	%_92 = getelementptr i8*, i8** %_91, i32 0
	%_93 = load i8*, i8** %_92
	%_94 = bitcast i8* %_93 to i32 (i8*, i32)*
	%_95 = call i32 %_94(i8* %_68, i32 %_89)
	%_96 = bitcast i8* %_67 to i8***
	%_97 = load i8**, i8*** %_96
	%_98 = getelementptr i8*, i8** %_97, i32 0
	%_99 = load i8*, i8** %_98
	%_100 = bitcast i8* %_99 to i32 (i8*, i32)*
	%_101 = call i32 %_100(i8* %_67, i32 %_95)
	%_102 = bitcast i8* %_66 to i8***
	%_103 = load i8**, i8*** %_102
	%_104 = getelementptr i8*, i8** %_103, i32 0
	%_105 = load i8*, i8** %_104
	%_106 = bitcast i8* %_105 to i32 (i8*, i32)*
	%_107 = call i32 %_106(i8* %_66, i32 %_101)
	%_108 = bitcast i8* %_65 to i8***
	%_109 = load i8**, i8*** %_108
	%_110 = getelementptr i8*, i8** %_109, i32 0
	%_111 = load i8*, i8** %_110
	%_112 = bitcast i8* %_111 to i32 (i8*, i32)*
	%_113 = call i32 %_112(i8* %_65, i32 %_107)
	%_114 = load i8*, i8** %a
	%_115 = load i8*, i8** %a
	%_116 = load i8*, i8** %a
	%_117 = load i8*, i8** %a
	%_118 = load i8*, i8** %a
	%_119 = load i8*, i8** %a
	%_120 = load i32*, i32** %int_array
	%_121 = bitcast i8* %_119 to i8***
	%_122 = load i8**, i8*** %_121
	%_123 = getelementptr i8*, i8** %_122, i32 1
	%_124 = load i8*, i8** %_123
	%_125 = bitcast i8* %_124 to i32* (i8*, i32*)*
	%_126 = call i32* %_125(i8* %_119, i32* %_120)
	%_127 = bitcast i8* %_118 to i8***
	%_128 = load i8**, i8*** %_127
	%_129 = getelementptr i8*, i8** %_128, i32 1
	%_130 = load i8*, i8** %_129
	%_131 = bitcast i8* %_130 to i32* (i8*, i32*)*
	%_132 = call i32* %_131(i8* %_118, i32* %_126)
	%_133 = bitcast i8* %_117 to i8***
	%_134 = load i8**, i8*** %_133
	%_135 = getelementptr i8*, i8** %_134, i32 1
	%_136 = load i8*, i8** %_135
	%_137 = bitcast i8* %_136 to i32* (i8*, i32*)*
	%_138 = call i32* %_137(i8* %_117, i32* %_132)
	%_139 = bitcast i8* %_116 to i8***
	%_140 = load i8**, i8*** %_139
	%_141 = getelementptr i8*, i8** %_140, i32 1
	%_142 = load i8*, i8** %_141
	%_143 = bitcast i8* %_142 to i32* (i8*, i32*)*
	%_144 = call i32* %_143(i8* %_116, i32* %_138)
	%_145 = bitcast i8* %_115 to i8***
	%_146 = load i8**, i8*** %_145
	%_147 = getelementptr i8*, i8** %_146, i32 1
	%_148 = load i8*, i8** %_147
	%_149 = bitcast i8* %_148 to i32* (i8*, i32*)*
	%_150 = call i32* %_149(i8* %_115, i32* %_144)
	%_151 = bitcast i8* %_114 to i8***
	%_152 = load i8**, i8*** %_151
	%_153 = getelementptr i8*, i8** %_152, i32 1
	%_154 = load i8*, i8** %_153
	%_155 = bitcast i8* %_154 to i32* (i8*, i32*)*
	%_156 = call i32* %_155(i8* %_114, i32* %_150)
	%_157 = load i8*, i8** %a
	%_158 = load i8*, i8** %a
	%_159 = load i8*, i8** %a
	%_160 = load i8*, i8** %a
	%_161 = load i8*, i8** %a
	%_162 = load i8*, i8** %a
	%_163 = load i8*, i8** %a
	%_164 = bitcast i8* %_163 to i8***
	%_165 = load i8**, i8*** %_164
	%_166 = getelementptr i8*, i8** %_165, i32 2
	%_167 = load i8*, i8** %_166
	%_168 = bitcast i8* %_167 to i1 (i8*, i1)*
	%_169 = call i1 %_168(i8* %_163, i1 1)
	%_170 = bitcast i8* %_162 to i8***
	%_171 = load i8**, i8*** %_170
	%_172 = getelementptr i8*, i8** %_171, i32 2
	%_173 = load i8*, i8** %_172
	%_174 = bitcast i8* %_173 to i1 (i8*, i1)*
	%_175 = call i1 %_174(i8* %_162, i1 %_169)
	%_176 = bitcast i8* %_161 to i8***
	%_177 = load i8**, i8*** %_176
	%_178 = getelementptr i8*, i8** %_177, i32 2
	%_179 = load i8*, i8** %_178
	%_180 = bitcast i8* %_179 to i1 (i8*, i1)*
	%_181 = call i1 %_180(i8* %_161, i1 %_175)
	%_182 = bitcast i8* %_160 to i8***
	%_183 = load i8**, i8*** %_182
	%_184 = getelementptr i8*, i8** %_183, i32 2
	%_185 = load i8*, i8** %_184
	%_186 = bitcast i8* %_185 to i1 (i8*, i1)*
	%_187 = call i1 %_186(i8* %_160, i1 %_181)
	%_188 = bitcast i8* %_159 to i8***
	%_189 = load i8**, i8*** %_188
	%_190 = getelementptr i8*, i8** %_189, i32 2
	%_191 = load i8*, i8** %_190
	%_192 = bitcast i8* %_191 to i1 (i8*, i1)*
	%_193 = call i1 %_192(i8* %_159, i1 %_187)
	%_194 = bitcast i8* %_158 to i8***
	%_195 = load i8**, i8*** %_194
	%_196 = getelementptr i8*, i8** %_195, i32 2
	%_197 = load i8*, i8** %_196
	%_198 = bitcast i8* %_197 to i1 (i8*, i1)*
	%_199 = call i1 %_198(i8* %_158, i1 %_193)
	%_200 = bitcast i8* %_157 to i8***
	%_201 = load i8**, i8*** %_200
	%_202 = getelementptr i8*, i8** %_201, i32 2
	%_203 = load i8*, i8** %_202
	%_204 = bitcast i8* %_203 to i1 (i8*, i1)*
	%_205 = call i1 %_204(i8* %_157, i1 %_199)
	%_206 = load i8*, i8** %a
	%_207 = load i8*, i8** %a
	%_208 = load i8*, i8** %a
	%_209 = load i8*, i8** %a
	%_210 = load i8*, i8** %a
	%_211 = load i8*, i8** %boolean_array
	%_212 = bitcast i8* %_210 to i8***
	%_213 = load i8**, i8*** %_212
	%_214 = getelementptr i8*, i8** %_213, i32 3
	%_215 = load i8*, i8** %_214
	%_216 = bitcast i8* %_215 to i8* (i8*, i8*)*
	%_217 = call i8* %_216(i8* %_210, i8* %_211)
	%_218 = bitcast i8* %_209 to i8***
	%_219 = load i8**, i8*** %_218
	%_220 = getelementptr i8*, i8** %_219, i32 3
	%_221 = load i8*, i8** %_220
	%_222 = bitcast i8* %_221 to i8* (i8*, i8*)*
	%_223 = call i8* %_222(i8* %_209, i8* %_217)
	%_224 = bitcast i8* %_208 to i8***
	%_225 = load i8**, i8*** %_224
	%_226 = getelementptr i8*, i8** %_225, i32 3
	%_227 = load i8*, i8** %_226
	%_228 = bitcast i8* %_227 to i8* (i8*, i8*)*
	%_229 = call i8* %_228(i8* %_208, i8* %_223)
	%_230 = bitcast i8* %_207 to i8***
	%_231 = load i8**, i8*** %_230
	%_232 = getelementptr i8*, i8** %_231, i32 3
	%_233 = load i8*, i8** %_232
	%_234 = bitcast i8* %_233 to i8* (i8*, i8*)*
	%_235 = call i8* %_234(i8* %_207, i8* %_229)
	%_236 = bitcast i8* %_206 to i8***
	%_237 = load i8**, i8*** %_236
	%_238 = getelementptr i8*, i8** %_237, i32 3
	%_239 = load i8*, i8** %_238
	%_240 = bitcast i8* %_239 to i8* (i8*, i8*)*
	%_241 = call i8* %_240(i8* %_206, i8* %_235)
	%_242 = load i8*, i8** %b
	%_243 = load i8*, i8** %b
	%_244 = load i8*, i8** %b
	%_245 = load i8*, i8** %b
	%_246 = load i8*, i8** %b
	%_247 = load i8*, i8** %b
	%_248 = bitcast i8* %_246 to i8***
	%_249 = load i8**, i8*** %_248
	%_250 = getelementptr i8*, i8** %_249, i32 2
	%_251 = load i8*, i8** %_250
	%_252 = bitcast i8* %_251 to i8* (i8*, i8*)*
	%_253 = call i8* %_252(i8* %_246, i8* %_247)
	%_254 = bitcast i8* %_245 to i8***
	%_255 = load i8**, i8*** %_254
	%_256 = getelementptr i8*, i8** %_255, i32 2
	%_257 = load i8*, i8** %_256
	%_258 = bitcast i8* %_257 to i8* (i8*, i8*)*
	%_259 = call i8* %_258(i8* %_245, i8* %_253)
	%_260 = bitcast i8* %_244 to i8***
	%_261 = load i8**, i8*** %_260
	%_262 = getelementptr i8*, i8** %_261, i32 2
	%_263 = load i8*, i8** %_262
	%_264 = bitcast i8* %_263 to i8* (i8*, i8*)*
	%_265 = call i8* %_264(i8* %_244, i8* %_259)
	%_266 = bitcast i8* %_243 to i8***
	%_267 = load i8**, i8*** %_266
	%_268 = getelementptr i8*, i8** %_267, i32 2
	%_269 = load i8*, i8** %_268
	%_270 = bitcast i8* %_269 to i8* (i8*, i8*)*
	%_271 = call i8* %_270(i8* %_243, i8* %_265)
	%_272 = bitcast i8* %_242 to i8***
	%_273 = load i8**, i8*** %_272
	%_274 = getelementptr i8*, i8** %_273, i32 2
	%_275 = load i8*, i8** %_274
	%_276 = bitcast i8* %_275 to i8* (i8*, i8*)*
	%_277 = call i8* %_276(i8* %_242, i8* %_271)
	%_278 = bitcast i8* %_64 to i8***
	%_279 = load i8**, i8*** %_278
	%_280 = getelementptr i8*, i8** %_279, i32 5
	%_281 = load i8*, i8** %_280
	%_282 = bitcast i8* %_281 to i32 (i8*, i32, i32*, i1, i8*, i8*)*
	%_283 = call i32 %_282(i8* %_64, i32 %_113, i32* %_156, i1 %_205, i8* %_241, i8* %_277)
	store i32 %_283, i32* %i

	ret i32 0
}

define i32 @A.func_int(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_284 = load i32, i32* %i
	%_285 = getelementptr i8, i8* %this, i32 8
	%_286 = bitcast i8* %_285 to i32*
	store i32 %_284, i32* %_286

	%_287 = load i32, i32* %i
	ret i32 %_287
}

define i32* @A.func_int_array(i8* %this, i32* %.arr) {
	%arr = alloca i32*
	store i32* %.arr, i32** %arr

	%_288 = load i32*, i32** %arr
	ret i32* %_288
}

define i1 @A.func_boolean(i8* %this, i1 %.b) {
	%b = alloca i1
	store i1 %.b, i1* %b

	%_289 = load i1, i1* %b
	ret i1 %_289
}

define i8* @A.func_boolean_array(i8* %this, i8* %.arr) {
	%arr = alloca i8*
	store i8* %.arr, i8** %arr

	%_290 = load i8*, i8** %arr
	ret i8* %_290
}

define i32 @A.decrease(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i

	%_291 = load i32, i32* %i
	%_292 = sub i32 %_291, 1
	store i32 %_292, i32* %i

	%_293 = load i32, i32* %i
	ret i32 %_293
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

	%_295 = getelementptr i8, i8* %this, i32 8
	%_296 = bitcast i8* %_295 to i32*
	%_294 = load i32, i32* %_296
	call void (i32) @print_int(i32 %_294)

	%_297 = load i32, i32* %i
	call void (i32) @print_int(i32 %_297)

	%_298 = load i32*, i32** %int_arr
	%_300 = load i32, i32* %_298
	call void (i32) @print_int(i32 %_300)

	store i32 0, i32* %j

	store i32 0, i32* %sum

	br label %L17
L17:
	%_301 = load i32, i32* %j
	%_302 = load i32*, i32** %int_arr
	%_304 = load i32, i32* %_302
	%_305 = icmp slt i32 %_301, %_304
	br i1 %_305, label %L18, label %L19
L18:
	%_306 = load i32*, i32** %int_arr
	%_307 = load i32, i32* %j
	%_309 = load i32, i32* %_306
	%_310 = icmp sge i32 %_307, 0
	%_311 = icmp slt i32 %_307, %_309
	%_312 = and i1 %_310, %_311
	br i1 %_312, label %L20, label %L21
L21:
	call void @throw_oob()
	br label %L20
L20:
	%_313 = add i32 1, %_307
	%_314 = getelementptr i32, i32* %_306, i32 %_313
	%_315 = load i32, i32* %_314
	%_317 = load i32, i32* %sum
	%_318 = add i32 %_315, %_317
	store i32 %_318, i32* %sum

	%_319 = load i32, i32* %j
	%_320 = add i32 %_319, 1
	store i32 %_320, i32* %j


	br label %L17
L19:

	%_321 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_321)

	%_322 = load i1, i1* %b
	br i1 %_322, label %L22, label %L23
L22:
	call void (i32) @print_int(i32 1)


	br label %L24
L23:
	call void (i32) @print_int(i32 0)


	br label %L24
L24:

	%_323 = load i8*, i8** %b_arr
	%_324 = bitcast i8* %_323 to i32*	%_325 = load i32, i32* %_324
	call void (i32) @print_int(i32 %_325)

	store i32 0, i32* %j

	store i32 0, i32* %sum

	%_326 = load i8*, i8** %b_arr
	%_327 = load i32, i32* %j
	%_328 = bitcast i8* %_326 to i32*
	%_329 = load i32, i32* %_328
	%_330 = icmp sge i32 %_327, 0
	%_331 = icmp slt i32 %_327, %_329
	%_332 = and i1 %_330, %_331
	br i1 %_332, label %L25, label %L26
L26:
	call void @throw_oob()
	br label %L25
L25:
	%_333 = add i32 4, %_327
	%_334 = getelementptr i8, i8* %_326, i32 %_333
	%_335 = load i8, i8* %_334
	%_336 = trunc i8 %_335 to i1
	br i1 %_336, label %L27, label %L28
L27:
	%_337 = load i32, i32* %sum
	%_338 = add i32 %_337, 1
	store i32 %_338, i32* %sum


	br label %L29
L28:
	%_339 = load i32, i32* %sum
	%_340 = add i32 %_339, 10
	store i32 %_340, i32* %sum


	br label %L29
L29:

	%_341 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_341)

	%_342 = load i8*, i8** %c_b
	%_343 = bitcast i8* %_342 to i8***
	%_344 = load i8**, i8*** %_343
	%_345 = getelementptr i8*, i8** %_344, i32 1
	%_346 = load i8*, i8** %_345
	%_347 = bitcast i8* %_346 to i32 (i8*)*
	%_348 = call i32 %_347(i8* %_342)
	store i32 %_348, i32* %j

	%_349 = load i32, i32* %j
	ret i32 %_349
}

define i32 @B.Init(i8* %this) {

	%_350 = getelementptr i8, i8* %this, i32 8
	%_351 = bitcast i8* %_350 to i32*
	store i32 1048576, i32* %_351

	ret i32 1
}

define i32 @B.Print(i8* %this) {

	%_353 = getelementptr i8, i8* %this, i32 8
	%_354 = bitcast i8* %_353 to i32*
	%_352 = load i32, i32* %_354
	call void (i32) @print_int(i32 %_352)

	ret i32 1
}

define i8* @B.getB(i8* %this, i8* %.b) {
	%b = alloca i8*
	store i8* %.b, i8** %b

	%_355 = load i8*, i8** %b
	ret i8* %_355
}

