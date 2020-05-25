@.LetTheFunBegin_vtable = global [0 x i8*] []

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i8* (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*, i1)* @A.bar to i8*),
	i8* bitcast (i8* (i8*)* @A.another to i8*)
]

@.B_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @B.fill_arr to i8*),
	i8* bitcast (i32 (i8*)* @B.get_a to i8*),
	i8* bitcast (i1 (i8*)* @B.get_c to i8*)
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
	%b = alloca i8*
	%c = alloca i8*
	%d = alloca i32
	%a = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = add i32 4, 2
	%_4 = icmp sge i32 %_3, 4
	br i1 %_4, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_5 = call i8* @calloc(i32 1, i32 %_3)
	%_6 = bitcast i8* %_5 to i32*
	store i32 2, i32* %_6
	store i8* %_5, i8** %c

	%_9 = load i8*, i8** %c
	%_10 = bitcast i8* %_9 to i32*
	%_11 = load i32, i32* %_10
	%_12 = icmp sge i32 1, 0
	%_13 = icmp slt i32 1, %_11
	%_14 = and i1 %_13, %_14
	br i1 %_14, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_15 = add i32 4, 1
	%_16 = zext i1 0 to i8
	%_17 = getelementptr i8, i8* %_9, i32 %_15
	store i8 %_16, i8* %_17

	%_18 = load i8*, i8** %c
	%_19 = bitcast i8* %_18 to i32*
	%_20 = load i32, i32* %_19
	%_21 = icmp sge i32 1, 0
	%_22 = icmp slt i32 1, %_20
	%_23 = and i1 %_21, %_22
	br i1 %_23, label %L4, label %L5
L5:
	call void @throw_oob()
	br label %L4
L4:
	%_24 = add i32 4, 1
	%_25 = getelementptr i8, i8* %_18, i32 %_24
	%_26 = load i8, i8* %_25
	%_27 = trunc i8 %_26 to i1
	br i1 %_27, label %L6, label %L7
L6:
	call void (i32) @print_int(i32 1)


	br label %L8
L7:
	%_28 = load i8*, i8** %a
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 0
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i8* (i8*)*
	%_34 = call i8* %_33(i8* %_28)
	%_35 = bitcast i8* %_34 to i32*
	%_36 = load i32, i32* %_35
	%_37 = icmp sge i32 2, 0
	%_38 = icmp slt i32 2, %_36
	%_39 = and i1 %_37, %_38
	br i1 %_39, label %L9, label %L10
L10:
	call void @throw_oob()
	br label %L9
L9:
	%_40 = add i32 4, 2
	%_41 = getelementptr i8, i8* %_34, i32 %_40
	%_42 = load i8, i8* %_41
	%_43 = trunc i8 %_42 to i1
	br i1 %_43, label %L11, label %L12
L11:
	call void (i32) @print_int(i32 10)


	br label %L13
L12:
	call void (i32) @print_int(i32 20)


	br label %L13
L13:


	br label %L8
L8:

	%_44 = load i8*, i8** %a
	%_45 = load i8*, i8** %c
	%_46 = bitcast i8* %_45 to i32*
	%_47 = load i32, i32* %_46
	%_48 = icmp sge i32 1, 0
	%_49 = icmp slt i32 1, %_47
	%_50 = and i1 %_48, %_49
	br i1 %_50, label %L14, label %L15
L15:
	call void @throw_oob()
	br label %L14
L14:
	%_51 = add i32 4, 1
	%_52 = getelementptr i8, i8* %_45, i32 %_51
	%_53 = load i8, i8* %_52
	%_54 = trunc i8 %_53 to i1
	%_55 = bitcast i8* %_44 to i8***
	%_56 = load i8**, i8*** %_55
	%_57 = getelementptr i8*, i8** %_56, i32 1
	%_58 = load i8*, i8** %_57
	%_59 = bitcast i8* %_58 to i32 (i8*, i1)*
	%_60 = call i32 %_59(i8* %_44, i1 %_54)
	store i32 %_60, i32* %d

	%_61 = load i32, i32* %d
	call void (i32) @print_int(i32 %_61)

	%_62 = load i8*, i8** %a
	%_63 = load i8*, i8** %a
	%_64 = bitcast i8* %_63 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 0
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i8* (i8*)*
	%_69 = call i8* %_68(i8* %_63)
	%_70 = bitcast i8* %_69 to i32*
	%_71 = load i32, i32* %_70
	%_72 = icmp sge i32 2, 0
	%_73 = icmp slt i32 2, %_71
	%_74 = and i1 %_72, %_73
	br i1 %_74, label %L16, label %L17
L17:
	call void @throw_oob()
	br label %L16
L16:
	%_75 = add i32 4, 2
	%_76 = getelementptr i8, i8* %_69, i32 %_75
	%_77 = load i8, i8* %_76
	%_78 = trunc i8 %_77 to i1
	%_79 = bitcast i8* %_62 to i8***
	%_80 = load i8**, i8*** %_79
	%_81 = getelementptr i8*, i8** %_80, i32 1
	%_82 = load i8*, i8** %_81
	%_83 = bitcast i8* %_82 to i32 (i8*, i1)*
	%_84 = call i32 %_83(i8* %_62, i1 %_78)
	store i32 %_84, i32* %d

	%_85 = load i32, i32* %d
	call void (i32) @print_int(i32 %_85)

	%_86 = call i8* @calloc(i32 1, i32 21)
	%_87 = bitcast i8* %_86 to i8***
	%_88 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_88, i8*** %_87
	store i8* %_86, i8** %b

	%_89 = load i8*, i8** %b
	%_90 = bitcast i8* %_89 to i8***
	%_91 = load i8**, i8*** %_90
	%_92 = getelementptr i8*, i8** %_91, i32 0
	%_93 = load i8*, i8** %_92
	%_94 = bitcast i8* %_93 to i32 (i8*)*
	%_95 = call i32 %_94(i8* %_89)
	call void (i32) @print_int(i32 %_95)

	%_96 = load i8*, i8** %b
	%_97 = bitcast i8* %_96 to i8***
	%_98 = load i8**, i8*** %_97
	%_99 = getelementptr i8*, i8** %_98, i32 1
	%_100 = load i8*, i8** %_99
	%_101 = bitcast i8* %_100 to i32 (i8*)*
	%_102 = call i32 %_101(i8* %_96)
	call void (i32) @print_int(i32 %_102)

	%_103 = load i8*, i8** %b
	%_104 = bitcast i8* %_103 to i8***
	%_105 = load i8**, i8*** %_104
	%_106 = getelementptr i8*, i8** %_105, i32 2
	%_107 = load i8*, i8** %_106
	%_108 = bitcast i8* %_107 to i1 (i8*)*
	%_109 = call i1 %_108(i8* %_103)
	br i1 %_109, label %L18, label %L19
L18:
	store i32 1, i32* %d


	br label %L20
L19:
	store i32 0, i32* %d


	br label %L20
L20:

	%_110 = load i32, i32* %d
	call void (i32) @print_int(i32 %_110)

	%_123 = load i8*, i8** %c
	%_124 = bitcast i8* %_123 to i32*
	%_125 = load i32, i32* %_124
	%_126 = icmp sge i32 2, 0
	%_127 = icmp slt i32 2, %_125
	%_128 = and i1 %_127, %_128
	br i1 %_128, label %L23, label %L24
L24:
	call void @throw_oob()
	br label %L23
L23:
	%_129 = add i32 4, 2
	%_111 = load i8*, i8** %c
	%_112 = bitcast i8* %_111 to i32*
	%_113 = load i32, i32* %_112
	%_114 = icmp sge i32 1, 0
	%_115 = icmp slt i32 1, %_113
	%_116 = and i1 %_114, %_115
	br i1 %_116, label %L21, label %L22
L22:
	call void @throw_oob()
	br label %L21
L21:
	%_117 = add i32 4, 1
	%_118 = getelementptr i8, i8* %_111, i32 %_117
	%_119 = load i8, i8* %_118
	%_120 = trunc i8 %_119 to i1
	%_130 = zext i1 %_120 to i8
	%_131 = getelementptr i8, i8* %_123, i32 %_129
	store i8 %_130, i8* %_131

	ret i32 0
}

define i8* @A.foo(i8* %this) {
	%b = alloca i8*

	%_132 = add i32 4, 200
	%_133 = icmp sge i32 %_132, 4
	br i1 %_133, label %L25, label %L26
L26:
	call void @throw_nsz()
	br label %L25
L25:
	%_134 = call i8* @calloc(i32 1, i32 %_132)
	%_135 = bitcast i8* %_134 to i32*
	store i32 200, i32* %_135
	store i8* %_134, i8** %b

	%_138 = load i8*, i8** %b
	%_139 = bitcast i8* %_138 to i32*
	%_140 = load i32, i32* %_139
	%_141 = icmp sge i32 2, 0
	%_142 = icmp slt i32 2, %_140
	%_143 = and i1 %_142, %_143
	br i1 %_143, label %L27, label %L28
L28:
	call void @throw_oob()
	br label %L27
L27:
	%_144 = add i32 4, 2
	%_145 = zext i1 1 to i8
	%_146 = getelementptr i8, i8* %_138, i32 %_144
	store i8 %_145, i8* %_146

	%_147 = load i8*, i8** %b
	ret i8* %_147
}

define i32 @A.bar(i8* %this, i1 %.a) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%res = alloca i32

	%_148 = load i1, i1* %a
	br i1 %_148, label %L29, label %L30
L29:
	store i32 1, i32* %res


	br label %L31
L30:
	store i32 2, i32* %res


	br label %L31
L31:

	%_149 = load i32, i32* %res
	ret i32 %_149
}

define i8* @A.another(i8* %this) {

	%_150 = bitcast i8* %this to i8***
	%_151 = load i8**, i8*** %_150
	%_152 = getelementptr i8*, i8** %_151, i32 0
	%_153 = load i8*, i8** %_152
	%_154 = bitcast i8* %_153 to i8* (i8*)*
	%_155 = call i8* %_154(i8* %this)
	ret i8* %_155
}

define i32 @B.fill_arr(i8* %this) {
	%arr = alloca i8*
	%i = alloca i32
	%len = alloca i32

	store i32 100, i32* %len

	%_156 = load i32, i32* %len
	%_157 = add i32 4, %_156
	%_158 = icmp sge i32 %_157, 4
	br i1 %_158, label %L32, label %L33
L33:
	call void @throw_nsz()
	br label %L32
L32:
	%_159 = call i8* @calloc(i32 1, i32 %_157)
	%_160 = bitcast i8* %_159 to i32*
	store i32 %_156, i32* %_160
	store i8* %_159, i8** %arr

	store i32 0, i32* %i

	br label %L34
L34:
	%_161 = load i32, i32* %i
	%_162 = load i32, i32* %len
	%_163 = icmp slt i32 %_161, %_162
	br i1 %_163, label %L35, label %L36
L35:
	%_164 = load i32, i32* %i
	%_167 = load i8*, i8** %arr
	%_168 = bitcast i8* %_167 to i32*
	%_169 = load i32, i32* %_168
	%_170 = icmp sge i32 %_164, 0
	%_171 = icmp slt i32 %_164, %_169
	%_172 = and i1 %_171, %_172
	br i1 %_172, label %L37, label %L38
L38:
	call void @throw_oob()
	br label %L37
L37:
	%_173 = add i32 4, %_164
	%_174 = zext i1 1 to i8
	%_175 = getelementptr i8, i8* %_167, i32 %_173
	store i8 %_174, i8* %_175

	%_176 = load i32, i32* %i
	%_177 = add i32 %_176, 1
	store i32 %_177, i32* %i


	br label %L34
L36:

	%_178 = load i8*, i8** %arr
	%_179 = getelementptr i8, i8* %this, i32 12
	%_180 = bitcast i8* %_179 to i8**
	store i8* %_178, i8** %_180

	ret i32 0
}

define i32 @B.get_a(i8* %this) {

	%_182 = getelementptr i8, i8* %this, i32 8
	%_183 = bitcast i8* %_182 to i32*
	%_181 = load i32, i32* %_183
	ret i32 %_181
}

define i1 @B.get_c(i8* %this) {

	%_185 = getelementptr i8, i8* %this, i32 20
	%_186 = bitcast i8* %_185 to i1*
	%_184 = load i1, i1* %_186
	ret i1 %_184
}

