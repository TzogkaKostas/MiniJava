@.TreeVisitor_vtable = global [0 x i8*] []

@.TV_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*)* @TV.Start to i8*)
]

@.Tree_vtable = global [21 x i8*] [
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
	i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*),
	i8* bitcast (i32 (i8*, i8*)* @Tree.accept to i8*)
]

@.Visitor_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*, i8*)* @Visitor.visit to i8*)
]

@.MyVisitor_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*, i8*)* @MyVisitor.visit to i8*)
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

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0
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

define i32 @TV.Start(i8* %this) {
	%root = alloca i8*
	%ntb = alloca i1
	%nti = alloca i32
	%v = alloca i8*

	%_10 = call i8* @calloc(i32 1, i32 38)
	%_11 = bitcast i8* %_10 to i8***
	%_12 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
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
	%_40 = getelementptr i8*, i8** %_39, i32 12
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i1 (i8*, i32)*
	%_43 = call i1 %_42(i8* %_37, i32 24)
	store i1 %_43, i1* %ntb

	%_45 = load i8*, i8** %root
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 12
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*, i32)*
	%_51 = call i1 %_50(i8* %_45, i32 4)
	store i1 %_51, i1* %ntb

	%_53 = load i8*, i8** %root
	%_54 = bitcast i8* %_53 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 12
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*, i32)*
	%_59 = call i1 %_58(i8* %_53, i32 12)
	store i1 %_59, i1* %ntb

	%_61 = load i8*, i8** %root
	%_62 = bitcast i8* %_61 to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 12
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i1 (i8*, i32)*
	%_67 = call i1 %_66(i8* %_61, i32 20)
	store i1 %_67, i1* %ntb

	%_69 = load i8*, i8** %root
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 12
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*, i32)*
	%_75 = call i1 %_74(i8* %_69, i32 28)
	store i1 %_75, i1* %ntb

	%_77 = load i8*, i8** %root
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 12
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*, i32)*
	%_83 = call i1 %_82(i8* %_77, i32 14)
	store i1 %_83, i1* %ntb

	%_85 = load i8*, i8** %root
	%_86 = bitcast i8* %_85 to i8***
	%_87 = load i8**, i8*** %_86
	%_88 = getelementptr i8*, i8** %_87, i32 18
	%_89 = load i8*, i8** %_88
	%_90 = bitcast i8* %_89 to i1 (i8*)*
	%_91 = call i1 %_90(i8* %_85)
	store i1 %_91, i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_93 = call i8* @calloc(i32 1, i32 24)
	%_94 = bitcast i8* %_93 to i8***
	%_95 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0
	store i8** %_95, i8*** %_94
	store i8* %_93, i8** %v

	call void (i32) @print_int(i32 50000000)

	%_96 = load i8*, i8** %root
	%_97 = load i8*, i8** %v
	%_98 = bitcast i8* %_96 to i8***
	%_99 = load i8**, i8*** %_98
	%_100 = getelementptr i8*, i8** %_99, i32 20
	%_101 = load i8*, i8** %_100
	%_102 = bitcast i8* %_101 to i32 (i8*, i8*)*
	%_103 = call i32 %_102(i8* %_96, i8* %_97)
	store i32 %_103, i32* %nti

	call void (i32) @print_int(i32 100000000)

	%_105 = load i8*, i8** %root
	%_106 = bitcast i8* %_105 to i8***
	%_107 = load i8**, i8*** %_106
	%_108 = getelementptr i8*, i8** %_107, i32 17
	%_109 = load i8*, i8** %_108
	%_110 = bitcast i8* %_109 to i32 (i8*, i32)*
	%_111 = call i32 %_110(i8* %_105, i32 24)
	call void (i32) @print_int(i32 %_111)

	%_113 = load i8*, i8** %root
	%_114 = bitcast i8* %_113 to i8***
	%_115 = load i8**, i8*** %_114
	%_116 = getelementptr i8*, i8** %_115, i32 17
	%_117 = load i8*, i8** %_116
	%_118 = bitcast i8* %_117 to i32 (i8*, i32)*
	%_119 = call i32 %_118(i8* %_113, i32 12)
	call void (i32) @print_int(i32 %_119)

	%_121 = load i8*, i8** %root
	%_122 = bitcast i8* %_121 to i8***
	%_123 = load i8**, i8*** %_122
	%_124 = getelementptr i8*, i8** %_123, i32 17
	%_125 = load i8*, i8** %_124
	%_126 = bitcast i8* %_125 to i32 (i8*, i32)*
	%_127 = call i32 %_126(i8* %_121, i32 16)
	call void (i32) @print_int(i32 %_127)

	%_129 = load i8*, i8** %root
	%_130 = bitcast i8* %_129 to i8***
	%_131 = load i8**, i8*** %_130
	%_132 = getelementptr i8*, i8** %_131, i32 17
	%_133 = load i8*, i8** %_132
	%_134 = bitcast i8* %_133 to i32 (i8*, i32)*
	%_135 = call i32 %_134(i8* %_129, i32 50)
	call void (i32) @print_int(i32 %_135)

	%_137 = load i8*, i8** %root
	%_138 = bitcast i8* %_137 to i8***
	%_139 = load i8**, i8*** %_138
	%_140 = getelementptr i8*, i8** %_139, i32 17
	%_141 = load i8*, i8** %_140
	%_142 = bitcast i8* %_141 to i32 (i8*, i32)*
	%_143 = call i32 %_142(i8* %_137, i32 12)
	call void (i32) @print_int(i32 %_143)

	%_145 = load i8*, i8** %root
	%_146 = bitcast i8* %_145 to i8***
	%_147 = load i8**, i8*** %_146
	%_148 = getelementptr i8*, i8** %_147, i32 13
	%_149 = load i8*, i8** %_148
	%_150 = bitcast i8* %_149 to i1 (i8*, i32)*
	%_151 = call i1 %_150(i8* %_145, i32 12)
	store i1 %_151, i1* %ntb

	%_153 = load i8*, i8** %root
	%_154 = bitcast i8* %_153 to i8***
	%_155 = load i8**, i8*** %_154
	%_156 = getelementptr i8*, i8** %_155, i32 18
	%_157 = load i8*, i8** %_156
	%_158 = bitcast i8* %_157 to i1 (i8*)*
	%_159 = call i1 %_158(i8* %_153)
	store i1 %_159, i1* %ntb

	%_161 = load i8*, i8** %root
	%_162 = bitcast i8* %_161 to i8***
	%_163 = load i8**, i8*** %_162
	%_164 = getelementptr i8*, i8** %_163, i32 17
	%_165 = load i8*, i8** %_164
	%_166 = bitcast i8* %_165 to i32 (i8*, i32)*
	%_167 = call i32 %_166(i8* %_161, i32 12)
	call void (i32) @print_int(i32 %_167)

	ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_169 = load i32, i32* %v_key
	%_170 = getelementptr i8, i8* %this, i32 24
	%_171 = bitcast i8* %_170 to i32*
	store i32 %_169, i32* %_171

	%_172 = getelementptr i8, i8* %this, i32 28
	%_173 = bitcast i8* %_172 to i1*
	store i1 0, i1* %_173

	%_174 = getelementptr i8, i8* %this, i32 29
	%_175 = bitcast i8* %_174 to i1*
	store i1 0, i1* %_175

	ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn

	%_176 = load i8*, i8** %rn
	%_177 = getelementptr i8, i8* %this, i32 16
	%_178 = bitcast i8* %_177 to i8**
	store i8* %_176, i8** %_178

	ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln

	%_179 = load i8*, i8** %ln
	%_180 = getelementptr i8, i8* %this, i32 8
	%_181 = bitcast i8* %_180 to i8**
	store i8* %_179, i8** %_181

	ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {

	%_183 = getelementptr i8, i8* %this, i32 16
	%_184 = bitcast i8* %_183 to i8**
	%_182 = load i8*, i8** %_184
	ret i8* %_182
}

define i8* @Tree.GetLeft(i8* %this) {

	%_186 = getelementptr i8, i8* %this, i32 8
	%_187 = bitcast i8* %_186 to i8**
	%_185 = load i8*, i8** %_187
	ret i8* %_185
}

define i32 @Tree.GetKey(i8* %this) {

	%_189 = getelementptr i8, i8* %this, i32 24
	%_190 = bitcast i8* %_189 to i32*
	%_188 = load i32, i32* %_190
	ret i32 %_188
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_191 = load i32, i32* %v_key
	%_192 = getelementptr i8, i8* %this, i32 24
	%_193 = bitcast i8* %_192 to i32*
	store i32 %_191, i32* %_193

	ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {

	%_195 = getelementptr i8, i8* %this, i32 29
	%_196 = bitcast i8* %_195 to i1*
	%_194 = load i1, i1* %_196
	ret i1 %_194
}

define i1 @Tree.GetHas_Left(i8* %this) {

	%_198 = getelementptr i8, i8* %this, i32 28
	%_199 = bitcast i8* %_198 to i1*
	%_197 = load i1, i1* %_199
	ret i1 %_197
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_200 = load i1, i1* %val
	%_201 = getelementptr i8, i8* %this, i32 28
	%_202 = bitcast i8* %_201 to i1*
	store i1 %_200, i1* %_202

	ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_203 = load i1, i1* %val
	%_204 = getelementptr i8, i8* %this, i32 29
	%_205 = bitcast i8* %_204 to i1*
	store i1 %_203, i1* %_205

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

	%_206 = load i32, i32* %num2
	%_207 = add i32 %_206, 1
	store i32 %_207, i32* %nti

	%_208 = load i32, i32* %num1
	%_209 = load i32, i32* %num2
	%_210 = icmp slt i32 %_208, %_209
	br i1 %_210, label %L0, label %L1
L0:
	store i1 0, i1* %ntb

	br label %L2
L1:
	%_211 = load i32, i32* %num1
	%_212 = load i32, i32* %nti
	%_213 = icmp slt i32 %_211, %_212
	br i1 %_213, label %L3, label %L4
L3:
	br label %L5
L4:
	br label %L5
L5:
	%_214 = phi i1 [0, %L3], [1, %L4]
	br i1 %_214, label %L6, label %L7
L6:
	store i1 0, i1* %ntb

	br label %L8
L7:
	store i1 1, i1* %ntb

	br label %L8
L8:

	br label %L2
L2:

	%_215 = load i1, i1* %ntb
	ret i1 %_215
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%current_node = alloca i8*
	%cont = alloca i1
	%key_aux = alloca i32

	%_216 = call i8* @calloc(i32 1, i32 38)
	%_217 = bitcast i8* %_216 to i8***
	%_218 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_218, i8*** %_217
	store i8* %_216, i8** %new_node

	%_219 = load i8*, i8** %new_node
	%_220 = load i32, i32* %v_key
	%_221 = bitcast i8* %_219 to i8***
	%_222 = load i8**, i8*** %_221
	%_223 = getelementptr i8*, i8** %_222, i32 0
	%_224 = load i8*, i8** %_223
	%_225 = bitcast i8* %_224 to i1 (i8*, i32)*
	%_226 = call i1 %_225(i8* %_219, i32 %_220)
	store i1 %_226, i1* %ntb

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	br label %L9
L9:
	%_228 = load i1, i1* %cont
	br i1 %_228, label %L10, label %L11
L10:
	%_229 = load i8*, i8** %current_node
	%_230 = bitcast i8* %_229 to i8***
	%_231 = load i8**, i8*** %_230
	%_232 = getelementptr i8*, i8** %_231, i32 5
	%_233 = load i8*, i8** %_232
	%_234 = bitcast i8* %_233 to i32 (i8*)*
	%_235 = call i32 %_234(i8* %_229)
	store i32 %_235, i32* %key_aux

	%_237 = load i32, i32* %v_key
	%_238 = load i32, i32* %key_aux
	%_239 = icmp slt i32 %_237, %_238
	br i1 %_239, label %L12, label %L13
L12:
	%_240 = load i8*, i8** %current_node
	%_241 = bitcast i8* %_240 to i8***
	%_242 = load i8**, i8*** %_241
	%_243 = getelementptr i8*, i8** %_242, i32 8
	%_244 = load i8*, i8** %_243
	%_245 = bitcast i8* %_244 to i1 (i8*)*
	%_246 = call i1 %_245(i8* %_240)
	br i1 %_246, label %L15, label %L16
L15:
	%_248 = load i8*, i8** %current_node
	%_249 = bitcast i8* %_248 to i8***
	%_250 = load i8**, i8*** %_249
	%_251 = getelementptr i8*, i8** %_250, i32 4
	%_252 = load i8*, i8** %_251
	%_253 = bitcast i8* %_252 to i8* (i8*)*
	%_254 = call i8* %_253(i8* %_248)
	store i8* %_254, i8** %current_node

	br label %L17
L16:
	store i1 0, i1* %cont

	%_256 = load i8*, i8** %current_node
	%_257 = bitcast i8* %_256 to i8***
	%_258 = load i8**, i8*** %_257
	%_259 = getelementptr i8*, i8** %_258, i32 9
	%_260 = load i8*, i8** %_259
	%_261 = bitcast i8* %_260 to i1 (i8*, i1)*
	%_262 = call i1 %_261(i8* %_256, i1 1)
	store i1 %_262, i1* %ntb

	%_264 = load i8*, i8** %current_node
	%_265 = load i8*, i8** %new_node
	%_266 = bitcast i8* %_264 to i8***
	%_267 = load i8**, i8*** %_266
	%_268 = getelementptr i8*, i8** %_267, i32 2
	%_269 = load i8*, i8** %_268
	%_270 = bitcast i8* %_269 to i1 (i8*, i8*)*
	%_271 = call i1 %_270(i8* %_264, i8* %_265)
	store i1 %_271, i1* %ntb


	br label %L17
L17:


	br label %L14
L13:
	%_273 = load i8*, i8** %current_node
	%_274 = bitcast i8* %_273 to i8***
	%_275 = load i8**, i8*** %_274
	%_276 = getelementptr i8*, i8** %_275, i32 7
	%_277 = load i8*, i8** %_276
	%_278 = bitcast i8* %_277 to i1 (i8*)*
	%_279 = call i1 %_278(i8* %_273)
	br i1 %_279, label %L18, label %L19
L18:
	%_281 = load i8*, i8** %current_node
	%_282 = bitcast i8* %_281 to i8***
	%_283 = load i8**, i8*** %_282
	%_284 = getelementptr i8*, i8** %_283, i32 3
	%_285 = load i8*, i8** %_284
	%_286 = bitcast i8* %_285 to i8* (i8*)*
	%_287 = call i8* %_286(i8* %_281)
	store i8* %_287, i8** %current_node

	br label %L20
L19:
	store i1 0, i1* %cont

	%_289 = load i8*, i8** %current_node
	%_290 = bitcast i8* %_289 to i8***
	%_291 = load i8**, i8*** %_290
	%_292 = getelementptr i8*, i8** %_291, i32 10
	%_293 = load i8*, i8** %_292
	%_294 = bitcast i8* %_293 to i1 (i8*, i1)*
	%_295 = call i1 %_294(i8* %_289, i1 1)
	store i1 %_295, i1* %ntb

	%_297 = load i8*, i8** %current_node
	%_298 = load i8*, i8** %new_node
	%_299 = bitcast i8* %_297 to i8***
	%_300 = load i8**, i8*** %_299
	%_301 = getelementptr i8*, i8** %_300, i32 1
	%_302 = load i8*, i8** %_301
	%_303 = bitcast i8* %_302 to i1 (i8*, i8*)*
	%_304 = call i1 %_303(i8* %_297, i8* %_298)
	store i1 %_304, i1* %ntb


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
	%ntb = alloca i1
	%is_root = alloca i1
	%key_aux = alloca i32

	store i8* %this, i8** %current_node

	store i8* %this, i8** %parent_node

	store i1 1, i1* %cont

	store i1 0, i1* %found

	store i1 1, i1* %is_root

	br label %L21
L21:
	%_306 = load i1, i1* %cont
	br i1 %_306, label %L22, label %L23
L22:
	%_307 = load i8*, i8** %current_node
	%_308 = bitcast i8* %_307 to i8***
	%_309 = load i8**, i8*** %_308
	%_310 = getelementptr i8*, i8** %_309, i32 5
	%_311 = load i8*, i8** %_310
	%_312 = bitcast i8* %_311 to i32 (i8*)*
	%_313 = call i32 %_312(i8* %_307)
	store i32 %_313, i32* %key_aux

	%_315 = load i32, i32* %v_key
	%_316 = load i32, i32* %key_aux
	%_317 = icmp slt i32 %_315, %_316
	br i1 %_317, label %L24, label %L25
L24:
	%_318 = load i8*, i8** %current_node
	%_319 = bitcast i8* %_318 to i8***
	%_320 = load i8**, i8*** %_319
	%_321 = getelementptr i8*, i8** %_320, i32 8
	%_322 = load i8*, i8** %_321
	%_323 = bitcast i8* %_322 to i1 (i8*)*
	%_324 = call i1 %_323(i8* %_318)
	br i1 %_324, label %L27, label %L28
L27:
	%_326 = load i8*, i8** %current_node
	store i8* %_326, i8** %parent_node

	%_327 = load i8*, i8** %current_node
	%_328 = bitcast i8* %_327 to i8***
	%_329 = load i8**, i8*** %_328
	%_330 = getelementptr i8*, i8** %_329, i32 4
	%_331 = load i8*, i8** %_330
	%_332 = bitcast i8* %_331 to i8* (i8*)*
	%_333 = call i8* %_332(i8* %_327)
	store i8* %_333, i8** %current_node


	br label %L29
L28:
	store i1 0, i1* %cont

	br label %L29
L29:

	br label %L26
L25:
	%_335 = load i32, i32* %key_aux
	%_336 = load i32, i32* %v_key
	%_337 = icmp slt i32 %_335, %_336
	br i1 %_337, label %L30, label %L31
L30:
	%_338 = load i8*, i8** %current_node
	%_339 = bitcast i8* %_338 to i8***
	%_340 = load i8**, i8*** %_339
	%_341 = getelementptr i8*, i8** %_340, i32 7
	%_342 = load i8*, i8** %_341
	%_343 = bitcast i8* %_342 to i1 (i8*)*
	%_344 = call i1 %_343(i8* %_338)
	br i1 %_344, label %L33, label %L34
L33:
	%_346 = load i8*, i8** %current_node
	store i8* %_346, i8** %parent_node

	%_347 = load i8*, i8** %current_node
	%_348 = bitcast i8* %_347 to i8***
	%_349 = load i8**, i8*** %_348
	%_350 = getelementptr i8*, i8** %_349, i32 3
	%_351 = load i8*, i8** %_350
	%_352 = bitcast i8* %_351 to i8* (i8*)*
	%_353 = call i8* %_352(i8* %_347)
	store i8* %_353, i8** %current_node


	br label %L35
L34:
	store i1 0, i1* %cont

	br label %L35
L35:

	br label %L32
L31:
	%_355 = load i1, i1* %is_root
	br i1 %_355, label %L36, label %L37
L36:
	%_356 = load i8*, i8** %current_node
	%_357 = bitcast i8* %_356 to i8***
	%_358 = load i8**, i8*** %_357
	%_359 = getelementptr i8*, i8** %_358, i32 7
	%_360 = load i8*, i8** %_359
	%_361 = bitcast i8* %_360 to i1 (i8*)*
	%_362 = call i1 %_361(i8* %_356)
	br i1 %_362, label %L39, label %L40
L39:
	br label %L41
L40:
	br label %L41
L41:
	%_364 = phi i1 [0, %L39], [1, %L40]
	br i1 %_364, label %L46, label %L45
L45:
	br label %L48
L46:
	%_365 = load i8*, i8** %current_node
	%_366 = bitcast i8* %_365 to i8***
	%_367 = load i8**, i8*** %_366
	%_368 = getelementptr i8*, i8** %_367, i32 8
	%_369 = load i8*, i8** %_368
	%_370 = bitcast i8* %_369 to i1 (i8*)*
	%_371 = call i1 %_370(i8* %_365)
	br i1 %_371, label %L42, label %L43
L42:
	br label %L44
L43:
	br label %L44
L44:
	%_373 = phi i1 [0, %L42], [1, %L43]
	br label %L47
L47:
	br label %L48
L48:
	%_374 = phi i1 [0, %L45], [%_373, %L47]
	br i1 %_374, label %L49, label %L50
L49:
	store i1 1, i1* %ntb

	br label %L51
L50:
	%_375 = load i8*, i8** %parent_node
	%_376 = load i8*, i8** %current_node
	%_377 = bitcast i8* %this to i8***
	%_378 = load i8**, i8*** %_377
	%_379 = getelementptr i8*, i8** %_378, i32 14
	%_380 = load i8*, i8** %_379
	%_381 = bitcast i8* %_380 to i1 (i8*, i8*, i8*)*
	%_382 = call i1 %_381(i8* %this, i8* %_375, i8* %_376)
	store i1 %_382, i1* %ntb

	br label %L51
L51:

	br label %L38
L37:
	%_384 = load i8*, i8** %parent_node
	%_385 = load i8*, i8** %current_node
	%_386 = bitcast i8* %this to i8***
	%_387 = load i8**, i8*** %_386
	%_388 = getelementptr i8*, i8** %_387, i32 14
	%_389 = load i8*, i8** %_388
	%_390 = bitcast i8* %_389 to i1 (i8*, i8*, i8*)*
	%_391 = call i1 %_390(i8* %this, i8* %_384, i8* %_385)
	store i1 %_391, i1* %ntb

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

	%_393 = load i1, i1* %found
	ret i1 %_393
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32

	%_394 = load i8*, i8** %c_node
	%_395 = bitcast i8* %_394 to i8***
	%_396 = load i8**, i8*** %_395
	%_397 = getelementptr i8*, i8** %_396, i32 8
	%_398 = load i8*, i8** %_397
	%_399 = bitcast i8* %_398 to i1 (i8*)*
	%_400 = call i1 %_399(i8* %_394)
	br i1 %_400, label %L52, label %L53
L52:
	%_402 = load i8*, i8** %p_node
	%_403 = load i8*, i8** %c_node
	%_404 = bitcast i8* %this to i8***
	%_405 = load i8**, i8*** %_404
	%_406 = getelementptr i8*, i8** %_405, i32 16
	%_407 = load i8*, i8** %_406
	%_408 = bitcast i8* %_407 to i1 (i8*, i8*, i8*)*
	%_409 = call i1 %_408(i8* %this, i8* %_402, i8* %_403)
	store i1 %_409, i1* %ntb

	br label %L54
L53:
	%_411 = load i8*, i8** %c_node
	%_412 = bitcast i8* %_411 to i8***
	%_413 = load i8**, i8*** %_412
	%_414 = getelementptr i8*, i8** %_413, i32 7
	%_415 = load i8*, i8** %_414
	%_416 = bitcast i8* %_415 to i1 (i8*)*
	%_417 = call i1 %_416(i8* %_411)
	br i1 %_417, label %L55, label %L56
L55:
	%_419 = load i8*, i8** %p_node
	%_420 = load i8*, i8** %c_node
	%_421 = bitcast i8* %this to i8***
	%_422 = load i8**, i8*** %_421
	%_423 = getelementptr i8*, i8** %_422, i32 15
	%_424 = load i8*, i8** %_423
	%_425 = bitcast i8* %_424 to i1 (i8*, i8*, i8*)*
	%_426 = call i1 %_425(i8* %this, i8* %_419, i8* %_420)
	store i1 %_426, i1* %ntb

	br label %L57
L56:
	%_428 = load i8*, i8** %c_node
	%_429 = bitcast i8* %_428 to i8***
	%_430 = load i8**, i8*** %_429
	%_431 = getelementptr i8*, i8** %_430, i32 5
	%_432 = load i8*, i8** %_431
	%_433 = bitcast i8* %_432 to i32 (i8*)*
	%_434 = call i32 %_433(i8* %_428)
	store i32 %_434, i32* %auxkey1

	%_436 = load i8*, i8** %p_node
	%_437 = bitcast i8* %_436 to i8***
	%_438 = load i8**, i8*** %_437
	%_439 = getelementptr i8*, i8** %_438, i32 4
	%_440 = load i8*, i8** %_439
	%_441 = bitcast i8* %_440 to i8* (i8*)*
	%_442 = call i8* %_441(i8* %_436)
	%_444 = bitcast i8* %_442 to i8***
	%_445 = load i8**, i8*** %_444
	%_446 = getelementptr i8*, i8** %_445, i32 5
	%_447 = load i8*, i8** %_446
	%_448 = bitcast i8* %_447 to i32 (i8*)*
	%_449 = call i32 %_448(i8* %_442)
	store i32 %_449, i32* %auxkey2

	%_451 = load i32, i32* %auxkey1
	%_452 = load i32, i32* %auxkey2
	%_453 = bitcast i8* %this to i8***
	%_454 = load i8**, i8*** %_453
	%_455 = getelementptr i8*, i8** %_454, i32 11
	%_456 = load i8*, i8** %_455
	%_457 = bitcast i8* %_456 to i1 (i8*, i32, i32)*
	%_458 = call i1 %_457(i8* %this, i32 %_451, i32 %_452)
	br i1 %_458, label %L58, label %L59
L58:
	%_460 = load i8*, i8** %p_node
	%_462 = getelementptr i8, i8* %this, i32 30
	%_463 = bitcast i8* %_462 to i8**
	%_461 = load i8*, i8** %_463
	%_464 = bitcast i8* %_460 to i8***
	%_465 = load i8**, i8*** %_464
	%_466 = getelementptr i8*, i8** %_465, i32 2
	%_467 = load i8*, i8** %_466
	%_468 = bitcast i8* %_467 to i1 (i8*, i8*)*
	%_469 = call i1 %_468(i8* %_460, i8* %_461)
	store i1 %_469, i1* %ntb

	%_471 = load i8*, i8** %p_node
	%_472 = bitcast i8* %_471 to i8***
	%_473 = load i8**, i8*** %_472
	%_474 = getelementptr i8*, i8** %_473, i32 9
	%_475 = load i8*, i8** %_474
	%_476 = bitcast i8* %_475 to i1 (i8*, i1)*
	%_477 = call i1 %_476(i8* %_471, i1 0)
	store i1 %_477, i1* %ntb


	br label %L60
L59:
	%_479 = load i8*, i8** %p_node
	%_481 = getelementptr i8, i8* %this, i32 30
	%_482 = bitcast i8* %_481 to i8**
	%_480 = load i8*, i8** %_482
	%_483 = bitcast i8* %_479 to i8***
	%_484 = load i8**, i8*** %_483
	%_485 = getelementptr i8*, i8** %_484, i32 1
	%_486 = load i8*, i8** %_485
	%_487 = bitcast i8* %_486 to i1 (i8*, i8*)*
	%_488 = call i1 %_487(i8* %_479, i8* %_480)
	store i1 %_488, i1* %ntb

	%_490 = load i8*, i8** %p_node
	%_491 = bitcast i8* %_490 to i8***
	%_492 = load i8**, i8*** %_491
	%_493 = getelementptr i8*, i8** %_492, i32 10
	%_494 = load i8*, i8** %_493
	%_495 = bitcast i8* %_494 to i1 (i8*, i1)*
	%_496 = call i1 %_495(i8* %_490, i1 0)
	store i1 %_496, i1* %ntb


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
	%_498 = load i8*, i8** %c_node
	%_499 = bitcast i8* %_498 to i8***
	%_500 = load i8**, i8*** %_499
	%_501 = getelementptr i8*, i8** %_500, i32 7
	%_502 = load i8*, i8** %_501
	%_503 = bitcast i8* %_502 to i1 (i8*)*
	%_504 = call i1 %_503(i8* %_498)
	br i1 %_504, label %L62, label %L63
L62:
	%_506 = load i8*, i8** %c_node
	%_507 = load i8*, i8** %c_node
	%_508 = bitcast i8* %_507 to i8***
	%_509 = load i8**, i8*** %_508
	%_510 = getelementptr i8*, i8** %_509, i32 3
	%_511 = load i8*, i8** %_510
	%_512 = bitcast i8* %_511 to i8* (i8*)*
	%_513 = call i8* %_512(i8* %_507)
	%_515 = bitcast i8* %_513 to i8***
	%_516 = load i8**, i8*** %_515
	%_517 = getelementptr i8*, i8** %_516, i32 5
	%_518 = load i8*, i8** %_517
	%_519 = bitcast i8* %_518 to i32 (i8*)*
	%_520 = call i32 %_519(i8* %_513)
	%_522 = bitcast i8* %_506 to i8***
	%_523 = load i8**, i8*** %_522
	%_524 = getelementptr i8*, i8** %_523, i32 6
	%_525 = load i8*, i8** %_524
	%_526 = bitcast i8* %_525 to i1 (i8*, i32)*
	%_527 = call i1 %_526(i8* %_506, i32 %_520)
	store i1 %_527, i1* %ntb

	%_529 = load i8*, i8** %c_node
	store i8* %_529, i8** %p_node

	%_530 = load i8*, i8** %c_node
	%_531 = bitcast i8* %_530 to i8***
	%_532 = load i8**, i8*** %_531
	%_533 = getelementptr i8*, i8** %_532, i32 3
	%_534 = load i8*, i8** %_533
	%_535 = bitcast i8* %_534 to i8* (i8*)*
	%_536 = call i8* %_535(i8* %_530)
	store i8* %_536, i8** %c_node


	br label %L61
L63:

	%_538 = load i8*, i8** %p_node
	%_540 = getelementptr i8, i8* %this, i32 30
	%_541 = bitcast i8* %_540 to i8**
	%_539 = load i8*, i8** %_541
	%_542 = bitcast i8* %_538 to i8***
	%_543 = load i8**, i8*** %_542
	%_544 = getelementptr i8*, i8** %_543, i32 1
	%_545 = load i8*, i8** %_544
	%_546 = bitcast i8* %_545 to i1 (i8*, i8*)*
	%_547 = call i1 %_546(i8* %_538, i8* %_539)
	store i1 %_547, i1* %ntb

	%_549 = load i8*, i8** %p_node
	%_550 = bitcast i8* %_549 to i8***
	%_551 = load i8**, i8*** %_550
	%_552 = getelementptr i8*, i8** %_551, i32 10
	%_553 = load i8*, i8** %_552
	%_554 = bitcast i8* %_553 to i1 (i8*, i1)*
	%_555 = call i1 %_554(i8* %_549, i1 0)
	store i1 %_555, i1* %ntb

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
	%_557 = load i8*, i8** %c_node
	%_558 = bitcast i8* %_557 to i8***
	%_559 = load i8**, i8*** %_558
	%_560 = getelementptr i8*, i8** %_559, i32 8
	%_561 = load i8*, i8** %_560
	%_562 = bitcast i8* %_561 to i1 (i8*)*
	%_563 = call i1 %_562(i8* %_557)
	br i1 %_563, label %L65, label %L66
L65:
	%_565 = load i8*, i8** %c_node
	%_566 = load i8*, i8** %c_node
	%_567 = bitcast i8* %_566 to i8***
	%_568 = load i8**, i8*** %_567
	%_569 = getelementptr i8*, i8** %_568, i32 4
	%_570 = load i8*, i8** %_569
	%_571 = bitcast i8* %_570 to i8* (i8*)*
	%_572 = call i8* %_571(i8* %_566)
	%_574 = bitcast i8* %_572 to i8***
	%_575 = load i8**, i8*** %_574
	%_576 = getelementptr i8*, i8** %_575, i32 5
	%_577 = load i8*, i8** %_576
	%_578 = bitcast i8* %_577 to i32 (i8*)*
	%_579 = call i32 %_578(i8* %_572)
	%_581 = bitcast i8* %_565 to i8***
	%_582 = load i8**, i8*** %_581
	%_583 = getelementptr i8*, i8** %_582, i32 6
	%_584 = load i8*, i8** %_583
	%_585 = bitcast i8* %_584 to i1 (i8*, i32)*
	%_586 = call i1 %_585(i8* %_565, i32 %_579)
	store i1 %_586, i1* %ntb

	%_588 = load i8*, i8** %c_node
	store i8* %_588, i8** %p_node

	%_589 = load i8*, i8** %c_node
	%_590 = bitcast i8* %_589 to i8***
	%_591 = load i8**, i8*** %_590
	%_592 = getelementptr i8*, i8** %_591, i32 4
	%_593 = load i8*, i8** %_592
	%_594 = bitcast i8* %_593 to i8* (i8*)*
	%_595 = call i8* %_594(i8* %_589)
	store i8* %_595, i8** %c_node


	br label %L64
L66:

	%_597 = load i8*, i8** %p_node
	%_599 = getelementptr i8, i8* %this, i32 30
	%_600 = bitcast i8* %_599 to i8**
	%_598 = load i8*, i8** %_600
	%_601 = bitcast i8* %_597 to i8***
	%_602 = load i8**, i8*** %_601
	%_603 = getelementptr i8*, i8** %_602, i32 2
	%_604 = load i8*, i8** %_603
	%_605 = bitcast i8* %_604 to i1 (i8*, i8*)*
	%_606 = call i1 %_605(i8* %_597, i8* %_598)
	store i1 %_606, i1* %ntb

	%_608 = load i8*, i8** %p_node
	%_609 = bitcast i8* %_608 to i8***
	%_610 = load i8**, i8*** %_609
	%_611 = getelementptr i8*, i8** %_610, i32 9
	%_612 = load i8*, i8** %_611
	%_613 = bitcast i8* %_612 to i1 (i8*, i1)*
	%_614 = call i1 %_613(i8* %_608, i1 0)
	store i1 %_614, i1* %ntb

	ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	%ifound = alloca i32
	%cont = alloca i1
	%key_aux = alloca i32

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	store i32 0, i32* %ifound

	br label %L67
L67:
	%_616 = load i1, i1* %cont
	br i1 %_616, label %L68, label %L69
L68:
	%_617 = load i8*, i8** %current_node
	%_618 = bitcast i8* %_617 to i8***
	%_619 = load i8**, i8*** %_618
	%_620 = getelementptr i8*, i8** %_619, i32 5
	%_621 = load i8*, i8** %_620
	%_622 = bitcast i8* %_621 to i32 (i8*)*
	%_623 = call i32 %_622(i8* %_617)
	store i32 %_623, i32* %key_aux

	%_625 = load i32, i32* %v_key
	%_626 = load i32, i32* %key_aux
	%_627 = icmp slt i32 %_625, %_626
	br i1 %_627, label %L70, label %L71
L70:
	%_628 = load i8*, i8** %current_node
	%_629 = bitcast i8* %_628 to i8***
	%_630 = load i8**, i8*** %_629
	%_631 = getelementptr i8*, i8** %_630, i32 8
	%_632 = load i8*, i8** %_631
	%_633 = bitcast i8* %_632 to i1 (i8*)*
	%_634 = call i1 %_633(i8* %_628)
	br i1 %_634, label %L73, label %L74
L73:
	%_636 = load i8*, i8** %current_node
	%_637 = bitcast i8* %_636 to i8***
	%_638 = load i8**, i8*** %_637
	%_639 = getelementptr i8*, i8** %_638, i32 4
	%_640 = load i8*, i8** %_639
	%_641 = bitcast i8* %_640 to i8* (i8*)*
	%_642 = call i8* %_641(i8* %_636)
	store i8* %_642, i8** %current_node

	br label %L75
L74:
	store i1 0, i1* %cont

	br label %L75
L75:

	br label %L72
L71:
	%_644 = load i32, i32* %key_aux
	%_645 = load i32, i32* %v_key
	%_646 = icmp slt i32 %_644, %_645
	br i1 %_646, label %L76, label %L77
L76:
	%_647 = load i8*, i8** %current_node
	%_648 = bitcast i8* %_647 to i8***
	%_649 = load i8**, i8*** %_648
	%_650 = getelementptr i8*, i8** %_649, i32 7
	%_651 = load i8*, i8** %_650
	%_652 = bitcast i8* %_651 to i1 (i8*)*
	%_653 = call i1 %_652(i8* %_647)
	br i1 %_653, label %L79, label %L80
L79:
	%_655 = load i8*, i8** %current_node
	%_656 = bitcast i8* %_655 to i8***
	%_657 = load i8**, i8*** %_656
	%_658 = getelementptr i8*, i8** %_657, i32 3
	%_659 = load i8*, i8** %_658
	%_660 = bitcast i8* %_659 to i8* (i8*)*
	%_661 = call i8* %_660(i8* %_655)
	store i8* %_661, i8** %current_node

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

	%_663 = load i32, i32* %ifound
	ret i32 %_663
}

define i1 @Tree.Print(i8* %this) {
	%ntb = alloca i1
	%current_node = alloca i8*

	store i8* %this, i8** %current_node

	%_664 = load i8*, i8** %current_node
	%_665 = bitcast i8* %this to i8***
	%_666 = load i8**, i8*** %_665
	%_667 = getelementptr i8*, i8** %_666, i32 19
	%_668 = load i8*, i8** %_667
	%_669 = bitcast i8* %_668 to i1 (i8*, i8*)*
	%_670 = call i1 %_669(i8* %this, i8* %_664)
	store i1 %_670, i1* %ntb

	ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1

	%_672 = load i8*, i8** %node
	%_673 = bitcast i8* %_672 to i8***
	%_674 = load i8**, i8*** %_673
	%_675 = getelementptr i8*, i8** %_674, i32 8
	%_676 = load i8*, i8** %_675
	%_677 = bitcast i8* %_676 to i1 (i8*)*
	%_678 = call i1 %_677(i8* %_672)
	br i1 %_678, label %L82, label %L83
L82:
	%_680 = load i8*, i8** %node
	%_681 = bitcast i8* %_680 to i8***
	%_682 = load i8**, i8*** %_681
	%_683 = getelementptr i8*, i8** %_682, i32 4
	%_684 = load i8*, i8** %_683
	%_685 = bitcast i8* %_684 to i8* (i8*)*
	%_686 = call i8* %_685(i8* %_680)
	%_688 = bitcast i8* %this to i8***
	%_689 = load i8**, i8*** %_688
	%_690 = getelementptr i8*, i8** %_689, i32 19
	%_691 = load i8*, i8** %_690
	%_692 = bitcast i8* %_691 to i1 (i8*, i8*)*
	%_693 = call i1 %_692(i8* %this, i8* %_686)
	store i1 %_693, i1* %ntb


	br label %L84
L83:
	store i1 1, i1* %ntb

	br label %L84
L84:

	%_695 = load i8*, i8** %node
	%_696 = bitcast i8* %_695 to i8***
	%_697 = load i8**, i8*** %_696
	%_698 = getelementptr i8*, i8** %_697, i32 5
	%_699 = load i8*, i8** %_698
	%_700 = bitcast i8* %_699 to i32 (i8*)*
	%_701 = call i32 %_700(i8* %_695)
	call void (i32) @print_int(i32 %_701)

	%_703 = load i8*, i8** %node
	%_704 = bitcast i8* %_703 to i8***
	%_705 = load i8**, i8*** %_704
	%_706 = getelementptr i8*, i8** %_705, i32 7
	%_707 = load i8*, i8** %_706
	%_708 = bitcast i8* %_707 to i1 (i8*)*
	%_709 = call i1 %_708(i8* %_703)
	br i1 %_709, label %L85, label %L86
L85:
	%_711 = load i8*, i8** %node
	%_712 = bitcast i8* %_711 to i8***
	%_713 = load i8**, i8*** %_712
	%_714 = getelementptr i8*, i8** %_713, i32 3
	%_715 = load i8*, i8** %_714
	%_716 = bitcast i8* %_715 to i8* (i8*)*
	%_717 = call i8* %_716(i8* %_711)
	%_719 = bitcast i8* %this to i8***
	%_720 = load i8**, i8*** %_719
	%_721 = getelementptr i8*, i8** %_720, i32 19
	%_722 = load i8*, i8** %_721
	%_723 = bitcast i8* %_722 to i1 (i8*, i8*)*
	%_724 = call i1 %_723(i8* %this, i8* %_717)
	store i1 %_724, i1* %ntb


	br label %L87
L86:
	store i1 1, i1* %ntb

	br label %L87
L87:

	ret i1 1
}

define i32 @Tree.accept(i8* %this, i8* %.v) {
	%v = alloca i8*
	store i8* %.v, i8** %v
	%nti = alloca i32

	call void (i32) @print_int(i32 333)

	%_726 = load i8*, i8** %v
	%_727 = bitcast i8* %_726 to i8***
	%_728 = load i8**, i8*** %_727
	%_729 = getelementptr i8*, i8** %_728, i32 0
	%_730 = load i8*, i8** %_729
	%_731 = bitcast i8* %_730 to i32 (i8*, i8*)*
	%_732 = call i32 %_731(i8* %_726, i8* %this)
	store i32 %_732, i32* %nti

	ret i32 0
}

define i32 @Visitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32

	%_734 = load i8*, i8** %n
	%_735 = bitcast i8* %_734 to i8***
	%_736 = load i8**, i8*** %_735
	%_737 = getelementptr i8*, i8** %_736, i32 7
	%_738 = load i8*, i8** %_737
	%_739 = bitcast i8* %_738 to i1 (i8*)*
	%_740 = call i1 %_739(i8* %_734)
	br i1 %_740, label %L88, label %L89
L88:
	%_742 = load i8*, i8** %n
	%_743 = bitcast i8* %_742 to i8***
	%_744 = load i8**, i8*** %_743
	%_745 = getelementptr i8*, i8** %_744, i32 3
	%_746 = load i8*, i8** %_745
	%_747 = bitcast i8* %_746 to i8* (i8*)*
	%_748 = call i8* %_747(i8* %_742)
	%_750 = getelementptr i8, i8* %this, i32 16
	%_751 = bitcast i8* %_750 to i8**
	store i8* %_748, i8** %_751

	%_753 = getelementptr i8, i8* %this, i32 16
	%_754 = bitcast i8* %_753 to i8**
	%_752 = load i8*, i8** %_754
	%_755 = bitcast i8* %_752 to i8***
	%_756 = load i8**, i8*** %_755
	%_757 = getelementptr i8*, i8** %_756, i32 20
	%_758 = load i8*, i8** %_757
	%_759 = bitcast i8* %_758 to i32 (i8*, i8*)*
	%_760 = call i32 %_759(i8* %_752, i8* %this)
	store i32 %_760, i32* %nti


	br label %L90
L89:
	store i32 0, i32* %nti

	br label %L90
L90:

	%_762 = load i8*, i8** %n
	%_763 = bitcast i8* %_762 to i8***
	%_764 = load i8**, i8*** %_763
	%_765 = getelementptr i8*, i8** %_764, i32 8
	%_766 = load i8*, i8** %_765
	%_767 = bitcast i8* %_766 to i1 (i8*)*
	%_768 = call i1 %_767(i8* %_762)
	br i1 %_768, label %L91, label %L92
L91:
	%_770 = load i8*, i8** %n
	%_771 = bitcast i8* %_770 to i8***
	%_772 = load i8**, i8*** %_771
	%_773 = getelementptr i8*, i8** %_772, i32 4
	%_774 = load i8*, i8** %_773
	%_775 = bitcast i8* %_774 to i8* (i8*)*
	%_776 = call i8* %_775(i8* %_770)
	%_778 = getelementptr i8, i8* %this, i32 8
	%_779 = bitcast i8* %_778 to i8**
	store i8* %_776, i8** %_779

	%_781 = getelementptr i8, i8* %this, i32 8
	%_782 = bitcast i8* %_781 to i8**
	%_780 = load i8*, i8** %_782
	%_783 = bitcast i8* %_780 to i8***
	%_784 = load i8**, i8*** %_783
	%_785 = getelementptr i8*, i8** %_784, i32 20
	%_786 = load i8*, i8** %_785
	%_787 = bitcast i8* %_786 to i32 (i8*, i8*)*
	%_788 = call i32 %_787(i8* %_780, i8* %this)
	store i32 %_788, i32* %nti


	br label %L93
L92:
	store i32 0, i32* %nti

	br label %L93
L93:

	ret i32 0
}

define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32

	%_790 = load i8*, i8** %n
	%_791 = bitcast i8* %_790 to i8***
	%_792 = load i8**, i8*** %_791
	%_793 = getelementptr i8*, i8** %_792, i32 7
	%_794 = load i8*, i8** %_793
	%_795 = bitcast i8* %_794 to i1 (i8*)*
	%_796 = call i1 %_795(i8* %_790)
	br i1 %_796, label %L94, label %L95
L94:
	%_798 = load i8*, i8** %n
	%_799 = bitcast i8* %_798 to i8***
	%_800 = load i8**, i8*** %_799
	%_801 = getelementptr i8*, i8** %_800, i32 3
	%_802 = load i8*, i8** %_801
	%_803 = bitcast i8* %_802 to i8* (i8*)*
	%_804 = call i8* %_803(i8* %_798)
	%_806 = getelementptr i8, i8* %this, i32 16
	%_807 = bitcast i8* %_806 to i8**
	store i8* %_804, i8** %_807

	%_809 = getelementptr i8, i8* %this, i32 16
	%_810 = bitcast i8* %_809 to i8**
	%_808 = load i8*, i8** %_810
	%_811 = bitcast i8* %_808 to i8***
	%_812 = load i8**, i8*** %_811
	%_813 = getelementptr i8*, i8** %_812, i32 20
	%_814 = load i8*, i8** %_813
	%_815 = bitcast i8* %_814 to i32 (i8*, i8*)*
	%_816 = call i32 %_815(i8* %_808, i8* %this)
	store i32 %_816, i32* %nti


	br label %L96
L95:
	store i32 0, i32* %nti

	br label %L96
L96:

	%_818 = load i8*, i8** %n
	%_819 = bitcast i8* %_818 to i8***
	%_820 = load i8**, i8*** %_819
	%_821 = getelementptr i8*, i8** %_820, i32 5
	%_822 = load i8*, i8** %_821
	%_823 = bitcast i8* %_822 to i32 (i8*)*
	%_824 = call i32 %_823(i8* %_818)
	call void (i32) @print_int(i32 %_824)

	%_826 = load i8*, i8** %n
	%_827 = bitcast i8* %_826 to i8***
	%_828 = load i8**, i8*** %_827
	%_829 = getelementptr i8*, i8** %_828, i32 8
	%_830 = load i8*, i8** %_829
	%_831 = bitcast i8* %_830 to i1 (i8*)*
	%_832 = call i1 %_831(i8* %_826)
	br i1 %_832, label %L97, label %L98
L97:
	%_834 = load i8*, i8** %n
	%_835 = bitcast i8* %_834 to i8***
	%_836 = load i8**, i8*** %_835
	%_837 = getelementptr i8*, i8** %_836, i32 4
	%_838 = load i8*, i8** %_837
	%_839 = bitcast i8* %_838 to i8* (i8*)*
	%_840 = call i8* %_839(i8* %_834)
	%_842 = getelementptr i8, i8* %this, i32 8
	%_843 = bitcast i8* %_842 to i8**
	store i8* %_840, i8** %_843

	%_845 = getelementptr i8, i8* %this, i32 8
	%_846 = bitcast i8* %_845 to i8**
	%_844 = load i8*, i8** %_846
	%_847 = bitcast i8* %_844 to i8***
	%_848 = load i8**, i8*** %_847
	%_849 = getelementptr i8*, i8** %_848, i32 20
	%_850 = load i8*, i8** %_849
	%_851 = bitcast i8* %_850 to i32 (i8*, i8*)*
	%_852 = call i32 %_851(i8* %_844, i8* %this)
	store i32 %_852, i32* %nti


	br label %L99
L98:
	store i32 0, i32* %nti

	br label %L99
L99:

	ret i32 0
}

