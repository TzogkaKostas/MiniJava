@.Alsdfjasdjfl_vtable = global [0 x i8*] []

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i1 (i8*, i1, i1, i1)* @A.foo to i8*),
	i8* bitcast (i1 (i8*, i1, i1)* @A.bar to i8*),
	i8* bitcast (i1 (i8*, i1)* @A.print to i8*)
]

@.B_vtable = global [2 x i8*] [
	i8* bitcast (i1 (i8*, i32)* @B.foo to i8*),
	i8* bitcast (i1 (i8*, i32, i32, i1, i1)* @B.t to i8*)
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

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = load i8*, i8** %a
	%_4 = load i8*, i8** %a
	%_5 = bitcast i8* %_4 to i8***
	%_6 = load i8**, i8*** %_5
	%_7 = getelementptr i8*, i8** %_6, i32 0
	%_8 = load i8*, i8** %_7
	%_9 = bitcast i8* %_8 to i1 (i8*, i1, i1, i1)*
	%_10 = call i1 %_9(i8* %_4, i1 0, i1 0, i1 0)
	%_12 = bitcast i8* %_3 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 2
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i1 (i8*, i1)*
	%_17 = call i1 %_16(i8* %_3, i1 %_10)
	store i1 %_17, i1* %dummy

	%_19 = load i8*, i8** %a
	%_20 = load i8*, i8** %a
	%_21 = bitcast i8* %_20 to i8***
	%_22 = load i8**, i8*** %_21
	%_23 = getelementptr i8*, i8** %_22, i32 0
	%_24 = load i8*, i8** %_23
	%_25 = bitcast i8* %_24 to i1 (i8*, i1, i1, i1)*
	%_26 = call i1 %_25(i8* %_20, i1 0, i1 0, i1 1)
	%_28 = bitcast i8* %_19 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 2
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i1 (i8*, i1)*
	%_33 = call i1 %_32(i8* %_19, i1 %_26)
	store i1 %_33, i1* %dummy

	%_35 = load i8*, i8** %a
	%_36 = load i8*, i8** %a
	%_37 = bitcast i8* %_36 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 0
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i1 (i8*, i1, i1, i1)*
	%_42 = call i1 %_41(i8* %_36, i1 0, i1 1, i1 0)
	%_44 = bitcast i8* %_35 to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 2
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i1 (i8*, i1)*
	%_49 = call i1 %_48(i8* %_35, i1 %_42)
	store i1 %_49, i1* %dummy

	%_51 = load i8*, i8** %a
	%_52 = load i8*, i8** %a
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 0
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*, i1, i1, i1)*
	%_58 = call i1 %_57(i8* %_52, i1 0, i1 1, i1 1)
	%_60 = bitcast i8* %_51 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 2
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i1 (i8*, i1)*
	%_65 = call i1 %_64(i8* %_51, i1 %_58)
	store i1 %_65, i1* %dummy

	%_67 = load i8*, i8** %a
	%_68 = load i8*, i8** %a
	%_69 = bitcast i8* %_68 to i8***
	%_70 = load i8**, i8*** %_69
	%_71 = getelementptr i8*, i8** %_70, i32 0
	%_72 = load i8*, i8** %_71
	%_73 = bitcast i8* %_72 to i1 (i8*, i1, i1, i1)*
	%_74 = call i1 %_73(i8* %_68, i1 1, i1 0, i1 0)
	%_76 = bitcast i8* %_67 to i8***
	%_77 = load i8**, i8*** %_76
	%_78 = getelementptr i8*, i8** %_77, i32 2
	%_79 = load i8*, i8** %_78
	%_80 = bitcast i8* %_79 to i1 (i8*, i1)*
	%_81 = call i1 %_80(i8* %_67, i1 %_74)
	store i1 %_81, i1* %dummy

	%_83 = load i8*, i8** %a
	%_84 = load i8*, i8** %a
	%_85 = bitcast i8* %_84 to i8***
	%_86 = load i8**, i8*** %_85
	%_87 = getelementptr i8*, i8** %_86, i32 0
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1 (i8*, i1, i1, i1)*
	%_90 = call i1 %_89(i8* %_84, i1 1, i1 0, i1 1)
	%_92 = bitcast i8* %_83 to i8***
	%_93 = load i8**, i8*** %_92
	%_94 = getelementptr i8*, i8** %_93, i32 2
	%_95 = load i8*, i8** %_94
	%_96 = bitcast i8* %_95 to i1 (i8*, i1)*
	%_97 = call i1 %_96(i8* %_83, i1 %_90)
	store i1 %_97, i1* %dummy

	%_99 = load i8*, i8** %a
	%_100 = load i8*, i8** %a
	%_101 = bitcast i8* %_100 to i8***
	%_102 = load i8**, i8*** %_101
	%_103 = getelementptr i8*, i8** %_102, i32 0
	%_104 = load i8*, i8** %_103
	%_105 = bitcast i8* %_104 to i1 (i8*, i1, i1, i1)*
	%_106 = call i1 %_105(i8* %_100, i1 1, i1 1, i1 0)
	%_108 = bitcast i8* %_99 to i8***
	%_109 = load i8**, i8*** %_108
	%_110 = getelementptr i8*, i8** %_109, i32 2
	%_111 = load i8*, i8** %_110
	%_112 = bitcast i8* %_111 to i1 (i8*, i1)*
	%_113 = call i1 %_112(i8* %_99, i1 %_106)
	store i1 %_113, i1* %dummy

	%_115 = load i8*, i8** %a
	%_116 = load i8*, i8** %a
	%_117 = bitcast i8* %_116 to i8***
	%_118 = load i8**, i8*** %_117
	%_119 = getelementptr i8*, i8** %_118, i32 0
	%_120 = load i8*, i8** %_119
	%_121 = bitcast i8* %_120 to i1 (i8*, i1, i1, i1)*
	%_122 = call i1 %_121(i8* %_116, i1 1, i1 1, i1 1)
	%_124 = bitcast i8* %_115 to i8***
	%_125 = load i8**, i8*** %_124
	%_126 = getelementptr i8*, i8** %_125, i32 2
	%_127 = load i8*, i8** %_126
	%_128 = bitcast i8* %_127 to i1 (i8*, i1)*
	%_129 = call i1 %_128(i8* %_115, i1 %_122)
	store i1 %_129, i1* %dummy

	%_131 = load i8*, i8** %a
	%_132 = load i8*, i8** %a
	%_133 = bitcast i8* %_132 to i8***
	%_134 = load i8**, i8*** %_133
	%_135 = getelementptr i8*, i8** %_134, i32 1
	%_136 = load i8*, i8** %_135
	%_137 = bitcast i8* %_136 to i1 (i8*, i1, i1)*
	%_138 = call i1 %_137(i8* %_132, i1 1, i1 1)
	%_140 = bitcast i8* %_131 to i8***
	%_141 = load i8**, i8*** %_140
	%_142 = getelementptr i8*, i8** %_141, i32 2
	%_143 = load i8*, i8** %_142
	%_144 = bitcast i8* %_143 to i1 (i8*, i1)*
	%_145 = call i1 %_144(i8* %_131, i1 %_138)
	store i1 %_145, i1* %dummy

	%_147 = load i8*, i8** %a
	%_148 = load i8*, i8** %a
	%_149 = bitcast i8* %_148 to i8***
	%_150 = load i8**, i8*** %_149
	%_151 = getelementptr i8*, i8** %_150, i32 1
	%_152 = load i8*, i8** %_151
	%_153 = bitcast i8* %_152 to i1 (i8*, i1, i1)*
	%_154 = call i1 %_153(i8* %_148, i1 0, i1 1)
	%_156 = bitcast i8* %_147 to i8***
	%_157 = load i8**, i8*** %_156
	%_158 = getelementptr i8*, i8** %_157, i32 2
	%_159 = load i8*, i8** %_158
	%_160 = bitcast i8* %_159 to i1 (i8*, i1)*
	%_161 = call i1 %_160(i8* %_147, i1 %_154)
	store i1 %_161, i1* %dummy

	%_163 = load i8*, i8** %a
	%_164 = call i8* @calloc(i32 1, i32 8)
	%_165 = bitcast i8* %_164 to i8***
	%_166 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_166, i8*** %_165
	%_167 = bitcast i8* %_164 to i8***
	%_168 = load i8**, i8*** %_167
	%_169 = getelementptr i8*, i8** %_168, i32 0
	%_170 = load i8*, i8** %_169
	%_171 = bitcast i8* %_170 to i1 (i8*, i32)*
	%_172 = call i1 %_171(i8* %_164, i32 1)
	%_174 = bitcast i8* %_163 to i8***
	%_175 = load i8**, i8*** %_174
	%_176 = getelementptr i8*, i8** %_175, i32 2
	%_177 = load i8*, i8** %_176
	%_178 = bitcast i8* %_177 to i1 (i8*, i1)*
	%_179 = call i1 %_178(i8* %_163, i1 %_172)
	store i1 %_179, i1* %dummy

	%_181 = load i8*, i8** %a
	%_182 = call i8* @calloc(i32 1, i32 8)
	%_183 = bitcast i8* %_182 to i8***
	%_184 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_184, i8*** %_183
	%_185 = bitcast i8* %_182 to i8***
	%_186 = load i8**, i8*** %_185
	%_187 = getelementptr i8*, i8** %_186, i32 0
	%_188 = load i8*, i8** %_187
	%_189 = bitcast i8* %_188 to i1 (i8*, i32)*
	%_190 = call i1 %_189(i8* %_182, i32 2)
	%_192 = bitcast i8* %_181 to i8***
	%_193 = load i8**, i8*** %_192
	%_194 = getelementptr i8*, i8** %_193, i32 2
	%_195 = load i8*, i8** %_194
	%_196 = bitcast i8* %_195 to i1 (i8*, i1)*
	%_197 = call i1 %_196(i8* %_181, i1 %_190)
	store i1 %_197, i1* %dummy

	%_199 = load i8*, i8** %a
	%_200 = call i8* @calloc(i32 1, i32 8)
	%_201 = bitcast i8* %_200 to i8***
	%_202 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_202, i8*** %_201
	%_203 = bitcast i8* %_200 to i8***
	%_204 = load i8**, i8*** %_203
	%_205 = getelementptr i8*, i8** %_204, i32 1
	%_206 = load i8*, i8** %_205
	%_207 = bitcast i8* %_206 to i1 (i8*, i32, i32, i1, i1)*
	%_208 = call i1 %_207(i8* %_200, i32 2, i32 2, i1 1, i1 1)
	%_210 = bitcast i8* %_199 to i8***
	%_211 = load i8**, i8*** %_210
	%_212 = getelementptr i8*, i8** %_211, i32 2
	%_213 = load i8*, i8** %_212
	%_214 = bitcast i8* %_213 to i1 (i8*, i1)*
	%_215 = call i1 %_214(i8* %_199, i1 %_208)
	store i1 %_215, i1* %dummy

	ret i32 0
}

define i1 @A.foo(i8* %this, i1 %.a, i1 %.b, i1 %.c) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%b = alloca i1
	store i1 %.b, i1* %b
	%c = alloca i1
	store i1 %.c, i1* %c

	%_217 = load i1, i1* %a
	br i1 %_217, label %L1, label %L0
L0:
	br label %L3
L1:
	%_218 = load i1, i1* %b
	br label %L2
L2:
	br label %L3
L3:
	%_219 = phi i1 [0, %L0], [%_218, %L2]
	br i1 %_219, label %L5, label %L4
L4:
	br label %L7
L5:
	%_220 = load i1, i1* %c
	br label %L6
L6:
	br label %L7
L7:
	%_221 = phi i1 [0, %L4], [%_220, %L6]
	ret i1 %_221
}

define i1 @A.bar(i8* %this, i1 %.a, i1 %.b) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%b = alloca i1
	store i1 %.b, i1* %b

	%_222 = load i1, i1* %a
	br i1 %_222, label %L9, label %L8
L8:
	br label %L11
L9:
	%_223 = load i1, i1* %a
	%_224 = load i1, i1* %b
	%_225 = bitcast i8* %this to i8***
	%_226 = load i8**, i8*** %_225
	%_227 = getelementptr i8*, i8** %_226, i32 0
	%_228 = load i8*, i8** %_227
	%_229 = bitcast i8* %_228 to i1 (i8*, i1, i1, i1)*
	%_230 = call i1 %_229(i8* %this, i1 %_223, i1 %_224, i1 1)
	br label %L10
L10:
	br label %L11
L11:
	%_232 = phi i1 [0, %L8], [%_230, %L10]
	br i1 %_232, label %L13, label %L12
L12:
	br label %L15
L13:
	%_233 = load i1, i1* %b
	br label %L14
L14:
	br label %L15
L15:
	%_234 = phi i1 [0, %L12], [%_233, %L14]
	ret i1 %_234
}

define i1 @A.print(i8* %this, i1 %.res) {
	%res = alloca i1
	store i1 %.res, i1* %res

	%_235 = load i1, i1* %res
	br i1 %_235, label %L16, label %L17
L16:
	call void (i32) @print_int(i32 1)


	br label %L18
L17:
	call void (i32) @print_int(i32 0)


	br label %L18
L18:

	ret i1 1
}

define i1 @B.foo(i8* %this, i32 %.a) {
	%a = alloca i32
	store i32 %.a, i32* %a

	%_236 = load i32, i32* %a
	%_237 = add i32 %_236, 2
	%_238 = icmp slt i32 3, %_237
	br i1 %_238, label %L19, label %L20
L19:
	br label %L21
L20:
	br label %L21
L21:
	%_239 = phi i1 [0, %L19], [1, %L20]
	br i1 %_239, label %L26, label %L25
L25:
	br label %L28
L26:
	br i1 0, label %L22, label %L23
L22:
	br label %L24
L23:
	br label %L24
L24:
	%_240 = phi i1 [0, %L22], [1, %L23]
	br label %L27
L27:
	br label %L28
L28:
	%_241 = phi i1 [0, %L25], [%_240, %L27]
	ret i1 %_241
}

define i1 @B.t(i8* %this, i32 %.a, i32 %.b, i1 %.c, i1 %.d) {
	%a = alloca i32
	store i32 %.a, i32* %a
	%b = alloca i32
	store i32 %.b, i32* %b
	%c = alloca i1
	store i1 %.c, i1* %c
	%d = alloca i1
	store i1 %.d, i1* %d

	%_242 = load i32, i32* %a
	%_243 = load i32, i32* %b
	%_244 = icmp slt i32 %_242, %_243
	br i1 %_244, label %L29, label %L30
L29:
	br label %L31
L30:
	br label %L31
L31:
	%_245 = phi i1 [0, %L29], [1, %L30]
	br i1 %_245, label %L37, label %L36
L36:
	br label %L39
L37:
	%_246 = load i1, i1* %c
	br i1 %_246, label %L33, label %L32
L32:
	br label %L35
L33:
	%_247 = load i1, i1* %d
	br label %L34
L34:
	br label %L35
L35:
	%_248 = phi i1 [0, %L32], [%_247, %L34]
	br label %L38
L38:
	br label %L39
L39:
	%_249 = phi i1 [0, %L36], [%_248, %L38]
	ret i1 %_249
}

