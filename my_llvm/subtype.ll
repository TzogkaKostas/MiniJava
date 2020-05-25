@.Main_vtable = global [0 x i8*] []

@.Receiver_vtable = global [8 x i8*] [
	i8* bitcast (i1 (i8*, i8*)* @Receiver.A to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Receiver.B to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Receiver.C to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Receiver.D to i8*),
	i8* bitcast (i8* (i8*)* @Receiver.alloc_B_for_A to i8*),
	i8* bitcast (i8* (i8*)* @Receiver.alloc_C_for_A to i8*),
	i8* bitcast (i8* (i8*)* @Receiver.alloc_D_for_A to i8*),
	i8* bitcast (i8* (i8*)* @Receiver.alloc_D_for_B to i8*)
]

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @A.bar to i8*),
	i8* bitcast (i32 (i8*)* @A.test to i8*)
]

@.B_vtable = global [5 x i8*] [
	i8* bitcast (i32 (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @B.bar to i8*),
	i8* bitcast (i32 (i8*)* @A.test to i8*),
	i8* bitcast (i32 (i8*)* @B.not_overriden to i8*),
	i8* bitcast (i32 (i8*)* @B.another to i8*)
]

@.C_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @C.bar to i8*),
	i8* bitcast (i32 (i8*)* @A.test to i8*)
]

@.D_vtable = global [6 x i8*] [
	i8* bitcast (i32 (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @D.bar to i8*),
	i8* bitcast (i32 (i8*)* @A.test to i8*),
	i8* bitcast (i32 (i8*)* @B.not_overriden to i8*),
	i8* bitcast (i32 (i8*)* @D.another to i8*),
	i8* bitcast (i32 (i8*)* @D.stef to i8*)
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
	%dummy = alloca i1
	%a = alloca i8*
	%b = alloca i8*
	%c = alloca i8*
	%d = alloca i8*
	%separator = alloca i32
	%cls_separator = alloca i32

	store i32 1111111111, i32* %separator

	store i32 333333333, i32* %cls_separator

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	%_3 = call i8* @calloc(i32 1, i32 8)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	%_6 = bitcast i8* %_0 to i8***
	%_7 = load i8**, i8*** %_6
	%_8 = getelementptr i8*, i8** %_7, i32 0
	%_9 = load i8*, i8** %_8
	%_10 = bitcast i8* %_9 to i1 (i8*, i8*)*
	%_11 = call i1 %_10(i8* %_0, i8* %_3)
	store i1 %_11, i1* %dummy

	%_13 = load i32, i32* %separator
	call void (i32) @print_int(i32 %_13)

	%_14 = call i8* @calloc(i32 1, i32 8)
	%_15 = bitcast i8* %_14 to i8***
	%_16 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_16, i8*** %_15
	%_17 = call i8* @calloc(i32 1, i32 8)
	%_18 = bitcast i8* %_17 to i8***
	%_19 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_19, i8*** %_18
	%_20 = bitcast i8* %_17 to i8***
	%_21 = load i8**, i8*** %_20
	%_22 = getelementptr i8*, i8** %_21, i32 4
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i8* (i8*)*
	%_25 = call i8* %_24(i8* %_17)
	%_27 = bitcast i8* %_14 to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 0
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i1 (i8*, i8*)*
	%_32 = call i1 %_31(i8* %_14, i8* %_25)
	store i1 %_32, i1* %dummy

	%_34 = load i32, i32* %separator
	call void (i32) @print_int(i32 %_34)

	%_35 = call i8* @calloc(i32 1, i32 8)
	%_36 = bitcast i8* %_35 to i8***
	%_37 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_37, i8*** %_36
	%_38 = call i8* @calloc(i32 1, i32 8)
	%_39 = bitcast i8* %_38 to i8***
	%_40 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_40, i8*** %_39
	%_41 = bitcast i8* %_38 to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 5
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i8* (i8*)*
	%_46 = call i8* %_45(i8* %_38)
	%_48 = bitcast i8* %_35 to i8***
	%_49 = load i8**, i8*** %_48
	%_50 = getelementptr i8*, i8** %_49, i32 0
	%_51 = load i8*, i8** %_50
	%_52 = bitcast i8* %_51 to i1 (i8*, i8*)*
	%_53 = call i1 %_52(i8* %_35, i8* %_46)
	store i1 %_53, i1* %dummy

	%_55 = load i32, i32* %separator
	call void (i32) @print_int(i32 %_55)

	%_56 = call i8* @calloc(i32 1, i32 8)
	%_57 = bitcast i8* %_56 to i8***
	%_58 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_58, i8*** %_57
	%_59 = call i8* @calloc(i32 1, i32 8)
	%_60 = bitcast i8* %_59 to i8***
	%_61 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_61, i8*** %_60
	%_62 = bitcast i8* %_59 to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 6
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i8* (i8*)*
	%_67 = call i8* %_66(i8* %_59)
	%_69 = bitcast i8* %_56 to i8***
	%_70 = load i8**, i8*** %_69
	%_71 = getelementptr i8*, i8** %_70, i32 0
	%_72 = load i8*, i8** %_71
	%_73 = bitcast i8* %_72 to i1 (i8*, i8*)*
	%_74 = call i1 %_73(i8* %_56, i8* %_67)
	store i1 %_74, i1* %dummy

	%_76 = load i32, i32* %cls_separator
	call void (i32) @print_int(i32 %_76)

	%_77 = call i8* @calloc(i32 1, i32 8)
	%_78 = bitcast i8* %_77 to i8***
	%_79 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_79, i8*** %_78
	%_80 = call i8* @calloc(i32 1, i32 8)
	%_81 = bitcast i8* %_80 to i8***
	%_82 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_82, i8*** %_81
	%_83 = bitcast i8* %_77 to i8***
	%_84 = load i8**, i8*** %_83
	%_85 = getelementptr i8*, i8** %_84, i32 1
	%_86 = load i8*, i8** %_85
	%_87 = bitcast i8* %_86 to i1 (i8*, i8*)*
	%_88 = call i1 %_87(i8* %_77, i8* %_80)
	store i1 %_88, i1* %dummy

	%_90 = load i32, i32* %separator
	call void (i32) @print_int(i32 %_90)

	%_91 = call i8* @calloc(i32 1, i32 8)
	%_92 = bitcast i8* %_91 to i8***
	%_93 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_93, i8*** %_92
	%_94 = call i8* @calloc(i32 1, i32 8)
	%_95 = bitcast i8* %_94 to i8***
	%_96 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_96, i8*** %_95
	%_97 = bitcast i8* %_94 to i8***
	%_98 = load i8**, i8*** %_97
	%_99 = getelementptr i8*, i8** %_98, i32 7
	%_100 = load i8*, i8** %_99
	%_101 = bitcast i8* %_100 to i8* (i8*)*
	%_102 = call i8* %_101(i8* %_94)
	%_104 = bitcast i8* %_91 to i8***
	%_105 = load i8**, i8*** %_104
	%_106 = getelementptr i8*, i8** %_105, i32 1
	%_107 = load i8*, i8** %_106
	%_108 = bitcast i8* %_107 to i1 (i8*, i8*)*
	%_109 = call i1 %_108(i8* %_91, i8* %_102)
	store i1 %_109, i1* %dummy

	%_111 = load i32, i32* %cls_separator
	call void (i32) @print_int(i32 %_111)

	%_112 = call i8* @calloc(i32 1, i32 8)
	%_113 = bitcast i8* %_112 to i8***
	%_114 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_114, i8*** %_113
	%_115 = call i8* @calloc(i32 1, i32 8)
	%_116 = bitcast i8* %_115 to i8***
	%_117 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_117, i8*** %_116
	%_118 = bitcast i8* %_112 to i8***
	%_119 = load i8**, i8*** %_118
	%_120 = getelementptr i8*, i8** %_119, i32 2
	%_121 = load i8*, i8** %_120
	%_122 = bitcast i8* %_121 to i1 (i8*, i8*)*
	%_123 = call i1 %_122(i8* %_112, i8* %_115)
	store i1 %_123, i1* %dummy

	%_125 = load i32, i32* %cls_separator
	call void (i32) @print_int(i32 %_125)

	%_126 = call i8* @calloc(i32 1, i32 8)
	%_127 = bitcast i8* %_126 to i8***
	%_128 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
	store i8** %_128, i8*** %_127
	%_129 = call i8* @calloc(i32 1, i32 8)
	%_130 = bitcast i8* %_129 to i8***
	%_131 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_131, i8*** %_130
	%_132 = bitcast i8* %_126 to i8***
	%_133 = load i8**, i8*** %_132
	%_134 = getelementptr i8*, i8** %_133, i32 3
	%_135 = load i8*, i8** %_134
	%_136 = bitcast i8* %_135 to i1 (i8*, i8*)*
	%_137 = call i1 %_136(i8* %_126, i8* %_129)
	store i1 %_137, i1* %dummy

	ret i32 0
}

define i1 @Receiver.A(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a

	%_139 = load i8*, i8** %a
	%_140 = bitcast i8* %_139 to i8***
	%_141 = load i8**, i8*** %_140
	%_142 = getelementptr i8*, i8** %_141, i32 0
	%_143 = load i8*, i8** %_142
	%_144 = bitcast i8* %_143 to i32 (i8*)*
	%_145 = call i32 %_144(i8* %_139)
	call void (i32) @print_int(i32 %_145)

	%_147 = load i8*, i8** %a
	%_148 = bitcast i8* %_147 to i8***
	%_149 = load i8**, i8*** %_148
	%_150 = getelementptr i8*, i8** %_149, i32 1
	%_151 = load i8*, i8** %_150
	%_152 = bitcast i8* %_151 to i32 (i8*)*
	%_153 = call i32 %_152(i8* %_147)
	call void (i32) @print_int(i32 %_153)

	%_155 = load i8*, i8** %a
	%_156 = bitcast i8* %_155 to i8***
	%_157 = load i8**, i8*** %_156
	%_158 = getelementptr i8*, i8** %_157, i32 2
	%_159 = load i8*, i8** %_158
	%_160 = bitcast i8* %_159 to i32 (i8*)*
	%_161 = call i32 %_160(i8* %_155)
	call void (i32) @print_int(i32 %_161)

	ret i1 1
}

define i1 @Receiver.B(i8* %this, i8* %.b) {
	%b = alloca i8*
	store i8* %.b, i8** %b

	%_163 = load i8*, i8** %b
	%_164 = bitcast i8* %_163 to i8***
	%_165 = load i8**, i8*** %_164
	%_166 = getelementptr i8*, i8** %_165, i32 0
	%_167 = load i8*, i8** %_166
	%_168 = bitcast i8* %_167 to i32 (i8*)*
	%_169 = call i32 %_168(i8* %_163)
	call void (i32) @print_int(i32 %_169)

	%_171 = load i8*, i8** %b
	%_172 = bitcast i8* %_171 to i8***
	%_173 = load i8**, i8*** %_172
	%_174 = getelementptr i8*, i8** %_173, i32 1
	%_175 = load i8*, i8** %_174
	%_176 = bitcast i8* %_175 to i32 (i8*)*
	%_177 = call i32 %_176(i8* %_171)
	call void (i32) @print_int(i32 %_177)

	%_179 = load i8*, i8** %b
	%_180 = bitcast i8* %_179 to i8***
	%_181 = load i8**, i8*** %_180
	%_182 = getelementptr i8*, i8** %_181, i32 2
	%_183 = load i8*, i8** %_182
	%_184 = bitcast i8* %_183 to i32 (i8*)*
	%_185 = call i32 %_184(i8* %_179)
	call void (i32) @print_int(i32 %_185)

	%_187 = load i8*, i8** %b
	%_188 = bitcast i8* %_187 to i8***
	%_189 = load i8**, i8*** %_188
	%_190 = getelementptr i8*, i8** %_189, i32 3
	%_191 = load i8*, i8** %_190
	%_192 = bitcast i8* %_191 to i32 (i8*)*
	%_193 = call i32 %_192(i8* %_187)
	call void (i32) @print_int(i32 %_193)

	%_195 = load i8*, i8** %b
	%_196 = bitcast i8* %_195 to i8***
	%_197 = load i8**, i8*** %_196
	%_198 = getelementptr i8*, i8** %_197, i32 4
	%_199 = load i8*, i8** %_198
	%_200 = bitcast i8* %_199 to i32 (i8*)*
	%_201 = call i32 %_200(i8* %_195)
	call void (i32) @print_int(i32 %_201)

	ret i1 1
}

define i1 @Receiver.C(i8* %this, i8* %.c) {
	%c = alloca i8*
	store i8* %.c, i8** %c

	%_203 = load i8*, i8** %c
	%_204 = bitcast i8* %_203 to i8***
	%_205 = load i8**, i8*** %_204
	%_206 = getelementptr i8*, i8** %_205, i32 0
	%_207 = load i8*, i8** %_206
	%_208 = bitcast i8* %_207 to i32 (i8*)*
	%_209 = call i32 %_208(i8* %_203)
	call void (i32) @print_int(i32 %_209)

	%_211 = load i8*, i8** %c
	%_212 = bitcast i8* %_211 to i8***
	%_213 = load i8**, i8*** %_212
	%_214 = getelementptr i8*, i8** %_213, i32 1
	%_215 = load i8*, i8** %_214
	%_216 = bitcast i8* %_215 to i32 (i8*)*
	%_217 = call i32 %_216(i8* %_211)
	call void (i32) @print_int(i32 %_217)

	%_219 = load i8*, i8** %c
	%_220 = bitcast i8* %_219 to i8***
	%_221 = load i8**, i8*** %_220
	%_222 = getelementptr i8*, i8** %_221, i32 2
	%_223 = load i8*, i8** %_222
	%_224 = bitcast i8* %_223 to i32 (i8*)*
	%_225 = call i32 %_224(i8* %_219)
	call void (i32) @print_int(i32 %_225)

	ret i1 1
}

define i1 @Receiver.D(i8* %this, i8* %.d) {
	%d = alloca i8*
	store i8* %.d, i8** %d

	%_227 = load i8*, i8** %d
	%_228 = bitcast i8* %_227 to i8***
	%_229 = load i8**, i8*** %_228
	%_230 = getelementptr i8*, i8** %_229, i32 0
	%_231 = load i8*, i8** %_230
	%_232 = bitcast i8* %_231 to i32 (i8*)*
	%_233 = call i32 %_232(i8* %_227)
	call void (i32) @print_int(i32 %_233)

	%_235 = load i8*, i8** %d
	%_236 = bitcast i8* %_235 to i8***
	%_237 = load i8**, i8*** %_236
	%_238 = getelementptr i8*, i8** %_237, i32 1
	%_239 = load i8*, i8** %_238
	%_240 = bitcast i8* %_239 to i32 (i8*)*
	%_241 = call i32 %_240(i8* %_235)
	call void (i32) @print_int(i32 %_241)

	%_243 = load i8*, i8** %d
	%_244 = bitcast i8* %_243 to i8***
	%_245 = load i8**, i8*** %_244
	%_246 = getelementptr i8*, i8** %_245, i32 2
	%_247 = load i8*, i8** %_246
	%_248 = bitcast i8* %_247 to i32 (i8*)*
	%_249 = call i32 %_248(i8* %_243)
	call void (i32) @print_int(i32 %_249)

	%_251 = load i8*, i8** %d
	%_252 = bitcast i8* %_251 to i8***
	%_253 = load i8**, i8*** %_252
	%_254 = getelementptr i8*, i8** %_253, i32 3
	%_255 = load i8*, i8** %_254
	%_256 = bitcast i8* %_255 to i32 (i8*)*
	%_257 = call i32 %_256(i8* %_251)
	call void (i32) @print_int(i32 %_257)

	%_259 = load i8*, i8** %d
	%_260 = bitcast i8* %_259 to i8***
	%_261 = load i8**, i8*** %_260
	%_262 = getelementptr i8*, i8** %_261, i32 4
	%_263 = load i8*, i8** %_262
	%_264 = bitcast i8* %_263 to i32 (i8*)*
	%_265 = call i32 %_264(i8* %_259)
	call void (i32) @print_int(i32 %_265)

	%_267 = load i8*, i8** %d
	%_268 = bitcast i8* %_267 to i8***
	%_269 = load i8**, i8*** %_268
	%_270 = getelementptr i8*, i8** %_269, i32 5
	%_271 = load i8*, i8** %_270
	%_272 = bitcast i8* %_271 to i32 (i8*)*
	%_273 = call i32 %_272(i8* %_267)
	call void (i32) @print_int(i32 %_273)

	ret i1 1
}

define i8* @Receiver.alloc_B_for_A(i8* %this) {

	%_275 = call i8* @calloc(i32 1, i32 8)
	%_276 = bitcast i8* %_275 to i8***
	%_277 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_277, i8*** %_276
	ret i8* %_275
}

define i8* @Receiver.alloc_C_for_A(i8* %this) {

	%_278 = call i8* @calloc(i32 1, i32 8)
	%_279 = bitcast i8* %_278 to i8***
	%_280 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_280, i8*** %_279
	ret i8* %_278
}

define i8* @Receiver.alloc_D_for_A(i8* %this) {

	%_281 = call i8* @calloc(i32 1, i32 8)
	%_282 = bitcast i8* %_281 to i8***
	%_283 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_283, i8*** %_282
	ret i8* %_281
}

define i8* @Receiver.alloc_D_for_B(i8* %this) {

	%_284 = call i8* @calloc(i32 1, i32 8)
	%_285 = bitcast i8* %_284 to i8***
	%_286 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_286, i8*** %_285
	ret i8* %_284
}

define i32 @A.foo(i8* %this) {

	ret i32 1
}

define i32 @A.bar(i8* %this) {

	ret i32 2
}

define i32 @A.test(i8* %this) {

	ret i32 3
}

define i32 @B.bar(i8* %this) {

	ret i32 12
}

define i32 @B.not_overriden(i8* %this) {

	ret i32 14
}

define i32 @B.another(i8* %this) {

	ret i32 15
}

define i32 @C.bar(i8* %this) {

	ret i32 22
}

define i32 @D.bar(i8* %this) {

	ret i32 32
}

define i32 @D.another(i8* %this) {

	ret i32 35
}

define i32 @D.stef(i8* %this) {

	ret i32 36
}

