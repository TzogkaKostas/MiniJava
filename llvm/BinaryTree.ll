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
	%_0 = call i8* @calloc(i32 1, i32 8)
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
	%_10 = call i8* @calloc(i32 1, i32 30)
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
	%_24 = getelementptr i8*, i8** %_23, i32 144
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i1 (i8*)*
	%_27 = call i1 %_26(i8* %_21)
	store i1 %_27, i1* %ntb

	ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_29 = load i32, i32* %v_key
	%_30 = getelementptr i8, i8* %this, i32 16
	%_31 = bitcast i8* %_30 to i32*
	store i32 %_29, i32* %_31

	%_32 = getelementptr i8, i8* %this, i32 20
	%_33 = bitcast i8* %_32 to i1*
	store i1 0, i1* %_33

	%_34 = getelementptr i8, i8* %this, i32 21
	%_35 = bitcast i8* %_34 to i1*
	store i1 0, i1* %_35

	ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_36 = load i8*, i8** %rn
	%_37 = getelementptr i8, i8* %this, i32 8
	%_38 = bitcast i8* %_37 to i8**
	store i8* %_36, i8** %_38

	ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_39 = load i8*, i8** %ln
	%_40 = getelementptr i8, i8* %this, i32 0
	%_41 = bitcast i8* %_40 to i8**
	store i8* %_39, i8** %_41

	ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
	%_43 = getelementptr i8, i8* %this, i32 8
	%_44 = bitcast i8* %_43 to i8**
	%_42 = load i8*, i8** %_44
	ret i8* %_42
}

define i8* @Tree.GetLeft(i8* %this) {
	%_46 = getelementptr i8, i8* %this, i32 0
	%_47 = bitcast i8* %_46 to i8**
	%_45 = load i8*, i8** %_47
	ret i8* %_45
}

define i32 @Tree.GetKey(i8* %this) {
	%_49 = getelementptr i8, i8* %this, i32 16
	%_50 = bitcast i8* %_49 to i32*
	%_48 = load i32, i32* %_50
	ret i32 %_48
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_51 = load i32, i32* %v_key
	%_52 = getelementptr i8, i8* %this, i32 16
	%_53 = bitcast i8* %_52 to i32*
	store i32 %_51, i32* %_53

	ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
	%_55 = getelementptr i8, i8* %this, i32 21
	%_56 = bitcast i8* %_55 to i1*
	%_54 = load i1, i1* %_56
	ret i1 %_54
}

define i1 @Tree.GetHas_Left(i8* %this) {
	%_58 = getelementptr i8, i8* %this, i32 20
	%_59 = bitcast i8* %_58 to i1*
	%_57 = load i1, i1* %_59
	ret i1 %_57
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_60 = load i1, i1* %val
	%_61 = getelementptr i8, i8* %this, i32 20
	%_62 = bitcast i8* %_61 to i1*
	store i1 %_60, i1* %_62

	ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_63 = load i1, i1* %val
	%_64 = getelementptr i8, i8* %this, i32 21
	%_65 = bitcast i8* %_64 to i1*
	store i1 %_63, i1* %_65

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

	%_66 = load i32, i32* %num2
	%_67 = add i32 %_66, 1
	store i32 %_67, i32* %nti

	%_68 = load i32, i32* %num1
	%_69 = load i32, i32* %num2
	%_70 = icmp slt i32 %_68, %_69
	br i1 %_70, label %L0, label %L1
L0:
	store i1 0, i1* %ntb

	br label %L2
L1:
	%_71 = load i32, i32* %num1
	%_72 = load i32, i32* %nti
	%_73 = icmp slt i32 %_71, %_72
	br i1 %_73, label %L3, label %L4
L3:
	br label %L5
L4:
	br label %L5
L5:
	%_74 = phi i1 [0, %L3], [1, %L4]
	br i1 %_74, label %L6, label %L7
L6:
	store i1 0, i1* %ntb

	br label %L8
L7:
	store i1 1, i1* %ntb

	br label %L8
L8:

	br label %L2
L2:

	%_75 = load i1, i1* %ntb
	ret i1 %_75
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca i8*
	%_76 = call i8* @calloc(i32 1, i32 30)
	%_77 = bitcast i8* %_76 to i8***
	%_78 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_78, i8*** %_77
	store i8* %_76, i8** %new_node

	%_79 = load i8*, i8** %new_node
	%_80 = load i32, i32* %v_key
	%_81 = bitcast i8* %_79 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 0
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*, i32)*
	%_86 = call i1 %_85(i8* %_79, i32 %_80)
	store i1 %_86, i1* %ntb

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	br label %L9
L9:
	%_88 = load i1, i1* %cont
	br i1 %_88, label %L10, label %L11
L10:
	%_89 = load i8*, i8** %current_node
	%_90 = bitcast i8* %_89 to i8***
	%_91 = load i8**, i8*** %_90
	%_92 = getelementptr i8*, i8** %_91, i32 40
	%_93 = load i8*, i8** %_92
	%_94 = bitcast i8* %_93 to i32 (i8*)*
	%_95 = call i32 %_94(i8* %_89)
	store i32 %_95, i32* %key_aux

	%_97 = load i32, i32* %v_key
	%_98 = load i32, i32* %key_aux
	%_99 = icmp slt i32 %_97, %_98
	br i1 %_99, label %L12, label %L13
L12:
	%_100 = load i8*, i8** %current_node
	%_101 = bitcast i8* %_100 to i8***
	%_102 = load i8**, i8*** %_101
	%_103 = getelementptr i8*, i8** %_102, i32 64
	%_104 = load i8*, i8** %_103
	%_105 = bitcast i8* %_104 to i1 (i8*)*
	%_106 = call i1 %_105(i8* %_100)
	br i1 %_106, label %L15, label %L16
L15:
	%_108 = load i8*, i8** %current_node
	%_109 = bitcast i8* %_108 to i8***
	%_110 = load i8**, i8*** %_109
	%_111 = getelementptr i8*, i8** %_110, i32 32
	%_112 = load i8*, i8** %_111
	%_113 = bitcast i8* %_112 to i8* (i8*)*
	%_114 = call i8* %_113(i8* %_108)
	store i8* %_114, i8** %current_node

	br label %L17
L16:
	store i1 0, i1* %cont

	%_116 = load i8*, i8** %current_node
	%_117 = bitcast i8* %_116 to i8***
	%_118 = load i8**, i8*** %_117
	%_119 = getelementptr i8*, i8** %_118, i32 72
	%_120 = load i8*, i8** %_119
	%_121 = bitcast i8* %_120 to i1 (i8*, i1)*
	%_122 = call i1 %_121(i8* %_116, i1 1)
	store i1 %_122, i1* %ntb

	%_124 = load i8*, i8** %current_node
	%_125 = load i8*, i8** %new_node
	%_126 = bitcast i8* %_124 to i8***
	%_127 = load i8**, i8*** %_126
	%_128 = getelementptr i8*, i8** %_127, i32 16
	%_129 = load i8*, i8** %_128
	%_130 = bitcast i8* %_129 to i1 (i8*, i8*)*
	%_131 = call i1 %_130(i8* %_124, i8* %_125)
	store i1 %_131, i1* %ntb


	br label %L17
L17:


	br label %L14
L13:
	%_133 = load i8*, i8** %current_node
	%_134 = bitcast i8* %_133 to i8***
	%_135 = load i8**, i8*** %_134
	%_136 = getelementptr i8*, i8** %_135, i32 56
	%_137 = load i8*, i8** %_136
	%_138 = bitcast i8* %_137 to i1 (i8*)*
	%_139 = call i1 %_138(i8* %_133)
	br i1 %_139, label %L18, label %L19
L18:
	%_141 = load i8*, i8** %current_node
	%_142 = bitcast i8* %_141 to i8***
	%_143 = load i8**, i8*** %_142
	%_144 = getelementptr i8*, i8** %_143, i32 24
	%_145 = load i8*, i8** %_144
	%_146 = bitcast i8* %_145 to i8* (i8*)*
	%_147 = call i8* %_146(i8* %_141)
	store i8* %_147, i8** %current_node

	br label %L20
L19:
	store i1 0, i1* %cont

	%_149 = load i8*, i8** %current_node
	%_150 = bitcast i8* %_149 to i8***
	%_151 = load i8**, i8*** %_150
	%_152 = getelementptr i8*, i8** %_151, i32 80
	%_153 = load i8*, i8** %_152
	%_154 = bitcast i8* %_153 to i1 (i8*, i1)*
	%_155 = call i1 %_154(i8* %_149, i1 1)
	store i1 %_155, i1* %ntb

	%_157 = load i8*, i8** %current_node
	%_158 = load i8*, i8** %new_node
	%_159 = bitcast i8* %_157 to i8***
	%_160 = load i8**, i8*** %_159
	%_161 = getelementptr i8*, i8** %_160, i32 8
	%_162 = load i8*, i8** %_161
	%_163 = bitcast i8* %_162 to i1 (i8*, i8*)*
	%_164 = call i1 %_163(i8* %_157, i8* %_158)
	store i1 %_164, i1* %ntb


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
	%_166 = load i1, i1* %cont
	br i1 %_166, label %L22, label %L23
L22:
	%_167 = load i8*, i8** %current_node
	%_168 = bitcast i8* %_167 to i8***
	%_169 = load i8**, i8*** %_168
	%_170 = getelementptr i8*, i8** %_169, i32 40
	%_171 = load i8*, i8** %_170
	%_172 = bitcast i8* %_171 to i32 (i8*)*
	%_173 = call i32 %_172(i8* %_167)
	store i32 %_173, i32* %key_aux

	%_175 = load i32, i32* %v_key
	%_176 = load i32, i32* %key_aux
	%_177 = icmp slt i32 %_175, %_176
	br i1 %_177, label %L24, label %L25
L24:
	%_178 = load i8*, i8** %current_node
	%_179 = bitcast i8* %_178 to i8***
	%_180 = load i8**, i8*** %_179
	%_181 = getelementptr i8*, i8** %_180, i32 64
	%_182 = load i8*, i8** %_181
	%_183 = bitcast i8* %_182 to i1 (i8*)*
	%_184 = call i1 %_183(i8* %_178)
	br i1 %_184, label %L27, label %L28
L27:
	%_186 = load i8*, i8** %current_node
	store i8* %_186, i8** %parent_node

	%_187 = load i8*, i8** %current_node
	%_188 = bitcast i8* %_187 to i8***
	%_189 = load i8**, i8*** %_188
	%_190 = getelementptr i8*, i8** %_189, i32 32
	%_191 = load i8*, i8** %_190
	%_192 = bitcast i8* %_191 to i8* (i8*)*
	%_193 = call i8* %_192(i8* %_187)
	store i8* %_193, i8** %current_node


	br label %L29
L28:
	store i1 0, i1* %cont

	br label %L29
L29:

	br label %L26
L25:
	%_195 = load i32, i32* %key_aux
	%_196 = load i32, i32* %v_key
	%_197 = icmp slt i32 %_195, %_196
	br i1 %_197, label %L30, label %L31
L30:
	%_198 = load i8*, i8** %current_node
	%_199 = bitcast i8* %_198 to i8***
	%_200 = load i8**, i8*** %_199
	%_201 = getelementptr i8*, i8** %_200, i32 56
	%_202 = load i8*, i8** %_201
	%_203 = bitcast i8* %_202 to i1 (i8*)*
	%_204 = call i1 %_203(i8* %_198)
	br i1 %_204, label %L33, label %L34
L33:
	%_206 = load i8*, i8** %current_node
	store i8* %_206, i8** %parent_node

	%_207 = load i8*, i8** %current_node
	%_208 = bitcast i8* %_207 to i8***
	%_209 = load i8**, i8*** %_208
	%_210 = getelementptr i8*, i8** %_209, i32 24
	%_211 = load i8*, i8** %_210
	%_212 = bitcast i8* %_211 to i8* (i8*)*
	%_213 = call i8* %_212(i8* %_207)
	store i8* %_213, i8** %current_node


	br label %L35
L34:
	store i1 0, i1* %cont

	br label %L35
L35:

	br label %L32
L31:
	%_215 = load i1, i1* %is_root
	br i1 %_215, label %L36, label %L37
L36:
	%_216 = load i8*, i8** %current_node
	%_217 = bitcast i8* %_216 to i8***
	%_218 = load i8**, i8*** %_217
	%_219 = getelementptr i8*, i8** %_218, i32 56
	%_220 = load i8*, i8** %_219
	%_221 = bitcast i8* %_220 to i1 (i8*)*
	%_222 = call i1 %_221(i8* %_216)
	br i1 %_222, label %L39, label %L40
L39:
	br label %L41
L40:
	br label %L41
L41:
	%_224 = phi i1 [0, %L39], [1, %L40]
	br i1 %_224, label %L46, label %L45
L45:
	br label %L48
L46:
	%_225 = load i8*, i8** %current_node
	%_226 = bitcast i8* %_225 to i8***
	%_227 = load i8**, i8*** %_226
	%_228 = getelementptr i8*, i8** %_227, i32 64
	%_229 = load i8*, i8** %_228
	%_230 = bitcast i8* %_229 to i1 (i8*)*
	%_231 = call i1 %_230(i8* %_225)
	br i1 %_231, label %L42, label %L43
L42:
	br label %L44
L43:
	br label %L44
L44:
	%_233 = phi i1 [0, %L42], [1, %L43]
	br label %L47
L47:
	br label %L48
L48:
	%_234 = phi i1 [0, %L45], [%_233, %L47]
	br i1 %_234, label %L49, label %L50
L49:
	store i1 1, i1* %ntb

	br label %L51
L50:
	%_235 = load i8*, i8** %parent_node
	%_236 = load i8*, i8** %current_node
	%_237 = bitcast i8* %this to i8***
	%_238 = load i8**, i8*** %_237
	%_239 = getelementptr i8*, i8** %_238, i32 112
	%_240 = load i8*, i8** %_239
	%_241 = bitcast i8* %_240 to i1 (i8*, i8*, i8*)*
	%_242 = call i1 %_241(i8* %this, i8* %_235, i8* %_236)
	store i1 %_242, i1* %ntb

	br label %L51
L51:

	br label %L38
L37:
	%_244 = load i8*, i8** %parent_node
	%_245 = load i8*, i8** %current_node
	%_246 = bitcast i8* %this to i8***
	%_247 = load i8**, i8*** %_246
	%_248 = getelementptr i8*, i8** %_247, i32 112
	%_249 = load i8*, i8** %_248
	%_250 = bitcast i8* %_249 to i1 (i8*, i8*, i8*)*
	%_251 = call i1 %_250(i8* %this, i8* %_244, i8* %_245)
	store i1 %_251, i1* %ntb

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

	%_253 = load i1, i1* %found
	ret i1 %_253
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_254 = load i8*, i8** %c_node
	%_255 = bitcast i8* %_254 to i8***
	%_256 = load i8**, i8*** %_255
	%_257 = getelementptr i8*, i8** %_256, i32 64
	%_258 = load i8*, i8** %_257
	%_259 = bitcast i8* %_258 to i1 (i8*)*
	%_260 = call i1 %_259(i8* %_254)
	br i1 %_260, label %L52, label %L53
L52:
	%_262 = load i8*, i8** %p_node
	%_263 = load i8*, i8** %c_node
	%_264 = bitcast i8* %this to i8***
	%_265 = load i8**, i8*** %_264
	%_266 = getelementptr i8*, i8** %_265, i32 128
	%_267 = load i8*, i8** %_266
	%_268 = bitcast i8* %_267 to i1 (i8*, i8*, i8*)*
	%_269 = call i1 %_268(i8* %this, i8* %_262, i8* %_263)
	store i1 %_269, i1* %ntb

	br label %L54
L53:
	%_271 = load i8*, i8** %c_node
	%_272 = bitcast i8* %_271 to i8***
	%_273 = load i8**, i8*** %_272
	%_274 = getelementptr i8*, i8** %_273, i32 56
	%_275 = load i8*, i8** %_274
	%_276 = bitcast i8* %_275 to i1 (i8*)*
	%_277 = call i1 %_276(i8* %_271)
	br i1 %_277, label %L55, label %L56
L55:
	%_279 = load i8*, i8** %p_node
	%_280 = load i8*, i8** %c_node
	%_281 = bitcast i8* %this to i8***
	%_282 = load i8**, i8*** %_281
	%_283 = getelementptr i8*, i8** %_282, i32 120
	%_284 = load i8*, i8** %_283
	%_285 = bitcast i8* %_284 to i1 (i8*, i8*, i8*)*
	%_286 = call i1 %_285(i8* %this, i8* %_279, i8* %_280)
	store i1 %_286, i1* %ntb

	br label %L57
L56:
	%_288 = load i8*, i8** %c_node
	%_289 = bitcast i8* %_288 to i8***
	%_290 = load i8**, i8*** %_289
	%_291 = getelementptr i8*, i8** %_290, i32 40
	%_292 = load i8*, i8** %_291
	%_293 = bitcast i8* %_292 to i32 (i8*)*
	%_294 = call i32 %_293(i8* %_288)
	store i32 %_294, i32* %auxkey1

	%_296 = load i8*, i8** %p_node
	%_297 = bitcast i8* %_296 to i8***
	%_298 = load i8**, i8*** %_297
	%_299 = getelementptr i8*, i8** %_298, i32 32
	%_300 = load i8*, i8** %_299
	%_301 = bitcast i8* %_300 to i8* (i8*)*
	%_302 = call i8* %_301(i8* %_296)
	%_304 = bitcast i8* %_302 to i8***
	%_305 = load i8**, i8*** %_304
	%_306 = getelementptr i8*, i8** %_305, i32 40
	%_307 = load i8*, i8** %_306
	%_308 = bitcast i8* %_307 to i32 (i8*)*
	%_309 = call i32 %_308(i8* %_302)
	store i32 %_309, i32* %auxkey2

	%_311 = load i32, i32* %auxkey1
	%_312 = load i32, i32* %auxkey2
	%_313 = bitcast i8* %this to i8***
	%_314 = load i8**, i8*** %_313
	%_315 = getelementptr i8*, i8** %_314, i32 88
	%_316 = load i8*, i8** %_315
	%_317 = bitcast i8* %_316 to i1 (i8*, i32, i32)*
	%_318 = call i1 %_317(i8* %this, i32 %_311, i32 %_312)
	br i1 %_318, label %L58, label %L59
L58:
	%_320 = load i8*, i8** %p_node
	%_322 = getelementptr i8, i8* %this, i32 22
	%_323 = bitcast i8* %_322 to i8**
	%_321 = load i8*, i8** %_323
	%_324 = bitcast i8* %_320 to i8***
	%_325 = load i8**, i8*** %_324
	%_326 = getelementptr i8*, i8** %_325, i32 16
	%_327 = load i8*, i8** %_326
	%_328 = bitcast i8* %_327 to i1 (i8*, i8*)*
	%_329 = call i1 %_328(i8* %_320, i8* %_321)
	store i1 %_329, i1* %ntb

	%_331 = load i8*, i8** %p_node
	%_332 = bitcast i8* %_331 to i8***
	%_333 = load i8**, i8*** %_332
	%_334 = getelementptr i8*, i8** %_333, i32 72
	%_335 = load i8*, i8** %_334
	%_336 = bitcast i8* %_335 to i1 (i8*, i1)*
	%_337 = call i1 %_336(i8* %_331, i1 0)
	store i1 %_337, i1* %ntb


	br label %L60
L59:
	%_339 = load i8*, i8** %p_node
	%_341 = getelementptr i8, i8* %this, i32 22
	%_342 = bitcast i8* %_341 to i8**
	%_340 = load i8*, i8** %_342
	%_343 = bitcast i8* %_339 to i8***
	%_344 = load i8**, i8*** %_343
	%_345 = getelementptr i8*, i8** %_344, i32 8
	%_346 = load i8*, i8** %_345
	%_347 = bitcast i8* %_346 to i1 (i8*, i8*)*
	%_348 = call i1 %_347(i8* %_339, i8* %_340)
	store i1 %_348, i1* %ntb

	%_350 = load i8*, i8** %p_node
	%_351 = bitcast i8* %_350 to i8***
	%_352 = load i8**, i8*** %_351
	%_353 = getelementptr i8*, i8** %_352, i32 80
	%_354 = load i8*, i8** %_353
	%_355 = bitcast i8* %_354 to i1 (i8*, i1)*
	%_356 = call i1 %_355(i8* %_350, i1 0)
	store i1 %_356, i1* %ntb


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
	%_358 = load i8*, i8** %c_node
	%_359 = bitcast i8* %_358 to i8***
	%_360 = load i8**, i8*** %_359
	%_361 = getelementptr i8*, i8** %_360, i32 56
	%_362 = load i8*, i8** %_361
	%_363 = bitcast i8* %_362 to i1 (i8*)*
	%_364 = call i1 %_363(i8* %_358)
	br i1 %_364, label %L62, label %L63
L62:
	%_366 = load i8*, i8** %c_node
	%_367 = load i8*, i8** %c_node
	%_368 = bitcast i8* %_367 to i8***
	%_369 = load i8**, i8*** %_368
	%_370 = getelementptr i8*, i8** %_369, i32 24
	%_371 = load i8*, i8** %_370
	%_372 = bitcast i8* %_371 to i8* (i8*)*
	%_373 = call i8* %_372(i8* %_367)
	%_375 = bitcast i8* %_373 to i8***
	%_376 = load i8**, i8*** %_375
	%_377 = getelementptr i8*, i8** %_376, i32 40
	%_378 = load i8*, i8** %_377
	%_379 = bitcast i8* %_378 to i32 (i8*)*
	%_380 = call i32 %_379(i8* %_373)
	%_382 = bitcast i8* %_366 to i8***
	%_383 = load i8**, i8*** %_382
	%_384 = getelementptr i8*, i8** %_383, i32 48
	%_385 = load i8*, i8** %_384
	%_386 = bitcast i8* %_385 to i1 (i8*, i32)*
	%_387 = call i1 %_386(i8* %_366, i32 %_380)
	store i1 %_387, i1* %ntb

	%_389 = load i8*, i8** %c_node
	store i8* %_389, i8** %p_node

	%_390 = load i8*, i8** %c_node
	%_391 = bitcast i8* %_390 to i8***
	%_392 = load i8**, i8*** %_391
	%_393 = getelementptr i8*, i8** %_392, i32 24
	%_394 = load i8*, i8** %_393
	%_395 = bitcast i8* %_394 to i8* (i8*)*
	%_396 = call i8* %_395(i8* %_390)
	store i8* %_396, i8** %c_node


	br label %L61
L63:

	%_398 = load i8*, i8** %p_node
	%_400 = getelementptr i8, i8* %this, i32 22
	%_401 = bitcast i8* %_400 to i8**
	%_399 = load i8*, i8** %_401
	%_402 = bitcast i8* %_398 to i8***
	%_403 = load i8**, i8*** %_402
	%_404 = getelementptr i8*, i8** %_403, i32 8
	%_405 = load i8*, i8** %_404
	%_406 = bitcast i8* %_405 to i1 (i8*, i8*)*
	%_407 = call i1 %_406(i8* %_398, i8* %_399)
	store i1 %_407, i1* %ntb

	%_409 = load i8*, i8** %p_node
	%_410 = bitcast i8* %_409 to i8***
	%_411 = load i8**, i8*** %_410
	%_412 = getelementptr i8*, i8** %_411, i32 80
	%_413 = load i8*, i8** %_412
	%_414 = bitcast i8* %_413 to i1 (i8*, i1)*
	%_415 = call i1 %_414(i8* %_409, i1 0)
	store i1 %_415, i1* %ntb

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
	%_417 = load i8*, i8** %c_node
	%_418 = bitcast i8* %_417 to i8***
	%_419 = load i8**, i8*** %_418
	%_420 = getelementptr i8*, i8** %_419, i32 64
	%_421 = load i8*, i8** %_420
	%_422 = bitcast i8* %_421 to i1 (i8*)*
	%_423 = call i1 %_422(i8* %_417)
	br i1 %_423, label %L65, label %L66
L65:
	%_425 = load i8*, i8** %c_node
	%_426 = load i8*, i8** %c_node
	%_427 = bitcast i8* %_426 to i8***
	%_428 = load i8**, i8*** %_427
	%_429 = getelementptr i8*, i8** %_428, i32 32
	%_430 = load i8*, i8** %_429
	%_431 = bitcast i8* %_430 to i8* (i8*)*
	%_432 = call i8* %_431(i8* %_426)
	%_434 = bitcast i8* %_432 to i8***
	%_435 = load i8**, i8*** %_434
	%_436 = getelementptr i8*, i8** %_435, i32 40
	%_437 = load i8*, i8** %_436
	%_438 = bitcast i8* %_437 to i32 (i8*)*
	%_439 = call i32 %_438(i8* %_432)
	%_441 = bitcast i8* %_425 to i8***
	%_442 = load i8**, i8*** %_441
	%_443 = getelementptr i8*, i8** %_442, i32 48
	%_444 = load i8*, i8** %_443
	%_445 = bitcast i8* %_444 to i1 (i8*, i32)*
	%_446 = call i1 %_445(i8* %_425, i32 %_439)
	store i1 %_446, i1* %ntb

	%_448 = load i8*, i8** %c_node
	store i8* %_448, i8** %p_node

	%_449 = load i8*, i8** %c_node
	%_450 = bitcast i8* %_449 to i8***
	%_451 = load i8**, i8*** %_450
	%_452 = getelementptr i8*, i8** %_451, i32 32
	%_453 = load i8*, i8** %_452
	%_454 = bitcast i8* %_453 to i8* (i8*)*
	%_455 = call i8* %_454(i8* %_449)
	store i8* %_455, i8** %c_node


	br label %L64
L66:

	%_457 = load i8*, i8** %p_node
	%_459 = getelementptr i8, i8* %this, i32 22
	%_460 = bitcast i8* %_459 to i8**
	%_458 = load i8*, i8** %_460
	%_461 = bitcast i8* %_457 to i8***
	%_462 = load i8**, i8*** %_461
	%_463 = getelementptr i8*, i8** %_462, i32 16
	%_464 = load i8*, i8** %_463
	%_465 = bitcast i8* %_464 to i1 (i8*, i8*)*
	%_466 = call i1 %_465(i8* %_457, i8* %_458)
	store i1 %_466, i1* %ntb

	%_468 = load i8*, i8** %p_node
	%_469 = bitcast i8* %_468 to i8***
	%_470 = load i8**, i8*** %_469
	%_471 = getelementptr i8*, i8** %_470, i32 72
	%_472 = load i8*, i8** %_471
	%_473 = bitcast i8* %_472 to i1 (i8*, i1)*
	%_474 = call i1 %_473(i8* %_468, i1 0)
	store i1 %_474, i1* %ntb

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
	%_476 = load i1, i1* %cont
	br i1 %_476, label %L68, label %L69
L68:
	%_477 = load i8*, i8** %current_node
	%_478 = bitcast i8* %_477 to i8***
	%_479 = load i8**, i8*** %_478
	%_480 = getelementptr i8*, i8** %_479, i32 40
	%_481 = load i8*, i8** %_480
	%_482 = bitcast i8* %_481 to i32 (i8*)*
	%_483 = call i32 %_482(i8* %_477)
	store i32 %_483, i32* %key_aux

	%_485 = load i32, i32* %v_key
	%_486 = load i32, i32* %key_aux
	%_487 = icmp slt i32 %_485, %_486
	br i1 %_487, label %L70, label %L71
L70:
	%_488 = load i8*, i8** %current_node
	%_489 = bitcast i8* %_488 to i8***
	%_490 = load i8**, i8*** %_489
	%_491 = getelementptr i8*, i8** %_490, i32 64
	%_492 = load i8*, i8** %_491
	%_493 = bitcast i8* %_492 to i1 (i8*)*
	%_494 = call i1 %_493(i8* %_488)
	br i1 %_494, label %L73, label %L74
L73:
	%_496 = load i8*, i8** %current_node
	%_497 = bitcast i8* %_496 to i8***
	%_498 = load i8**, i8*** %_497
	%_499 = getelementptr i8*, i8** %_498, i32 32
	%_500 = load i8*, i8** %_499
	%_501 = bitcast i8* %_500 to i8* (i8*)*
	%_502 = call i8* %_501(i8* %_496)
	store i8* %_502, i8** %current_node

	br label %L75
L74:
	store i1 0, i1* %cont

	br label %L75
L75:

	br label %L72
L71:
	%_504 = load i32, i32* %key_aux
	%_505 = load i32, i32* %v_key
	%_506 = icmp slt i32 %_504, %_505
	br i1 %_506, label %L76, label %L77
L76:
	%_507 = load i8*, i8** %current_node
	%_508 = bitcast i8* %_507 to i8***
	%_509 = load i8**, i8*** %_508
	%_510 = getelementptr i8*, i8** %_509, i32 56
	%_511 = load i8*, i8** %_510
	%_512 = bitcast i8* %_511 to i1 (i8*)*
	%_513 = call i1 %_512(i8* %_507)
	br i1 %_513, label %L79, label %L80
L79:
	%_515 = load i8*, i8** %current_node
	%_516 = bitcast i8* %_515 to i8***
	%_517 = load i8**, i8*** %_516
	%_518 = getelementptr i8*, i8** %_517, i32 24
	%_519 = load i8*, i8** %_518
	%_520 = bitcast i8* %_519 to i8* (i8*)*
	%_521 = call i8* %_520(i8* %_515)
	store i8* %_521, i8** %current_node

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

	%_523 = load i32, i32* %ifound
	ret i32 %_523
}

define i1 @Tree.Print(i8* %this) {
	ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
	%_524 = load i8*, i8** %node
	%_525 = bitcast i8* %_524 to i8***
	%_526 = load i8**, i8*** %_525
	%_527 = getelementptr i8*, i8** %_526, i32 64
	%_528 = load i8*, i8** %_527
	%_529 = bitcast i8* %_528 to i1 (i8*)*
	%_530 = call i1 %_529(i8* %_524)
	br i1 %_530, label %L82, label %L83
L82:
	%_532 = load i8*, i8** %node
	%_533 = bitcast i8* %_532 to i8***
	%_534 = load i8**, i8*** %_533
	%_535 = getelementptr i8*, i8** %_534, i32 32
	%_536 = load i8*, i8** %_535
	%_537 = bitcast i8* %_536 to i8* (i8*)*
	%_538 = call i8* %_537(i8* %_532)
	%_540 = bitcast i8* %this to i8***
	%_541 = load i8**, i8*** %_540
	%_542 = getelementptr i8*, i8** %_541, i32 152
	%_543 = load i8*, i8** %_542
	%_544 = bitcast i8* %_543 to i1 (i8*, i8*)*
	%_545 = call i1 %_544(i8* %this, i8* %_538)
	store i1 %_545, i1* %ntb


	br label %L84
L83:
	store i1 1, i1* %ntb

	br label %L84
L84:

	%_547 = load i8*, i8** %node
	%_548 = bitcast i8* %_547 to i8***
	%_549 = load i8**, i8*** %_548
	%_550 = getelementptr i8*, i8** %_549, i32 40
	%_551 = load i8*, i8** %_550
	%_552 = bitcast i8* %_551 to i32 (i8*)*
	%_553 = call i32 %_552(i8* %_547)
	call void (i32) @print_int(i32 %_553)

	%_555 = load i8*, i8** %node
	%_556 = bitcast i8* %_555 to i8***
	%_557 = load i8**, i8*** %_556
	%_558 = getelementptr i8*, i8** %_557, i32 56
	%_559 = load i8*, i8** %_558
	%_560 = bitcast i8* %_559 to i1 (i8*)*
	%_561 = call i1 %_560(i8* %_555)
	br i1 %_561, label %L85, label %L86
L85:
	%_563 = load i8*, i8** %node
	%_564 = bitcast i8* %_563 to i8***
	%_565 = load i8**, i8*** %_564
	%_566 = getelementptr i8*, i8** %_565, i32 24
	%_567 = load i8*, i8** %_566
	%_568 = bitcast i8* %_567 to i8* (i8*)*
	%_569 = call i8* %_568(i8* %_563)
	%_571 = bitcast i8* %this to i8***
	%_572 = load i8**, i8*** %_571
	%_573 = getelementptr i8*, i8** %_572, i32 152
	%_574 = load i8*, i8** %_573
	%_575 = bitcast i8* %_574 to i1 (i8*, i8*)*
	%_576 = call i1 %_575(i8* %this, i8* %_569)
	store i1 %_576, i1* %ntb


	br label %L87
L86:
	store i1 1, i1* %ntb

	br label %L87
L87:

	ret i1 1
}

