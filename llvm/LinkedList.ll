@.LinkedList_vtable = global [0 x i8*] []

@.Element_vtable = global [6 x i8*] [
	i8* bitcast (i1 (i8*, i32, i32, i1)* @Element.Init to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetAge to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*),
	i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Element.Equal to i8*),
	i8* bitcast (i1 (i8*, i32, i32)* @Element.Compare to i8*)
]

@.List_vtable = global [10 x i8*] [
	i8* bitcast (i1 (i8*)* @List.Init to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*, i1)* @List.InitNew to i8*),
	i8* bitcast (i8* (i8*, i8*)* @List.Insert to i8*),
	i8* bitcast (i1 (i8*, i8*)* @List.SetNext to i8*),
	i8* bitcast (i8* (i8*, i8*)* @List.Delete to i8*),
	i8* bitcast (i32 (i8*, i8*)* @List.Search to i8*),
	i8* bitcast (i1 (i8*)* @List.GetEnd to i8*),
	i8* bitcast (i8* (i8*)* @List.GetElem to i8*),
	i8* bitcast (i8* (i8*)* @List.GetNext to i8*),
	i8* bitcast (i1 (i8*)* @List.Print to i8*)
]

@.LL_vtable = global [1 x i8*] [
	i8* bitcast (i32 (i8*)* @LL.Start to i8*)
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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
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

define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married

	%_10 = load i32, i32* %v_Age
	%_11 = getelementptr i8, i8* %this, i32 8
	%_12 = bitcast i8* %_11 to i32*
	store i32 %_10, i32* %_12

	%_13 = load i32, i32* %v_Salary
	%_14 = getelementptr i8, i8* %this, i32 12
	%_15 = bitcast i8* %_14 to i32*
	store i32 %_13, i32* %_15

	%_16 = load i1, i1* %v_Married
	%_17 = getelementptr i8, i8* %this, i32 16
	%_18 = bitcast i8* %_17 to i1*
	store i1 %_16, i1* %_18

	ret i1 1
}

define i32 @Element.GetAge(i8* %this) {

	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i32*
	%_19 = load i32, i32* %_21
	ret i32 %_19
}

define i32 @Element.GetSalary(i8* %this) {

	%_23 = getelementptr i8, i8* %this, i32 12
	%_24 = bitcast i8* %_23 to i32*
	%_22 = load i32, i32* %_24
	ret i32 %_22
}

define i1 @Element.GetMarried(i8* %this) {

	%_26 = getelementptr i8, i8* %this, i32 16
	%_27 = bitcast i8* %_26 to i1*
	%_25 = load i1, i1* %_27
	ret i1 %_25
}

define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32

	store i1 1, i1* %ret_val

	%_28 = load i8*, i8** %other
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 1
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i32 (i8*)*
	%_34 = call i32 %_33(i8* %_28)
	store i32 %_34, i32* %aux01

	%_36 = load i32, i32* %aux01
	%_38 = getelementptr i8, i8* %this, i32 8
	%_39 = bitcast i8* %_38 to i32*
	%_37 = load i32, i32* %_39
	%_40 = bitcast i8* %this to i8***
	%_41 = load i8**, i8*** %_40
	%_42 = getelementptr i8*, i8** %_41, i32 5
	%_43 = load i8*, i8** %_42
	%_44 = bitcast i8* %_43 to i1 (i8*, i32, i32)*
	%_45 = call i1 %_44(i8* %this, i32 %_36, i32 %_37)
	br i1 %_45, label %L0, label %L1
L0:
	br label %L2
L1:
	br label %L2
L2:
	%_47 = phi i1 [0, %L0], [1, %L1]
	br i1 %_47, label %L3, label %L4
L3:
	store i1 0, i1* %ret_val

	br label %L5
L4:
	%_48 = load i8*, i8** %other
	%_49 = bitcast i8* %_48 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 2
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i32 (i8*)*
	%_54 = call i32 %_53(i8* %_48)
	store i32 %_54, i32* %aux02

	%_56 = load i32, i32* %aux02
	%_58 = getelementptr i8, i8* %this, i32 12
	%_59 = bitcast i8* %_58 to i32*
	%_57 = load i32, i32* %_59
	%_60 = bitcast i8* %this to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 5
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i1 (i8*, i32, i32)*
	%_65 = call i1 %_64(i8* %this, i32 %_56, i32 %_57)
	br i1 %_65, label %L6, label %L7
L6:
	br label %L8
L7:
	br label %L8
L8:
	%_67 = phi i1 [0, %L6], [1, %L7]
	br i1 %_67, label %L9, label %L10
L9:
	store i1 0, i1* %ret_val

	br label %L11
L10:
	%_69 = getelementptr i8, i8* %this, i32 16
	%_70 = bitcast i8* %_69 to i1*
	%_68 = load i1, i1* %_70
	br i1 %_68, label %L12, label %L13
L12:
	%_71 = load i8*, i8** %other
	%_72 = bitcast i8* %_71 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 3
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i1 (i8*)*
	%_77 = call i1 %_76(i8* %_71)
	br i1 %_77, label %L15, label %L16
L15:
	br label %L17
L16:
	br label %L17
L17:
	%_79 = phi i1 [0, %L15], [1, %L16]
	br i1 %_79, label %L18, label %L19
L18:
	store i1 0, i1* %ret_val

	br label %L20
L19:
	store i32 0, i32* %nt

	br label %L20
L20:

	br label %L14
L13:
	%_80 = load i8*, i8** %other
	%_81 = bitcast i8* %_80 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 3
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*)*
	%_86 = call i1 %_85(i8* %_80)
	br i1 %_86, label %L21, label %L22
L21:
	store i1 0, i1* %ret_val

	br label %L23
L22:
	store i32 0, i32* %nt

	br label %L23
L23:

	br label %L14
L14:

	br label %L11
L11:


	br label %L5
L5:

	%_88 = load i1, i1* %ret_val
	ret i1 %_88
}

define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32

	store i1 0, i1* %retval

	%_89 = load i32, i32* %num2
	%_90 = add i32 %_89, 1
	store i32 %_90, i32* %aux02

	%_91 = load i32, i32* %num1
	%_92 = load i32, i32* %num2
	%_93 = icmp slt i32 %_91, %_92
	br i1 %_93, label %L24, label %L25
L24:
	store i1 0, i1* %retval

	br label %L26
L25:
	%_94 = load i32, i32* %num1
	%_95 = load i32, i32* %aux02
	%_96 = icmp slt i32 %_94, %_95
	br i1 %_96, label %L27, label %L28
L27:
	br label %L29
L28:
	br label %L29
L29:
	%_97 = phi i1 [0, %L27], [1, %L28]
	br i1 %_97, label %L30, label %L31
L30:
	store i1 0, i1* %retval

	br label %L32
L31:
	store i1 1, i1* %retval

	br label %L32
L32:

	br label %L26
L26:

	%_98 = load i1, i1* %retval
	ret i1 %_98
}

define i1 @List.Init(i8* %this) {

	%_99 = getelementptr i8, i8* %this, i32 24
	%_100 = bitcast i8* %_99 to i1*
	store i1 1, i1* %_100

	ret i1 1
}

define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end

	%_101 = load i1, i1* %v_end
	%_102 = getelementptr i8, i8* %this, i32 24
	%_103 = bitcast i8* %_102 to i1*
	store i1 %_101, i1* %_103

	%_104 = load i8*, i8** %v_elem
	%_105 = getelementptr i8, i8* %this, i32 8
	%_106 = bitcast i8* %_105 to i8**
	store i8* %_104, i8** %_106

	%_107 = load i8*, i8** %v_next
	%_108 = getelementptr i8, i8* %this, i32 16
	%_109 = bitcast i8* %_108 to i8**
	store i8* %_107, i8** %_109

	ret i1 1
}

define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1
	%aux03 = alloca i8*
	%aux02 = alloca i8*

	store i8* %this, i8** %aux03

	%_110 = call i8* @calloc(i32 1, i32 25)
	%_111 = bitcast i8* %_110 to i8***
	%_112 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_112, i8*** %_111
	store i8* %_110, i8** %aux02

	%_113 = load i8*, i8** %aux02
	%_114 = load i8*, i8** %new_elem
	%_115 = load i8*, i8** %aux03
	%_116 = bitcast i8* %_113 to i8***
	%_117 = load i8**, i8*** %_116
	%_118 = getelementptr i8*, i8** %_117, i32 1
	%_119 = load i8*, i8** %_118
	%_120 = bitcast i8* %_119 to i1 (i8*, i8*, i8*, i1)*
	%_121 = call i1 %_120(i8* %_113, i8* %_114, i8* %_115, i1 0)
	store i1 %_121, i1* %ret_val

	%_123 = load i8*, i8** %aux02
	ret i8* %_123
}

define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next

	%_124 = load i8*, i8** %v_next
	%_125 = getelementptr i8, i8* %this, i32 16
	%_126 = bitcast i8* %_125 to i8**
	store i8* %_124, i8** %_126

	ret i1 1
}

define i8* @List.Delete(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%my_head = alloca i8*
	%ret_val = alloca i1
	%aux05 = alloca i1
	%aux01 = alloca i8*
	%prev = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
	%aux04 = alloca i32
	%nt = alloca i32

	store i8* %this, i8** %my_head

	store i1 0, i1* %ret_val

	%_127 =  sub i32 0, 1
	store i32 %_127, i32* %aux04

	store i8* %this, i8** %aux01

	store i8* %this, i8** %prev

	%_129 = getelementptr i8, i8* %this, i32 24
	%_130 = bitcast i8* %_129 to i1*
	%_128 = load i1, i1* %_130
	store i1 %_128, i1* %var_end

	%_132 = getelementptr i8, i8* %this, i32 8
	%_133 = bitcast i8* %_132 to i8**
	%_131 = load i8*, i8** %_133
	store i8* %_131, i8** %var_elem

	br label %L33
L33:
	%_134 = load i1, i1* %var_end
	br i1 %_134, label %L36, label %L37
L36:
	br label %L38
L37:
	br label %L38
L38:
	%_135 = phi i1 [0, %L36], [1, %L37]
	br i1 %_135, label %L43, label %L42
L42:
	br label %L45
L43:
	%_136 = load i1, i1* %ret_val
	br i1 %_136, label %L39, label %L40
L39:
	br label %L41
L40:
	br label %L41
L41:
	%_137 = phi i1 [0, %L39], [1, %L40]
	br label %L44
L44:
	br label %L45
L45:
	%_138 = phi i1 [0, %L42], [%_137, %L44]
	br i1 %_138, label %L34, label %L35
L34:
	%_139 = load i8*, i8** %e
	%_140 = load i8*, i8** %var_elem
	%_141 = bitcast i8* %_139 to i8***
	%_142 = load i8**, i8*** %_141
	%_143 = getelementptr i8*, i8** %_142, i32 4
	%_144 = load i8*, i8** %_143
	%_145 = bitcast i8* %_144 to i1 (i8*, i8*)*
	%_146 = call i1 %_145(i8* %_139, i8* %_140)
	br i1 %_146, label %L46, label %L47
L46:
	store i1 1, i1* %ret_val

	%_148 = load i32, i32* %aux04
	%_149 = icmp slt i32 %_148, 0
	br i1 %_149, label %L49, label %L50
L49:
	%_150 = load i8*, i8** %aux01
	%_151 = bitcast i8* %_150 to i8***
	%_152 = load i8**, i8*** %_151
	%_153 = getelementptr i8*, i8** %_152, i32 8
	%_154 = load i8*, i8** %_153
	%_155 = bitcast i8* %_154 to i8* (i8*)*
	%_156 = call i8* %_155(i8* %_150)
	store i8* %_156, i8** %my_head


	br label %L51
L50:
	%_158 =  sub i32 0, 555
	call void (i32) @print_int(i32 %_158)

	%_159 = load i8*, i8** %prev
	%_160 = load i8*, i8** %aux01
	%_161 = bitcast i8* %_160 to i8***
	%_162 = load i8**, i8*** %_161
	%_163 = getelementptr i8*, i8** %_162, i32 8
	%_164 = load i8*, i8** %_163
	%_165 = bitcast i8* %_164 to i8* (i8*)*
	%_166 = call i8* %_165(i8* %_160)
	%_168 = bitcast i8* %_159 to i8***
	%_169 = load i8**, i8*** %_168
	%_170 = getelementptr i8*, i8** %_169, i32 3
	%_171 = load i8*, i8** %_170
	%_172 = bitcast i8* %_171 to i1 (i8*, i8*)*
	%_173 = call i1 %_172(i8* %_159, i8* %_166)
	store i1 %_173, i1* %aux05

	%_175 =  sub i32 0, 555
	call void (i32) @print_int(i32 %_175)


	br label %L51
L51:


	br label %L48
L47:
	store i32 0, i32* %nt

	br label %L48
L48:

	%_176 = load i1, i1* %ret_val
	br i1 %_176, label %L52, label %L53
L52:
	br label %L54
L53:
	br label %L54
L54:
	%_177 = phi i1 [0, %L52], [1, %L53]
	br i1 %_177, label %L55, label %L56
L55:
	%_178 = load i8*, i8** %aux01
	store i8* %_178, i8** %prev

	%_179 = load i8*, i8** %aux01
	%_180 = bitcast i8* %_179 to i8***
	%_181 = load i8**, i8*** %_180
	%_182 = getelementptr i8*, i8** %_181, i32 8
	%_183 = load i8*, i8** %_182
	%_184 = bitcast i8* %_183 to i8* (i8*)*
	%_185 = call i8* %_184(i8* %_179)
	store i8* %_185, i8** %aux01

	%_187 = load i8*, i8** %aux01
	%_188 = bitcast i8* %_187 to i8***
	%_189 = load i8**, i8*** %_188
	%_190 = getelementptr i8*, i8** %_189, i32 6
	%_191 = load i8*, i8** %_190
	%_192 = bitcast i8* %_191 to i1 (i8*)*
	%_193 = call i1 %_192(i8* %_187)
	store i1 %_193, i1* %var_end

	%_195 = load i8*, i8** %aux01
	%_196 = bitcast i8* %_195 to i8***
	%_197 = load i8**, i8*** %_196
	%_198 = getelementptr i8*, i8** %_197, i32 7
	%_199 = load i8*, i8** %_198
	%_200 = bitcast i8* %_199 to i8* (i8*)*
	%_201 = call i8* %_200(i8* %_195)
	store i8* %_201, i8** %var_elem

	store i32 1, i32* %aux04


	br label %L57
L56:
	store i32 0, i32* %nt

	br label %L57
L57:


	br label %L33
L35:

	%_203 = load i8*, i8** %my_head
	ret i8* %_203
}

define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32
	%aux01 = alloca i8*
	%var_elem = alloca i8*
	%var_end = alloca i1
	%nt = alloca i32

	store i32 0, i32* %int_ret_val

	store i8* %this, i8** %aux01

	%_205 = getelementptr i8, i8* %this, i32 24
	%_206 = bitcast i8* %_205 to i1*
	%_204 = load i1, i1* %_206
	store i1 %_204, i1* %var_end

	%_208 = getelementptr i8, i8* %this, i32 8
	%_209 = bitcast i8* %_208 to i8**
	%_207 = load i8*, i8** %_209
	store i8* %_207, i8** %var_elem

	br label %L58
L58:
	%_210 = load i1, i1* %var_end
	br i1 %_210, label %L61, label %L62
L61:
	br label %L63
L62:
	br label %L63
L63:
	%_211 = phi i1 [0, %L61], [1, %L62]
	br i1 %_211, label %L59, label %L60
L59:
	%_212 = load i8*, i8** %e
	%_213 = load i8*, i8** %var_elem
	%_214 = bitcast i8* %_212 to i8***
	%_215 = load i8**, i8*** %_214
	%_216 = getelementptr i8*, i8** %_215, i32 4
	%_217 = load i8*, i8** %_216
	%_218 = bitcast i8* %_217 to i1 (i8*, i8*)*
	%_219 = call i1 %_218(i8* %_212, i8* %_213)
	br i1 %_219, label %L64, label %L65
L64:
	store i32 1, i32* %int_ret_val


	br label %L66
L65:
	store i32 0, i32* %nt

	br label %L66
L66:

	%_221 = load i8*, i8** %aux01
	%_222 = bitcast i8* %_221 to i8***
	%_223 = load i8**, i8*** %_222
	%_224 = getelementptr i8*, i8** %_223, i32 8
	%_225 = load i8*, i8** %_224
	%_226 = bitcast i8* %_225 to i8* (i8*)*
	%_227 = call i8* %_226(i8* %_221)
	store i8* %_227, i8** %aux01

	%_229 = load i8*, i8** %aux01
	%_230 = bitcast i8* %_229 to i8***
	%_231 = load i8**, i8*** %_230
	%_232 = getelementptr i8*, i8** %_231, i32 6
	%_233 = load i8*, i8** %_232
	%_234 = bitcast i8* %_233 to i1 (i8*)*
	%_235 = call i1 %_234(i8* %_229)
	store i1 %_235, i1* %var_end

	%_237 = load i8*, i8** %aux01
	%_238 = bitcast i8* %_237 to i8***
	%_239 = load i8**, i8*** %_238
	%_240 = getelementptr i8*, i8** %_239, i32 7
	%_241 = load i8*, i8** %_240
	%_242 = bitcast i8* %_241 to i8* (i8*)*
	%_243 = call i8* %_242(i8* %_237)
	store i8* %_243, i8** %var_elem


	br label %L58
L60:

	%_245 = load i32, i32* %int_ret_val
	ret i32 %_245
}

define i1 @List.GetEnd(i8* %this) {

	%_247 = getelementptr i8, i8* %this, i32 24
	%_248 = bitcast i8* %_247 to i1*
	%_246 = load i1, i1* %_248
	ret i1 %_246
}

define i8* @List.GetElem(i8* %this) {

	%_250 = getelementptr i8, i8* %this, i32 8
	%_251 = bitcast i8* %_250 to i8**
	%_249 = load i8*, i8** %_251
	ret i8* %_249
}

define i8* @List.GetNext(i8* %this) {

	%_253 = getelementptr i8, i8* %this, i32 16
	%_254 = bitcast i8* %_253 to i8**
	%_252 = load i8*, i8** %_254
	ret i8* %_252
}

define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*

	store i8* %this, i8** %aux01

	%_256 = getelementptr i8, i8* %this, i32 24
	%_257 = bitcast i8* %_256 to i1*
	%_255 = load i1, i1* %_257
	store i1 %_255, i1* %var_end

	%_259 = getelementptr i8, i8* %this, i32 8
	%_260 = bitcast i8* %_259 to i8**
	%_258 = load i8*, i8** %_260
	store i8* %_258, i8** %var_elem

	br label %L67
L67:
	%_261 = load i1, i1* %var_end
	br i1 %_261, label %L70, label %L71
L70:
	br label %L72
L71:
	br label %L72
L72:
	%_262 = phi i1 [0, %L70], [1, %L71]
	br i1 %_262, label %L68, label %L69
L68:
	%_263 = load i8*, i8** %var_elem
	%_264 = bitcast i8* %_263 to i8***
	%_265 = load i8**, i8*** %_264
	%_266 = getelementptr i8*, i8** %_265, i32 1
	%_267 = load i8*, i8** %_266
	%_268 = bitcast i8* %_267 to i32 (i8*)*
	%_269 = call i32 %_268(i8* %_263)
	call void (i32) @print_int(i32 %_269)

	%_271 = load i8*, i8** %aux01
	%_272 = bitcast i8* %_271 to i8***
	%_273 = load i8**, i8*** %_272
	%_274 = getelementptr i8*, i8** %_273, i32 8
	%_275 = load i8*, i8** %_274
	%_276 = bitcast i8* %_275 to i8* (i8*)*
	%_277 = call i8* %_276(i8* %_271)
	store i8* %_277, i8** %aux01

	%_279 = load i8*, i8** %aux01
	%_280 = bitcast i8* %_279 to i8***
	%_281 = load i8**, i8*** %_280
	%_282 = getelementptr i8*, i8** %_281, i32 6
	%_283 = load i8*, i8** %_282
	%_284 = bitcast i8* %_283 to i1 (i8*)*
	%_285 = call i1 %_284(i8* %_279)
	store i1 %_285, i1* %var_end

	%_287 = load i8*, i8** %aux01
	%_288 = bitcast i8* %_287 to i8***
	%_289 = load i8**, i8*** %_288
	%_290 = getelementptr i8*, i8** %_289, i32 7
	%_291 = load i8*, i8** %_290
	%_292 = bitcast i8* %_291 to i8* (i8*)*
	%_293 = call i8* %_292(i8* %_287)
	store i8* %_293, i8** %var_elem


	br label %L67
L69:

	ret i1 1
}

define i32 @LL.Start(i8* %this) {
	%head = alloca i8*
	%last_elem = alloca i8*
	%aux01 = alloca i1
	%el01 = alloca i8*
	%el02 = alloca i8*
	%el03 = alloca i8*

	%_295 = call i8* @calloc(i32 1, i32 25)
	%_296 = bitcast i8* %_295 to i8***
	%_297 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_297, i8*** %_296
	store i8* %_295, i8** %last_elem

	%_298 = load i8*, i8** %last_elem
	%_299 = bitcast i8* %_298 to i8***
	%_300 = load i8**, i8*** %_299
	%_301 = getelementptr i8*, i8** %_300, i32 0
	%_302 = load i8*, i8** %_301
	%_303 = bitcast i8* %_302 to i1 (i8*)*
	%_304 = call i1 %_303(i8* %_298)
	store i1 %_304, i1* %aux01

	%_306 = load i8*, i8** %last_elem
	store i8* %_306, i8** %head

	%_307 = load i8*, i8** %head
	%_308 = bitcast i8* %_307 to i8***
	%_309 = load i8**, i8*** %_308
	%_310 = getelementptr i8*, i8** %_309, i32 0
	%_311 = load i8*, i8** %_310
	%_312 = bitcast i8* %_311 to i1 (i8*)*
	%_313 = call i1 %_312(i8* %_307)
	store i1 %_313, i1* %aux01

	%_315 = load i8*, i8** %head
	%_316 = bitcast i8* %_315 to i8***
	%_317 = load i8**, i8*** %_316
	%_318 = getelementptr i8*, i8** %_317, i32 9
	%_319 = load i8*, i8** %_318
	%_320 = bitcast i8* %_319 to i1 (i8*)*
	%_321 = call i1 %_320(i8* %_315)
	store i1 %_321, i1* %aux01

	%_323 = call i8* @calloc(i32 1, i32 17)
	%_324 = bitcast i8* %_323 to i8***
	%_325 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_325, i8*** %_324
	store i8* %_323, i8** %el01

	%_326 = load i8*, i8** %el01
	%_327 = bitcast i8* %_326 to i8***
	%_328 = load i8**, i8*** %_327
	%_329 = getelementptr i8*, i8** %_328, i32 0
	%_330 = load i8*, i8** %_329
	%_331 = bitcast i8* %_330 to i1 (i8*, i32, i32, i1)*
	%_332 = call i1 %_331(i8* %_326, i32 25, i32 37000, i1 0)
	store i1 %_332, i1* %aux01

	%_334 = load i8*, i8** %head
	%_335 = load i8*, i8** %el01
	%_336 = bitcast i8* %_334 to i8***
	%_337 = load i8**, i8*** %_336
	%_338 = getelementptr i8*, i8** %_337, i32 2
	%_339 = load i8*, i8** %_338
	%_340 = bitcast i8* %_339 to i8* (i8*, i8*)*
	%_341 = call i8* %_340(i8* %_334, i8* %_335)
	store i8* %_341, i8** %head

	%_343 = load i8*, i8** %head
	%_344 = bitcast i8* %_343 to i8***
	%_345 = load i8**, i8*** %_344
	%_346 = getelementptr i8*, i8** %_345, i32 9
	%_347 = load i8*, i8** %_346
	%_348 = bitcast i8* %_347 to i1 (i8*)*
	%_349 = call i1 %_348(i8* %_343)
	store i1 %_349, i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_351 = call i8* @calloc(i32 1, i32 17)
	%_352 = bitcast i8* %_351 to i8***
	%_353 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_353, i8*** %_352
	store i8* %_351, i8** %el01

	%_354 = load i8*, i8** %el01
	%_355 = bitcast i8* %_354 to i8***
	%_356 = load i8**, i8*** %_355
	%_357 = getelementptr i8*, i8** %_356, i32 0
	%_358 = load i8*, i8** %_357
	%_359 = bitcast i8* %_358 to i1 (i8*, i32, i32, i1)*
	%_360 = call i1 %_359(i8* %_354, i32 39, i32 42000, i1 1)
	store i1 %_360, i1* %aux01

	%_362 = load i8*, i8** %el01
	store i8* %_362, i8** %el02

	%_363 = load i8*, i8** %head
	%_364 = load i8*, i8** %el01
	%_365 = bitcast i8* %_363 to i8***
	%_366 = load i8**, i8*** %_365
	%_367 = getelementptr i8*, i8** %_366, i32 2
	%_368 = load i8*, i8** %_367
	%_369 = bitcast i8* %_368 to i8* (i8*, i8*)*
	%_370 = call i8* %_369(i8* %_363, i8* %_364)
	store i8* %_370, i8** %head

	%_372 = load i8*, i8** %head
	%_373 = bitcast i8* %_372 to i8***
	%_374 = load i8**, i8*** %_373
	%_375 = getelementptr i8*, i8** %_374, i32 9
	%_376 = load i8*, i8** %_375
	%_377 = bitcast i8* %_376 to i1 (i8*)*
	%_378 = call i1 %_377(i8* %_372)
	store i1 %_378, i1* %aux01

	call void (i32) @print_int(i32 10000000)

	%_380 = call i8* @calloc(i32 1, i32 17)
	%_381 = bitcast i8* %_380 to i8***
	%_382 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_382, i8*** %_381
	store i8* %_380, i8** %el01

	%_383 = load i8*, i8** %el01
	%_384 = bitcast i8* %_383 to i8***
	%_385 = load i8**, i8*** %_384
	%_386 = getelementptr i8*, i8** %_385, i32 0
	%_387 = load i8*, i8** %_386
	%_388 = bitcast i8* %_387 to i1 (i8*, i32, i32, i1)*
	%_389 = call i1 %_388(i8* %_383, i32 22, i32 34000, i1 0)
	store i1 %_389, i1* %aux01

	%_391 = load i8*, i8** %head
	%_392 = load i8*, i8** %el01
	%_393 = bitcast i8* %_391 to i8***
	%_394 = load i8**, i8*** %_393
	%_395 = getelementptr i8*, i8** %_394, i32 2
	%_396 = load i8*, i8** %_395
	%_397 = bitcast i8* %_396 to i8* (i8*, i8*)*
	%_398 = call i8* %_397(i8* %_391, i8* %_392)
	store i8* %_398, i8** %head

	%_400 = load i8*, i8** %head
	%_401 = bitcast i8* %_400 to i8***
	%_402 = load i8**, i8*** %_401
	%_403 = getelementptr i8*, i8** %_402, i32 9
	%_404 = load i8*, i8** %_403
	%_405 = bitcast i8* %_404 to i1 (i8*)*
	%_406 = call i1 %_405(i8* %_400)
	store i1 %_406, i1* %aux01

	%_408 = call i8* @calloc(i32 1, i32 17)
	%_409 = bitcast i8* %_408 to i8***
	%_410 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_410, i8*** %_409
	store i8* %_408, i8** %el03

	%_411 = load i8*, i8** %el03
	%_412 = bitcast i8* %_411 to i8***
	%_413 = load i8**, i8*** %_412
	%_414 = getelementptr i8*, i8** %_413, i32 0
	%_415 = load i8*, i8** %_414
	%_416 = bitcast i8* %_415 to i1 (i8*, i32, i32, i1)*
	%_417 = call i1 %_416(i8* %_411, i32 27, i32 34000, i1 0)
	store i1 %_417, i1* %aux01

	%_419 = load i8*, i8** %head
	%_420 = load i8*, i8** %el02
	%_421 = bitcast i8* %_419 to i8***
	%_422 = load i8**, i8*** %_421
	%_423 = getelementptr i8*, i8** %_422, i32 5
	%_424 = load i8*, i8** %_423
	%_425 = bitcast i8* %_424 to i32 (i8*, i8*)*
	%_426 = call i32 %_425(i8* %_419, i8* %_420)
	call void (i32) @print_int(i32 %_426)

	%_428 = load i8*, i8** %head
	%_429 = load i8*, i8** %el03
	%_430 = bitcast i8* %_428 to i8***
	%_431 = load i8**, i8*** %_430
	%_432 = getelementptr i8*, i8** %_431, i32 5
	%_433 = load i8*, i8** %_432
	%_434 = bitcast i8* %_433 to i32 (i8*, i8*)*
	%_435 = call i32 %_434(i8* %_428, i8* %_429)
	call void (i32) @print_int(i32 %_435)

	call void (i32) @print_int(i32 10000000)

	%_437 = call i8* @calloc(i32 1, i32 17)
	%_438 = bitcast i8* %_437 to i8***
	%_439 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_439, i8*** %_438
	store i8* %_437, i8** %el01

	%_440 = load i8*, i8** %el01
	%_441 = bitcast i8* %_440 to i8***
	%_442 = load i8**, i8*** %_441
	%_443 = getelementptr i8*, i8** %_442, i32 0
	%_444 = load i8*, i8** %_443
	%_445 = bitcast i8* %_444 to i1 (i8*, i32, i32, i1)*
	%_446 = call i1 %_445(i8* %_440, i32 28, i32 35000, i1 0)
	store i1 %_446, i1* %aux01

	%_448 = load i8*, i8** %head
	%_449 = load i8*, i8** %el01
	%_450 = bitcast i8* %_448 to i8***
	%_451 = load i8**, i8*** %_450
	%_452 = getelementptr i8*, i8** %_451, i32 2
	%_453 = load i8*, i8** %_452
	%_454 = bitcast i8* %_453 to i8* (i8*, i8*)*
	%_455 = call i8* %_454(i8* %_448, i8* %_449)
	store i8* %_455, i8** %head

	%_457 = load i8*, i8** %head
	%_458 = bitcast i8* %_457 to i8***
	%_459 = load i8**, i8*** %_458
	%_460 = getelementptr i8*, i8** %_459, i32 9
	%_461 = load i8*, i8** %_460
	%_462 = bitcast i8* %_461 to i1 (i8*)*
	%_463 = call i1 %_462(i8* %_457)
	store i1 %_463, i1* %aux01

	call void (i32) @print_int(i32 2220000)

	%_465 = load i8*, i8** %head
	%_466 = load i8*, i8** %el02
	%_467 = bitcast i8* %_465 to i8***
	%_468 = load i8**, i8*** %_467
	%_469 = getelementptr i8*, i8** %_468, i32 4
	%_470 = load i8*, i8** %_469
	%_471 = bitcast i8* %_470 to i8* (i8*, i8*)*
	%_472 = call i8* %_471(i8* %_465, i8* %_466)
	store i8* %_472, i8** %head

	%_474 = load i8*, i8** %head
	%_475 = bitcast i8* %_474 to i8***
	%_476 = load i8**, i8*** %_475
	%_477 = getelementptr i8*, i8** %_476, i32 9
	%_478 = load i8*, i8** %_477
	%_479 = bitcast i8* %_478 to i1 (i8*)*
	%_480 = call i1 %_479(i8* %_474)
	store i1 %_480, i1* %aux01

	call void (i32) @print_int(i32 33300000)

	%_482 = load i8*, i8** %head
	%_483 = load i8*, i8** %el01
	%_484 = bitcast i8* %_482 to i8***
	%_485 = load i8**, i8*** %_484
	%_486 = getelementptr i8*, i8** %_485, i32 4
	%_487 = load i8*, i8** %_486
	%_488 = bitcast i8* %_487 to i8* (i8*, i8*)*
	%_489 = call i8* %_488(i8* %_482, i8* %_483)
	store i8* %_489, i8** %head

	%_491 = load i8*, i8** %head
	%_492 = bitcast i8* %_491 to i8***
	%_493 = load i8**, i8*** %_492
	%_494 = getelementptr i8*, i8** %_493, i32 9
	%_495 = load i8*, i8** %_494
	%_496 = bitcast i8* %_495 to i1 (i8*)*
	%_497 = call i1 %_496(i8* %_491)
	store i1 %_497, i1* %aux01

	call void (i32) @print_int(i32 44440000)

	ret i32 0
}

