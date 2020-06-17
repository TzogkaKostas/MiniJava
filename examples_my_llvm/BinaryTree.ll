@.BinaryTree_vtable = global [0 x i8*] []

@.BT_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*)* @BT.Start to i8*)
]

@.Tree_vtable = global [20 x i8*] [
	i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),
	i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),
	i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*),
	i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*),
	i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*),
	i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*),
	i8* bitcast (i1 (i8*)* @Tree.Print to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*)
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

	%_0 = call i8* @calloc(i32 1, i32 16)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)
	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @BT.Start(i8* %this) {
	%root = alloca i8*
	%ntb = alloca i1
	%nti = alloca i32

	%_10 = call i8* @calloc(i32 1, i32 38)
	%_11 = bitcast i8* %_10 to i8***
	%_12 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_12, i8*** %_11
	store i8* %_10, i8** %root

	%_13 = load i8*, i8** %root
	%_14 = bitcast i8* %_13 to i8***
	%_15 = load i8**, i8*** %_14
	%_16 = getelementptr i8*, i8** %_15, i32 0
	%_17 = load i8*, i8** %_16
	%_18 = bitcast i8* %_17 to i1 (i8*, i32)*
	%_19 = call i1 %_18(i8* %_13, i32 16)
	store i1 %_19, i1* %ntb

	%_21 = load i8*, i8** %root
	%_22 = bitcast i8* %_21 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 18
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i1 (i8*)*
	%_27 = call i1 %_26(i8* %_21)
	store i1 %_27, i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_29 = load i8*, i8** %root
	%_30 = bitcast i8* %_29 to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 12
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i1 (i8*, i32)*
	%_35 = call i1 %_34(i8* %_29, i32 8)
	store i1 %_35, i1* %ntb

	%_37 = load i8*, i8** %root
	%_38 = bitcast i8* %_37 to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 18
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i1 (i8*)*
	%_43 = call i1 %_42(i8* %_37)
	store i1 %_43, i1* %ntb

	%_45 = load i8*, i8** %root
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 12
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*, i32)*
	%_51 = call i1 %_50(i8* %_45, i32 24)
	store i1 %_51, i1* %ntb

	%_53 = load i8*, i8** %root
	%_54 = bitcast i8* %_53 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 12
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*, i32)*
	%_59 = call i1 %_58(i8* %_53, i32 4)
	store i1 %_59, i1* %ntb

	%_61 = load i8*, i8** %root
	%_62 = bitcast i8* %_61 to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 12
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i1 (i8*, i32)*
	%_67 = call i1 %_66(i8* %_61, i32 12)
	store i1 %_67, i1* %ntb

	%_69 = load i8*, i8** %root
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 12
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*, i32)*
	%_75 = call i1 %_74(i8* %_69, i32 20)
	store i1 %_75, i1* %ntb

	%_77 = load i8*, i8** %root
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 12
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*, i32)*
	%_83 = call i1 %_82(i8* %_77, i32 28)
	store i1 %_83, i1* %ntb

	%_85 = load i8*, i8** %root
	%_86 = bitcast i8* %_85 to i8***
	%_87 = load i8**, i8*** %_86
	%_88 = getelementptr i8*, i8** %_87, i32 12
	%_89 = load i8*, i8** %_88
	%_90 = bitcast i8* %_89 to i1 (i8*, i32)*
	%_91 = call i1 %_90(i8* %_85, i32 14)
	store i1 %_91, i1* %ntb

	%_93 = load i8*, i8** %root
	%_94 = bitcast i8* %_93 to i8***
	%_95 = load i8**, i8*** %_94
	%_96 = getelementptr i8*, i8** %_95, i32 18
	%_97 = load i8*, i8** %_96
	%_98 = bitcast i8* %_97 to i1 (i8*)*
	%_99 = call i1 %_98(i8* %_93)
	store i1 %_99, i1* %ntb

	%_101 = load i8*, i8** %root
	%_102 = bitcast i8* %_101 to i8***
	%_103 = load i8**, i8*** %_102
	%_104 = getelementptr i8*, i8** %_103, i32 17
	%_105 = load i8*, i8** %_104
	%_106 = bitcast i8* %_105 to i32 (i8*, i32)*
	%_107 = call i32 %_106(i8* %_101, i32 24)
	call void (i32) @print_int(i32 %_107)

	%_109 = load i8*, i8** %root
	%_110 = bitcast i8* %_109 to i8***
	%_111 = load i8**, i8*** %_110
	%_112 = getelementptr i8*, i8** %_111, i32 17
	%_113 = load i8*, i8** %_112
	%_114 = bitcast i8* %_113 to i32 (i8*, i32)*
	%_115 = call i32 %_114(i8* %_109, i32 12)
	call void (i32) @print_int(i32 %_115)

	%_117 = load i8*, i8** %root
	%_118 = bitcast i8* %_117 to i8***
	%_119 = load i8**, i8*** %_118
	%_120 = getelementptr i8*, i8** %_119, i32 17
	%_121 = load i8*, i8** %_120
	%_122 = bitcast i8* %_121 to i32 (i8*, i32)*
	%_123 = call i32 %_122(i8* %_117, i32 16)
	call void (i32) @print_int(i32 %_123)

	%_125 = load i8*, i8** %root
	%_126 = bitcast i8* %_125 to i8***
	%_127 = load i8**, i8*** %_126
	%_128 = getelementptr i8*, i8** %_127, i32 17
	%_129 = load i8*, i8** %_128
	%_130 = bitcast i8* %_129 to i32 (i8*, i32)*
	%_131 = call i32 %_130(i8* %_125, i32 50)
	call void (i32) @print_int(i32 %_131)

	%_133 = load i8*, i8** %root
	%_134 = bitcast i8* %_133 to i8***
	%_135 = load i8**, i8*** %_134
	%_136 = getelementptr i8*, i8** %_135, i32 17
	%_137 = load i8*, i8** %_136
	%_138 = bitcast i8* %_137 to i32 (i8*, i32)*
	%_139 = call i32 %_138(i8* %_133, i32 12)
	call void (i32) @print_int(i32 %_139)

	%_141 = load i8*, i8** %root
	%_142 = bitcast i8* %_141 to i8***
	%_143 = load i8**, i8*** %_142
	%_144 = getelementptr i8*, i8** %_143, i32 13
	%_145 = load i8*, i8** %_144
	%_146 = bitcast i8* %_145 to i1 (i8*, i32)*
	%_147 = call i1 %_146(i8* %_141, i32 12)
	store i1 %_147, i1* %ntb

	%_149 = load i8*, i8** %root
	%_150 = bitcast i8* %_149 to i8***
	%_151 = load i8**, i8*** %_150
	%_152 = getelementptr i8*, i8** %_151, i32 18
	%_153 = load i8*, i8** %_152
	%_154 = bitcast i8* %_153 to i1 (i8*)*
	%_155 = call i1 %_154(i8* %_149)
	store i1 %_155, i1* %ntb

	%_157 = load i8*, i8** %root
	%_158 = bitcast i8* %_157 to i8***
	%_159 = load i8**, i8*** %_158
	%_160 = getelementptr i8*, i8** %_159, i32 17
	%_161 = load i8*, i8** %_160
	%_162 = bitcast i8* %_161 to i32 (i8*, i32)*
	%_163 = call i32 %_162(i8* %_157, i32 12)
	call void (i32) @print_int(i32 %_163)

	ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_165 = load i32, i32* %v_key
	%_166 = getelementptr i8, i8* %this, i32 24
	%_167 = bitcast i8* %_166 to i32*
	store i32 %_165, i32* %_167

	%_168 = getelementptr i8, i8* %this, i32 28
	%_169 = bitcast i8* %_168 to i1*
	store i1 0, i1* %_169

	%_170 = getelementptr i8, i8* %this, i32 29
	%_171 = bitcast i8* %_170 to i1*
	store i1 0, i1* %_171

	ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn

	%_172 = load i8*, i8** %rn
	%_173 = getelementptr i8, i8* %this, i32 16
	%_174 = bitcast i8* %_173 to i8**
	store i8* %_172, i8** %_174

	ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln

	%_175 = load i8*, i8** %ln
	%_176 = getelementptr i8, i8* %this, i32 8
	%_177 = bitcast i8* %_176 to i8**
	store i8* %_175, i8** %_177

	ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {

	%_179 = getelementptr i8, i8* %this, i32 16
	%_180 = bitcast i8* %_179 to i8**
	%_178 = load i8*, i8** %_180
	ret i8* %_178
}

define i8* @Tree.GetLeft(i8* %this) {

	%_182 = getelementptr i8, i8* %this, i32 8
	%_183 = bitcast i8* %_182 to i8**
	%_181 = load i8*, i8** %_183
	ret i8* %_181
}

define i32 @Tree.GetKey(i8* %this) {

	%_185 = getelementptr i8, i8* %this, i32 24
	%_186 = bitcast i8* %_185 to i32*
	%_184 = load i32, i32* %_186
	ret i32 %_184
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_187 = load i32, i32* %v_key
	%_188 = getelementptr i8, i8* %this, i32 24
	%_189 = bitcast i8* %_188 to i32*
	store i32 %_187, i32* %_189

	ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {

	%_191 = getelementptr i8, i8* %this, i32 29
	%_192 = bitcast i8* %_191 to i1*
	%_190 = load i1, i1* %_192
	ret i1 %_190
}

define i1 @Tree.GetHas_Left(i8* %this) {

	%_194 = getelementptr i8, i8* %this, i32 28
	%_195 = bitcast i8* %_194 to i1*
	%_193 = load i1, i1* %_195
	ret i1 %_193
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_196 = load i1, i1* %val
	%_197 = getelementptr i8, i8* %this, i32 28
	%_198 = bitcast i8* %_197 to i1*
	store i1 %_196, i1* %_198

	ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_199 = load i1, i1* %val
	%_200 = getelementptr i8, i8* %this, i32 29
	%_201 = bitcast i8* %_200 to i1*
	store i1 %_199, i1* %_201

	ret i1 1
}

define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	%nti = alloca i32

	store i1 0, i1* %ntb

	%_202 = load i32, i32* %num2
	%_203 = add i32 %_202, 1
	store i32 %_203, i32* %nti

	%_204 = load i32, i32* %num1
	%_205 = load i32, i32* %num2
	%_206 = icmp slt i32 %_204, %_205
	br i1 %_206, label %L0, label %L1
L0:
	store i1 0, i1* %ntb

	br label %L2
L1:
	%_207 = load i32, i32* %num1
	%_208 = load i32, i32* %nti
	%_209 = icmp slt i32 %_207, %_208
	br i1 %_209, label %L3, label %L4
L3:
	br label %L5
L4:
	br label %L5
L5:
	%_210 = phi i1 [0, %L3], [1, %L4]
	br i1 %_210, label %L6, label %L7
L6:
	store i1 0, i1* %ntb

	br label %L8
L7:
	store i1 1, i1* %ntb

	br label %L8
L8:

	br label %L2
L2:

	%_211 = load i1, i1* %ntb
	ret i1 %_211
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca i8*

	%_212 = call i8* @calloc(i32 1, i32 38)
	%_213 = bitcast i8* %_212 to i8***
	%_214 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_214, i8*** %_213
	store i8* %_212, i8** %new_node

	%_215 = load i8*, i8** %new_node
	%_216 = load i32, i32* %v_key
	%_217 = bitcast i8* %_215 to i8***
	%_218 = load i8**, i8*** %_217
	%_219 = getelementptr i8*, i8** %_218, i32 0
	%_220 = load i8*, i8** %_219
	%_221 = bitcast i8* %_220 to i1 (i8*, i32)*
	%_222 = call i1 %_221(i8* %_215, i32 %_216)
	store i1 %_222, i1* %ntb

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	br label %L9
L9:
	%_224 = load i1, i1* %cont
	br i1 %_224, label %L10, label %L11
L10:
	%_225 = load i8*, i8** %current_node
	%_226 = bitcast i8* %_225 to i8***
	%_227 = load i8**, i8*** %_226
	%_228 = getelementptr i8*, i8** %_227, i32 5
	%_229 = load i8*, i8** %_228
	%_230 = bitcast i8* %_229 to i32 (i8*)*
	%_231 = call i32 %_230(i8* %_225)
	store i32 %_231, i32* %key_aux

	%_233 = load i32, i32* %v_key
	%_234 = load i32, i32* %key_aux
	%_235 = icmp slt i32 %_233, %_234
	br i1 %_235, label %L12, label %L13
L12:
	%_236 = load i8*, i8** %current_node
	%_237 = bitcast i8* %_236 to i8***
	%_238 = load i8**, i8*** %_237
	%_239 = getelementptr i8*, i8** %_238, i32 8
	%_240 = load i8*, i8** %_239
	%_241 = bitcast i8* %_240 to i1 (i8*)*
	%_242 = call i1 %_241(i8* %_236)
	br i1 %_242, label %L15, label %L16
L15:
	%_244 = load i8*, i8** %current_node
	%_245 = bitcast i8* %_244 to i8***
	%_246 = load i8**, i8*** %_245
	%_247 = getelementptr i8*, i8** %_246, i32 4
	%_248 = load i8*, i8** %_247
	%_249 = bitcast i8* %_248 to i8* (i8*)*
	%_250 = call i8* %_249(i8* %_244)
	store i8* %_250, i8** %current_node

	br label %L17
L16:
	store i1 0, i1* %cont

	%_252 = load i8*, i8** %current_node
	%_253 = bitcast i8* %_252 to i8***
	%_254 = load i8**, i8*** %_253
	%_255 = getelementptr i8*, i8** %_254, i32 9
	%_256 = load i8*, i8** %_255
	%_257 = bitcast i8* %_256 to i1 (i8*, i1)*
	%_258 = call i1 %_257(i8* %_252, i1 1)
	store i1 %_258, i1* %ntb

	%_260 = load i8*, i8** %current_node
	%_261 = load i8*, i8** %new_node
	%_262 = bitcast i8* %_260 to i8***
	%_263 = load i8**, i8*** %_262
	%_264 = getelementptr i8*, i8** %_263, i32 2
	%_265 = load i8*, i8** %_264
	%_266 = bitcast i8* %_265 to i1 (i8*, i8*)*
	%_267 = call i1 %_266(i8* %_260, i8* %_261)
	store i1 %_267, i1* %ntb


	br label %L17
L17:


	br label %L14
L13:
	%_269 = load i8*, i8** %current_node
	%_270 = bitcast i8* %_269 to i8***
	%_271 = load i8**, i8*** %_270
	%_272 = getelementptr i8*, i8** %_271, i32 7
	%_273 = load i8*, i8** %_272
	%_274 = bitcast i8* %_273 to i1 (i8*)*
	%_275 = call i1 %_274(i8* %_269)
	br i1 %_275, label %L18, label %L19
L18:
	%_277 = load i8*, i8** %current_node
	%_278 = bitcast i8* %_277 to i8***
	%_279 = load i8**, i8*** %_278
	%_280 = getelementptr i8*, i8** %_279, i32 3
	%_281 = load i8*, i8** %_280
	%_282 = bitcast i8* %_281 to i8* (i8*)*
	%_283 = call i8* %_282(i8* %_277)
	store i8* %_283, i8** %current_node

	br label %L20
L19:
	store i1 0, i1* %cont

	%_285 = load i8*, i8** %current_node
	%_286 = bitcast i8* %_285 to i8***
	%_287 = load i8**, i8*** %_286
	%_288 = getelementptr i8*, i8** %_287, i32 10
	%_289 = load i8*, i8** %_288
	%_290 = bitcast i8* %_289 to i1 (i8*, i1)*
	%_291 = call i1 %_290(i8* %_285, i1 1)
	store i1 %_291, i1* %ntb

	%_293 = load i8*, i8** %current_node
	%_294 = load i8*, i8** %new_node
	%_295 = bitcast i8* %_293 to i8***
	%_296 = load i8**, i8*** %_295
	%_297 = getelementptr i8*, i8** %_296, i32 1
	%_298 = load i8*, i8** %_297
	%_299 = bitcast i8* %_298 to i1 (i8*, i8*)*
	%_300 = call i1 %_299(i8* %_293, i8* %_294)
	store i1 %_300, i1* %ntb


	br label %L20
L20:


	br label %L14
L14:


	br label %L9
L11:

	ret i1 1
}

define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	%parent_node = alloca i8*
	%cont = alloca i1
	%found = alloca i1
	%is_root = alloca i1
	%key_aux = alloca i32
	%ntb = alloca i1

	store i8* %this, i8** %current_node

	store i8* %this, i8** %parent_node

	store i1 1, i1* %cont

	store i1 0, i1* %found

	store i1 1, i1* %is_root

	br label %L21
L21:
	%_302 = load i1, i1* %cont
	br i1 %_302, label %L22, label %L23
L22:
	%_303 = load i8*, i8** %current_node
	%_304 = bitcast i8* %_303 to i8***
	%_305 = load i8**, i8*** %_304
	%_306 = getelementptr i8*, i8** %_305, i32 5
	%_307 = load i8*, i8** %_306
	%_308 = bitcast i8* %_307 to i32 (i8*)*
	%_309 = call i32 %_308(i8* %_303)
	store i32 %_309, i32* %key_aux

	%_311 = load i32, i32* %v_key
	%_312 = load i32, i32* %key_aux
	%_313 = icmp slt i32 %_311, %_312
	br i1 %_313, label %L24, label %L25
L24:
	%_314 = load i8*, i8** %current_node
	%_315 = bitcast i8* %_314 to i8***
	%_316 = load i8**, i8*** %_315
	%_317 = getelementptr i8*, i8** %_316, i32 8
	%_318 = load i8*, i8** %_317
	%_319 = bitcast i8* %_318 to i1 (i8*)*
	%_320 = call i1 %_319(i8* %_314)
	br i1 %_320, label %L27, label %L28
L27:
	%_322 = load i8*, i8** %current_node
	store i8* %_322, i8** %parent_node

	%_323 = load i8*, i8** %current_node
	%_324 = bitcast i8* %_323 to i8***
	%_325 = load i8**, i8*** %_324
	%_326 = getelementptr i8*, i8** %_325, i32 4
	%_327 = load i8*, i8** %_326
	%_328 = bitcast i8* %_327 to i8* (i8*)*
	%_329 = call i8* %_328(i8* %_323)
	store i8* %_329, i8** %current_node


	br label %L29
L28:
	store i1 0, i1* %cont

	br label %L29
L29:

	br label %L26
L25:
	%_331 = load i32, i32* %key_aux
	%_332 = load i32, i32* %v_key
	%_333 = icmp slt i32 %_331, %_332
	br i1 %_333, label %L30, label %L31
L30:
	%_334 = load i8*, i8** %current_node
	%_335 = bitcast i8* %_334 to i8***
	%_336 = load i8**, i8*** %_335
	%_337 = getelementptr i8*, i8** %_336, i32 7
	%_338 = load i8*, i8** %_337
	%_339 = bitcast i8* %_338 to i1 (i8*)*
	%_340 = call i1 %_339(i8* %_334)
	br i1 %_340, label %L33, label %L34
L33:
	%_342 = load i8*, i8** %current_node
	store i8* %_342, i8** %parent_node

	%_343 = load i8*, i8** %current_node
	%_344 = bitcast i8* %_343 to i8***
	%_345 = load i8**, i8*** %_344
	%_346 = getelementptr i8*, i8** %_345, i32 3
	%_347 = load i8*, i8** %_346
	%_348 = bitcast i8* %_347 to i8* (i8*)*
	%_349 = call i8* %_348(i8* %_343)
	store i8* %_349, i8** %current_node


	br label %L35
L34:
	store i1 0, i1* %cont

	br label %L35
L35:

	br label %L32
L31:
	%_351 = load i1, i1* %is_root
	br i1 %_351, label %L36, label %L37
L36:
	%_352 = load i8*, i8** %current_node
	%_353 = bitcast i8* %_352 to i8***
	%_354 = load i8**, i8*** %_353
	%_355 = getelementptr i8*, i8** %_354, i32 7
	%_356 = load i8*, i8** %_355
	%_357 = bitcast i8* %_356 to i1 (i8*)*
	%_358 = call i1 %_357(i8* %_352)
	br i1 %_358, label %L39, label %L40
L39:
	br label %L41
L40:
	br label %L41
L41:
	%_360 = phi i1 [0, %L39], [1, %L40]
	br i1 %_360, label %L46, label %L45
L45:
	br label %L48
L46:
	%_361 = load i8*, i8** %current_node
	%_362 = bitcast i8* %_361 to i8***
	%_363 = load i8**, i8*** %_362
	%_364 = getelementptr i8*, i8** %_363, i32 8
	%_365 = load i8*, i8** %_364
	%_366 = bitcast i8* %_365 to i1 (i8*)*
	%_367 = call i1 %_366(i8* %_361)
	br i1 %_367, label %L42, label %L43
L42:
	br label %L44
L43:
	br label %L44
L44:
	%_369 = phi i1 [0, %L42], [1, %L43]
	br label %L47
L47:
	br label %L48
L48:
	%_370 = phi i1 [0, %L45], [%_369, %L47]
	br i1 %_370, label %L49, label %L50
L49:
	store i1 1, i1* %ntb

	br label %L51
L50:
	%_371 = load i8*, i8** %parent_node
	%_372 = load i8*, i8** %current_node
	%_373 = bitcast i8* %this to i8***
	%_374 = load i8**, i8*** %_373
	%_375 = getelementptr i8*, i8** %_374, i32 14
	%_376 = load i8*, i8** %_375
	%_377 = bitcast i8* %_376 to i1 (i8*, i8*, i8*)*
	%_378 = call i1 %_377(i8* %this, i8* %_371, i8* %_372)
	store i1 %_378, i1* %ntb

	br label %L51
L51:

	br label %L38
L37:
	%_380 = load i8*, i8** %parent_node
	%_381 = load i8*, i8** %current_node
	%_382 = bitcast i8* %this to i8***
	%_383 = load i8**, i8*** %_382
	%_384 = getelementptr i8*, i8** %_383, i32 14
	%_385 = load i8*, i8** %_384
	%_386 = bitcast i8* %_385 to i1 (i8*, i8*, i8*)*
	%_387 = call i1 %_386(i8* %this, i8* %_380, i8* %_381)
	store i1 %_387, i1* %ntb

	br label %L38
L38:

	store i1 1, i1* %found

	store i1 0, i1* %cont


	br label %L32
L32:

	br label %L26
L26:

	store i1 0, i1* %is_root


	br label %L21
L23:

	%_389 = load i1, i1* %found
	ret i1 %_389
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32

	%_390 = load i8*, i8** %c_node
	%_391 = bitcast i8* %_390 to i8***
	%_392 = load i8**, i8*** %_391
	%_393 = getelementptr i8*, i8** %_392, i32 8
	%_394 = load i8*, i8** %_393
	%_395 = bitcast i8* %_394 to i1 (i8*)*
	%_396 = call i1 %_395(i8* %_390)
	br i1 %_396, label %L52, label %L53
L52:
	%_398 = load i8*, i8** %p_node
	%_399 = load i8*, i8** %c_node
	%_400 = bitcast i8* %this to i8***
	%_401 = load i8**, i8*** %_400
	%_402 = getelementptr i8*, i8** %_401, i32 16
	%_403 = load i8*, i8** %_402
	%_404 = bitcast i8* %_403 to i1 (i8*, i8*, i8*)*
	%_405 = call i1 %_404(i8* %this, i8* %_398, i8* %_399)
	store i1 %_405, i1* %ntb

	br label %L54
L53:
	%_407 = load i8*, i8** %c_node
	%_408 = bitcast i8* %_407 to i8***
	%_409 = load i8**, i8*** %_408
	%_410 = getelementptr i8*, i8** %_409, i32 7
	%_411 = load i8*, i8** %_410
	%_412 = bitcast i8* %_411 to i1 (i8*)*
	%_413 = call i1 %_412(i8* %_407)
	br i1 %_413, label %L55, label %L56
L55:
	%_415 = load i8*, i8** %p_node
	%_416 = load i8*, i8** %c_node
	%_417 = bitcast i8* %this to i8***
	%_418 = load i8**, i8*** %_417
	%_419 = getelementptr i8*, i8** %_418, i32 15
	%_420 = load i8*, i8** %_419
	%_421 = bitcast i8* %_420 to i1 (i8*, i8*, i8*)*
	%_422 = call i1 %_421(i8* %this, i8* %_415, i8* %_416)
	store i1 %_422, i1* %ntb

	br label %L57
L56:
	%_424 = load i8*, i8** %c_node
	%_425 = bitcast i8* %_424 to i8***
	%_426 = load i8**, i8*** %_425
	%_427 = getelementptr i8*, i8** %_426, i32 5
	%_428 = load i8*, i8** %_427
	%_429 = bitcast i8* %_428 to i32 (i8*)*
	%_430 = call i32 %_429(i8* %_424)
	store i32 %_430, i32* %auxkey1

	%_432 = load i8*, i8** %p_node
	%_433 = bitcast i8* %_432 to i8***
	%_434 = load i8**, i8*** %_433
	%_435 = getelementptr i8*, i8** %_434, i32 4
	%_436 = load i8*, i8** %_435
	%_437 = bitcast i8* %_436 to i8* (i8*)*
	%_438 = call i8* %_437(i8* %_432)
	%_440 = bitcast i8* %_438 to i8***
	%_441 = load i8**, i8*** %_440
	%_442 = getelementptr i8*, i8** %_441, i32 5
	%_443 = load i8*, i8** %_442
	%_444 = bitcast i8* %_443 to i32 (i8*)*
	%_445 = call i32 %_444(i8* %_438)
	store i32 %_445, i32* %auxkey2

	%_447 = load i32, i32* %auxkey1
	%_448 = load i32, i32* %auxkey2
	%_449 = bitcast i8* %this to i8***
	%_450 = load i8**, i8*** %_449
	%_451 = getelementptr i8*, i8** %_450, i32 11
	%_452 = load i8*, i8** %_451
	%_453 = bitcast i8* %_452 to i1 (i8*, i32, i32)*
	%_454 = call i1 %_453(i8* %this, i32 %_447, i32 %_448)
	br i1 %_454, label %L58, label %L59
L58:
	%_456 = load i8*, i8** %p_node
	%_458 = getelementptr i8, i8* %this, i32 30
	%_459 = bitcast i8* %_458 to i8**
	%_457 = load i8*, i8** %_459
	%_460 = bitcast i8* %_456 to i8***
	%_461 = load i8**, i8*** %_460
	%_462 = getelementptr i8*, i8** %_461, i32 2
	%_463 = load i8*, i8** %_462
	%_464 = bitcast i8* %_463 to i1 (i8*, i8*)*
	%_465 = call i1 %_464(i8* %_456, i8* %_457)
	store i1 %_465, i1* %ntb

	%_467 = load i8*, i8** %p_node
	%_468 = bitcast i8* %_467 to i8***
	%_469 = load i8**, i8*** %_468
	%_470 = getelementptr i8*, i8** %_469, i32 9
	%_471 = load i8*, i8** %_470
	%_472 = bitcast i8* %_471 to i1 (i8*, i1)*
	%_473 = call i1 %_472(i8* %_467, i1 0)
	store i1 %_473, i1* %ntb


	br label %L60
L59:
	%_475 = load i8*, i8** %p_node
	%_477 = getelementptr i8, i8* %this, i32 30
	%_478 = bitcast i8* %_477 to i8**
	%_476 = load i8*, i8** %_478
	%_479 = bitcast i8* %_475 to i8***
	%_480 = load i8**, i8*** %_479
	%_481 = getelementptr i8*, i8** %_480, i32 1
	%_482 = load i8*, i8** %_481
	%_483 = bitcast i8* %_482 to i1 (i8*, i8*)*
	%_484 = call i1 %_483(i8* %_475, i8* %_476)
	store i1 %_484, i1* %ntb

	%_486 = load i8*, i8** %p_node
	%_487 = bitcast i8* %_486 to i8***
	%_488 = load i8**, i8*** %_487
	%_489 = getelementptr i8*, i8** %_488, i32 10
	%_490 = load i8*, i8** %_489
	%_491 = bitcast i8* %_490 to i1 (i8*, i1)*
	%_492 = call i1 %_491(i8* %_486, i1 0)
	store i1 %_492, i1* %ntb


	br label %L60
L60:


	br label %L57
L57:

	br label %L54
L54:

	ret i1 1
}

define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1

	br label %L61
L61:
	%_494 = load i8*, i8** %c_node
	%_495 = bitcast i8* %_494 to i8***
	%_496 = load i8**, i8*** %_495
	%_497 = getelementptr i8*, i8** %_496, i32 7
	%_498 = load i8*, i8** %_497
	%_499 = bitcast i8* %_498 to i1 (i8*)*
	%_500 = call i1 %_499(i8* %_494)
	br i1 %_500, label %L62, label %L63
L62:
	%_502 = load i8*, i8** %c_node
	%_503 = load i8*, i8** %c_node
	%_504 = bitcast i8* %_503 to i8***
	%_505 = load i8**, i8*** %_504
	%_506 = getelementptr i8*, i8** %_505, i32 3
	%_507 = load i8*, i8** %_506
	%_508 = bitcast i8* %_507 to i8* (i8*)*
	%_509 = call i8* %_508(i8* %_503)
	%_511 = bitcast i8* %_509 to i8***
	%_512 = load i8**, i8*** %_511
	%_513 = getelementptr i8*, i8** %_512, i32 5
	%_514 = load i8*, i8** %_513
	%_515 = bitcast i8* %_514 to i32 (i8*)*
	%_516 = call i32 %_515(i8* %_509)
	%_518 = bitcast i8* %_502 to i8***
	%_519 = load i8**, i8*** %_518
	%_520 = getelementptr i8*, i8** %_519, i32 6
	%_521 = load i8*, i8** %_520
	%_522 = bitcast i8* %_521 to i1 (i8*, i32)*
	%_523 = call i1 %_522(i8* %_502, i32 %_516)
	store i1 %_523, i1* %ntb

	%_525 = load i8*, i8** %c_node
	store i8* %_525, i8** %p_node

	%_526 = load i8*, i8** %c_node
	%_527 = bitcast i8* %_526 to i8***
	%_528 = load i8**, i8*** %_527
	%_529 = getelementptr i8*, i8** %_528, i32 3
	%_530 = load i8*, i8** %_529
	%_531 = bitcast i8* %_530 to i8* (i8*)*
	%_532 = call i8* %_531(i8* %_526)
	store i8* %_532, i8** %c_node


	br label %L61
L63:

	%_534 = load i8*, i8** %p_node
	%_536 = getelementptr i8, i8* %this, i32 30
	%_537 = bitcast i8* %_536 to i8**
	%_535 = load i8*, i8** %_537
	%_538 = bitcast i8* %_534 to i8***
	%_539 = load i8**, i8*** %_538
	%_540 = getelementptr i8*, i8** %_539, i32 1
	%_541 = load i8*, i8** %_540
	%_542 = bitcast i8* %_541 to i1 (i8*, i8*)*
	%_543 = call i1 %_542(i8* %_534, i8* %_535)
	store i1 %_543, i1* %ntb

	%_545 = load i8*, i8** %p_node
	%_546 = bitcast i8* %_545 to i8***
	%_547 = load i8**, i8*** %_546
	%_548 = getelementptr i8*, i8** %_547, i32 10
	%_549 = load i8*, i8** %_548
	%_550 = bitcast i8* %_549 to i1 (i8*, i1)*
	%_551 = call i1 %_550(i8* %_545, i1 0)
	store i1 %_551, i1* %ntb

	ret i1 1
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1

	br label %L64
L64:
	%_553 = load i8*, i8** %c_node
	%_554 = bitcast i8* %_553 to i8***
	%_555 = load i8**, i8*** %_554
	%_556 = getelementptr i8*, i8** %_555, i32 8
	%_557 = load i8*, i8** %_556
	%_558 = bitcast i8* %_557 to i1 (i8*)*
	%_559 = call i1 %_558(i8* %_553)
	br i1 %_559, label %L65, label %L66
L65:
	%_561 = load i8*, i8** %c_node
	%_562 = load i8*, i8** %c_node
	%_563 = bitcast i8* %_562 to i8***
	%_564 = load i8**, i8*** %_563
	%_565 = getelementptr i8*, i8** %_564, i32 4
	%_566 = load i8*, i8** %_565
	%_567 = bitcast i8* %_566 to i8* (i8*)*
	%_568 = call i8* %_567(i8* %_562)
	%_570 = bitcast i8* %_568 to i8***
	%_571 = load i8**, i8*** %_570
	%_572 = getelementptr i8*, i8** %_571, i32 5
	%_573 = load i8*, i8** %_572
	%_574 = bitcast i8* %_573 to i32 (i8*)*
	%_575 = call i32 %_574(i8* %_568)
	%_577 = bitcast i8* %_561 to i8***
	%_578 = load i8**, i8*** %_577
	%_579 = getelementptr i8*, i8** %_578, i32 6
	%_580 = load i8*, i8** %_579
	%_581 = bitcast i8* %_580 to i1 (i8*, i32)*
	%_582 = call i1 %_581(i8* %_561, i32 %_575)
	store i1 %_582, i1* %ntb

	%_584 = load i8*, i8** %c_node
	store i8* %_584, i8** %p_node

	%_585 = load i8*, i8** %c_node
	%_586 = bitcast i8* %_585 to i8***
	%_587 = load i8**, i8*** %_586
	%_588 = getelementptr i8*, i8** %_587, i32 4
	%_589 = load i8*, i8** %_588
	%_590 = bitcast i8* %_589 to i8* (i8*)*
	%_591 = call i8* %_590(i8* %_585)
	store i8* %_591, i8** %c_node


	br label %L64
L66:

	%_593 = load i8*, i8** %p_node
	%_595 = getelementptr i8, i8* %this, i32 30
	%_596 = bitcast i8* %_595 to i8**
	%_594 = load i8*, i8** %_596
	%_597 = bitcast i8* %_593 to i8***
	%_598 = load i8**, i8*** %_597
	%_599 = getelementptr i8*, i8** %_598, i32 2
	%_600 = load i8*, i8** %_599
	%_601 = bitcast i8* %_600 to i1 (i8*, i8*)*
	%_602 = call i1 %_601(i8* %_593, i8* %_594)
	store i1 %_602, i1* %ntb

	%_604 = load i8*, i8** %p_node
	%_605 = bitcast i8* %_604 to i8***
	%_606 = load i8**, i8*** %_605
	%_607 = getelementptr i8*, i8** %_606, i32 9
	%_608 = load i8*, i8** %_607
	%_609 = bitcast i8* %_608 to i1 (i8*, i1)*
	%_610 = call i1 %_609(i8* %_604, i1 0)
	store i1 %_610, i1* %ntb

	ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%cont = alloca i1
	%ifound = alloca i32
	%current_node = alloca i8*
	%key_aux = alloca i32

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	store i32 0, i32* %ifound

	br label %L67
L67:
	%_612 = load i1, i1* %cont
	br i1 %_612, label %L68, label %L69
L68:
	%_613 = load i8*, i8** %current_node
	%_614 = bitcast i8* %_613 to i8***
	%_615 = load i8**, i8*** %_614
	%_616 = getelementptr i8*, i8** %_615, i32 5
	%_617 = load i8*, i8** %_616
	%_618 = bitcast i8* %_617 to i32 (i8*)*
	%_619 = call i32 %_618(i8* %_613)
	store i32 %_619, i32* %key_aux

	%_621 = load i32, i32* %v_key
	%_622 = load i32, i32* %key_aux
	%_623 = icmp slt i32 %_621, %_622
	br i1 %_623, label %L70, label %L71
L70:
	%_624 = load i8*, i8** %current_node
	%_625 = bitcast i8* %_624 to i8***
	%_626 = load i8**, i8*** %_625
	%_627 = getelementptr i8*, i8** %_626, i32 8
	%_628 = load i8*, i8** %_627
	%_629 = bitcast i8* %_628 to i1 (i8*)*
	%_630 = call i1 %_629(i8* %_624)
	br i1 %_630, label %L73, label %L74
L73:
	%_632 = load i8*, i8** %current_node
	%_633 = bitcast i8* %_632 to i8***
	%_634 = load i8**, i8*** %_633
	%_635 = getelementptr i8*, i8** %_634, i32 4
	%_636 = load i8*, i8** %_635
	%_637 = bitcast i8* %_636 to i8* (i8*)*
	%_638 = call i8* %_637(i8* %_632)
	store i8* %_638, i8** %current_node

	br label %L75
L74:
	store i1 0, i1* %cont

	br label %L75
L75:

	br label %L72
L71:
	%_640 = load i32, i32* %key_aux
	%_641 = load i32, i32* %v_key
	%_642 = icmp slt i32 %_640, %_641
	br i1 %_642, label %L76, label %L77
L76:
	%_643 = load i8*, i8** %current_node
	%_644 = bitcast i8* %_643 to i8***
	%_645 = load i8**, i8*** %_644
	%_646 = getelementptr i8*, i8** %_645, i32 7
	%_647 = load i8*, i8** %_646
	%_648 = bitcast i8* %_647 to i1 (i8*)*
	%_649 = call i1 %_648(i8* %_643)
	br i1 %_649, label %L79, label %L80
L79:
	%_651 = load i8*, i8** %current_node
	%_652 = bitcast i8* %_651 to i8***
	%_653 = load i8**, i8*** %_652
	%_654 = getelementptr i8*, i8** %_653, i32 3
	%_655 = load i8*, i8** %_654
	%_656 = bitcast i8* %_655 to i8* (i8*)*
	%_657 = call i8* %_656(i8* %_651)
	store i8* %_657, i8** %current_node

	br label %L81
L80:
	store i1 0, i1* %cont

	br label %L81
L81:

	br label %L78
L77:
	store i32 1, i32* %ifound

	store i1 0, i1* %cont


	br label %L78
L78:

	br label %L72
L72:


	br label %L67
L69:

	%_659 = load i32, i32* %ifound
	ret i32 %_659
}

define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*
	%ntb = alloca i1

	store i8* %this, i8** %current_node

	%_660 = load i8*, i8** %current_node
	%_661 = bitcast i8* %this to i8***
	%_662 = load i8**, i8*** %_661
	%_663 = getelementptr i8*, i8** %_662, i32 19
	%_664 = load i8*, i8** %_663
	%_665 = bitcast i8* %_664 to i1 (i8*, i8*)*
	%_666 = call i1 %_665(i8* %this, i8* %_660)
	store i1 %_666, i1* %ntb

	ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1

	%_668 = load i8*, i8** %node
	%_669 = bitcast i8* %_668 to i8***
	%_670 = load i8**, i8*** %_669
	%_671 = getelementptr i8*, i8** %_670, i32 8
	%_672 = load i8*, i8** %_671
	%_673 = bitcast i8* %_672 to i1 (i8*)*
	%_674 = call i1 %_673(i8* %_668)
	br i1 %_674, label %L82, label %L83
L82:
	%_676 = load i8*, i8** %node
	%_677 = bitcast i8* %_676 to i8***
	%_678 = load i8**, i8*** %_677
	%_679 = getelementptr i8*, i8** %_678, i32 4
	%_680 = load i8*, i8** %_679
	%_681 = bitcast i8* %_680 to i8* (i8*)*
	%_682 = call i8* %_681(i8* %_676)
	%_684 = bitcast i8* %this to i8***
	%_685 = load i8**, i8*** %_684
	%_686 = getelementptr i8*, i8** %_685, i32 19
	%_687 = load i8*, i8** %_686
	%_688 = bitcast i8* %_687 to i1 (i8*, i8*)*
	%_689 = call i1 %_688(i8* %this, i8* %_682)
	store i1 %_689, i1* %ntb


	br label %L84
L83:
	store i1 1, i1* %ntb

	br label %L84
L84:

	%_691 = load i8*, i8** %node
	%_692 = bitcast i8* %_691 to i8***
	%_693 = load i8**, i8*** %_692
	%_694 = getelementptr i8*, i8** %_693, i32 5
	%_695 = load i8*, i8** %_694
	%_696 = bitcast i8* %_695 to i32 (i8*)*
	%_697 = call i32 %_696(i8* %_691)
	call void (i32) @print_int(i32 %_697)

	%_699 = load i8*, i8** %node
	%_700 = bitcast i8* %_699 to i8***
	%_701 = load i8**, i8*** %_700
	%_702 = getelementptr i8*, i8** %_701, i32 7
	%_703 = load i8*, i8** %_702
	%_704 = bitcast i8* %_703 to i1 (i8*)*
	%_705 = call i1 %_704(i8* %_699)
	br i1 %_705, label %L85, label %L86
L85:
	%_707 = load i8*, i8** %node
	%_708 = bitcast i8* %_707 to i8***
	%_709 = load i8**, i8*** %_708
	%_710 = getelementptr i8*, i8** %_709, i32 3
	%_711 = load i8*, i8** %_710
	%_712 = bitcast i8* %_711 to i8* (i8*)*
	%_713 = call i8* %_712(i8* %_707)
	%_715 = bitcast i8* %this to i8***
	%_716 = load i8**, i8*** %_715
	%_717 = getelementptr i8*, i8** %_716, i32 19
	%_718 = load i8*, i8** %_717
	%_719 = bitcast i8* %_718 to i1 (i8*, i8*)*
	%_720 = call i1 %_719(i8* %this, i8* %_713)
	store i1 %_720, i1* %ntb


	br label %L87
L86:
	store i1 1, i1* %ntb

	br label %L87
L87:

	ret i1 1
}

