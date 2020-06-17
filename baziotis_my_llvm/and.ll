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
	%_11 = bitcast i8* %_3 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 2
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*, i1)*
	%_16 = call i1 %_15(i8* %_3, i1 %_10)
	store i1 %_16, i1* %dummy

	%_17 = load i8*, i8** %a
	%_18 = load i8*, i8** %a
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 0
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i1 (i8*, i1, i1, i1)*
	%_24 = call i1 %_23(i8* %_18, i1 0, i1 0, i1 1)
	%_25 = bitcast i8* %_17 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 2
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i1 (i8*, i1)*
	%_30 = call i1 %_29(i8* %_17, i1 %_24)
	store i1 %_30, i1* %dummy

	%_31 = load i8*, i8** %a
	%_32 = load i8*, i8** %a
	%_33 = bitcast i8* %_32 to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 0
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i1 (i8*, i1, i1, i1)*
	%_38 = call i1 %_37(i8* %_32, i1 0, i1 1, i1 0)
	%_39 = bitcast i8* %_31 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 2
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*, i1)*
	%_44 = call i1 %_43(i8* %_31, i1 %_38)
	store i1 %_44, i1* %dummy

	%_45 = load i8*, i8** %a
	%_46 = load i8*, i8** %a
	%_47 = bitcast i8* %_46 to i8***
	%_48 = load i8**, i8*** %_47
	%_49 = getelementptr i8*, i8** %_48, i32 0
	%_50 = load i8*, i8** %_49
	%_51 = bitcast i8* %_50 to i1 (i8*, i1, i1, i1)*
	%_52 = call i1 %_51(i8* %_46, i1 0, i1 1, i1 1)
	%_53 = bitcast i8* %_45 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 2
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*, i1)*
	%_58 = call i1 %_57(i8* %_45, i1 %_52)
	store i1 %_58, i1* %dummy

	%_59 = load i8*, i8** %a
	%_60 = load i8*, i8** %a
	%_61 = bitcast i8* %_60 to i8***
	%_62 = load i8**, i8*** %_61
	%_63 = getelementptr i8*, i8** %_62, i32 0
	%_64 = load i8*, i8** %_63
	%_65 = bitcast i8* %_64 to i1 (i8*, i1, i1, i1)*
	%_66 = call i1 %_65(i8* %_60, i1 1, i1 0, i1 0)
	%_67 = bitcast i8* %_59 to i8***
	%_68 = load i8**, i8*** %_67
	%_69 = getelementptr i8*, i8** %_68, i32 2
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1 (i8*, i1)*
	%_72 = call i1 %_71(i8* %_59, i1 %_66)
	store i1 %_72, i1* %dummy

	%_73 = load i8*, i8** %a
	%_74 = load i8*, i8** %a
	%_75 = bitcast i8* %_74 to i8***
	%_76 = load i8**, i8*** %_75
	%_77 = getelementptr i8*, i8** %_76, i32 0
	%_78 = load i8*, i8** %_77
	%_79 = bitcast i8* %_78 to i1 (i8*, i1, i1, i1)*
	%_80 = call i1 %_79(i8* %_74, i1 1, i1 0, i1 1)
	%_81 = bitcast i8* %_73 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 2
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*, i1)*
	%_86 = call i1 %_85(i8* %_73, i1 %_80)
	store i1 %_86, i1* %dummy

	%_87 = load i8*, i8** %a
	%_88 = load i8*, i8** %a
	%_89 = bitcast i8* %_88 to i8***
	%_90 = load i8**, i8*** %_89
	%_91 = getelementptr i8*, i8** %_90, i32 0
	%_92 = load i8*, i8** %_91
	%_93 = bitcast i8* %_92 to i1 (i8*, i1, i1, i1)*
	%_94 = call i1 %_93(i8* %_88, i1 1, i1 1, i1 0)
	%_95 = bitcast i8* %_87 to i8***
	%_96 = load i8**, i8*** %_95
	%_97 = getelementptr i8*, i8** %_96, i32 2
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i1 (i8*, i1)*
	%_100 = call i1 %_99(i8* %_87, i1 %_94)
	store i1 %_100, i1* %dummy

	%_101 = load i8*, i8** %a
	%_102 = load i8*, i8** %a
	%_103 = bitcast i8* %_102 to i8***
	%_104 = load i8**, i8*** %_103
	%_105 = getelementptr i8*, i8** %_104, i32 0
	%_106 = load i8*, i8** %_105
	%_107 = bitcast i8* %_106 to i1 (i8*, i1, i1, i1)*
	%_108 = call i1 %_107(i8* %_102, i1 1, i1 1, i1 1)
	%_109 = bitcast i8* %_101 to i8***
	%_110 = load i8**, i8*** %_109
	%_111 = getelementptr i8*, i8** %_110, i32 2
	%_112 = load i8*, i8** %_111
	%_113 = bitcast i8* %_112 to i1 (i8*, i1)*
	%_114 = call i1 %_113(i8* %_101, i1 %_108)
	store i1 %_114, i1* %dummy

	%_115 = load i8*, i8** %a
	%_116 = load i8*, i8** %a
	%_117 = bitcast i8* %_116 to i8***
	%_118 = load i8**, i8*** %_117
	%_119 = getelementptr i8*, i8** %_118, i32 1
	%_120 = load i8*, i8** %_119
	%_121 = bitcast i8* %_120 to i1 (i8*, i1, i1)*
	%_122 = call i1 %_121(i8* %_116, i1 1, i1 1)
	%_123 = bitcast i8* %_115 to i8***
	%_124 = load i8**, i8*** %_123
	%_125 = getelementptr i8*, i8** %_124, i32 2
	%_126 = load i8*, i8** %_125
	%_127 = bitcast i8* %_126 to i1 (i8*, i1)*
	%_128 = call i1 %_127(i8* %_115, i1 %_122)
	store i1 %_128, i1* %dummy

	%_129 = load i8*, i8** %a
	%_130 = load i8*, i8** %a
	%_131 = bitcast i8* %_130 to i8***
	%_132 = load i8**, i8*** %_131
	%_133 = getelementptr i8*, i8** %_132, i32 1
	%_134 = load i8*, i8** %_133
	%_135 = bitcast i8* %_134 to i1 (i8*, i1, i1)*
	%_136 = call i1 %_135(i8* %_130, i1 0, i1 1)
	%_137 = bitcast i8* %_129 to i8***
	%_138 = load i8**, i8*** %_137
	%_139 = getelementptr i8*, i8** %_138, i32 2
	%_140 = load i8*, i8** %_139
	%_141 = bitcast i8* %_140 to i1 (i8*, i1)*
	%_142 = call i1 %_141(i8* %_129, i1 %_136)
	store i1 %_142, i1* %dummy

	%_143 = load i8*, i8** %a
	%_144 = call i8* @calloc(i32 1, i32 8)
	%_145 = bitcast i8* %_144 to i8***
	%_146 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_146, i8*** %_145
	%_147 = bitcast i8* %_144 to i8***
	%_148 = load i8**, i8*** %_147
	%_149 = getelementptr i8*, i8** %_148, i32 0
	%_150 = load i8*, i8** %_149
	%_151 = bitcast i8* %_150 to i1 (i8*, i32)*
	%_152 = call i1 %_151(i8* %_144, i32 1)
	%_153 = bitcast i8* %_143 to i8***
	%_154 = load i8**, i8*** %_153
	%_155 = getelementptr i8*, i8** %_154, i32 2
	%_156 = load i8*, i8** %_155
	%_157 = bitcast i8* %_156 to i1 (i8*, i1)*
	%_158 = call i1 %_157(i8* %_143, i1 %_152)
	store i1 %_158, i1* %dummy

	%_159 = load i8*, i8** %a
	%_160 = call i8* @calloc(i32 1, i32 8)
	%_161 = bitcast i8* %_160 to i8***
	%_162 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_162, i8*** %_161
	%_163 = bitcast i8* %_160 to i8***
	%_164 = load i8**, i8*** %_163
	%_165 = getelementptr i8*, i8** %_164, i32 0
	%_166 = load i8*, i8** %_165
	%_167 = bitcast i8* %_166 to i1 (i8*, i32)*
	%_168 = call i1 %_167(i8* %_160, i32 2)
	%_169 = bitcast i8* %_159 to i8***
	%_170 = load i8**, i8*** %_169
	%_171 = getelementptr i8*, i8** %_170, i32 2
	%_172 = load i8*, i8** %_171
	%_173 = bitcast i8* %_172 to i1 (i8*, i1)*
	%_174 = call i1 %_173(i8* %_159, i1 %_168)
	store i1 %_174, i1* %dummy

	%_175 = load i8*, i8** %a
	%_176 = call i8* @calloc(i32 1, i32 8)
	%_177 = bitcast i8* %_176 to i8***
	%_178 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_178, i8*** %_177
	%_179 = bitcast i8* %_176 to i8***
	%_180 = load i8**, i8*** %_179
	%_181 = getelementptr i8*, i8** %_180, i32 1
	%_182 = load i8*, i8** %_181
	%_183 = bitcast i8* %_182 to i1 (i8*, i32, i32, i1, i1)*
	%_184 = call i1 %_183(i8* %_176, i32 2, i32 2, i1 1, i1 1)
	%_185 = bitcast i8* %_175 to i8***
	%_186 = load i8**, i8*** %_185
	%_187 = getelementptr i8*, i8** %_186, i32 2
	%_188 = load i8*, i8** %_187
	%_189 = bitcast i8* %_188 to i1 (i8*, i1)*
	%_190 = call i1 %_189(i8* %_175, i1 %_184)
	store i1 %_190, i1* %dummy

	ret i32 0
}

define i1 @A.foo(i8* %this, i1 %.a, i1 %.b, i1 %.c) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%b = alloca i1
	store i1 %.b, i1* %b
	%c = alloca i1
	store i1 %.c, i1* %c

	%_191 = load i1, i1* %a
	br i1 %_191, label %L1, label %L0
L0:
	br label %L3
L1:
	%_192 = load i1, i1* %b
	br label %L2
L2:
	br label %L3
L3:
	%_193 = phi i1 [0, %L0], [%_192, %L2]
	br i1 %_193, label %L5, label %L4
L4:
	br label %L7
L5:
	%_194 = load i1, i1* %c
	br label %L6
L6:
	br label %L7
L7:
	%_195 = phi i1 [0, %L4], [%_194, %L6]
	ret i1 %_195
}

define i1 @A.bar(i8* %this, i1 %.a, i1 %.b) {
	%a = alloca i1
	store i1 %.a, i1* %a
	%b = alloca i1
	store i1 %.b, i1* %b

	%_196 = load i1, i1* %a
	br i1 %_196, label %L9, label %L8
L8:
	br label %L11
L9:
	%_197 = load i1, i1* %a
	%_198 = load i1, i1* %b
	%_199 = bitcast i8* %this to i8***
	%_200 = load i8**, i8*** %_199
	%_201 = getelementptr i8*, i8** %_200, i32 0
	%_202 = load i8*, i8** %_201
	%_203 = bitcast i8* %_202 to i1 (i8*, i1, i1, i1)*
	%_204 = call i1 %_203(i8* %this, i1 %_197, i1 %_198, i1 1)
	br label %L10
L10:
	br label %L11
L11:
	%_205 = phi i1 [0, %L8], [%_204, %L10]
	br i1 %_205, label %L13, label %L12
L12:
	br label %L15
L13:
	%_206 = load i1, i1* %b
	br label %L14
L14:
	br label %L15
L15:
	%_207 = phi i1 [0, %L12], [%_206, %L14]
	ret i1 %_207
}

define i1 @A.print(i8* %this, i1 %.res) {
	%res = alloca i1
	store i1 %.res, i1* %res

	%_208 = load i1, i1* %res
	br i1 %_208, label %L16, label %L17
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

	%_209 = load i32, i32* %a
	%_210 = add i32 %_209, 2
	%_211 = icmp slt i32 3, %_210
	br i1 %_211, label %L19, label %L20
L19:
	br label %L21
L20:
	br label %L21
L21:
	%_212 = phi i1 [0, %L19], [1, %L20]
	br i1 %_212, label %L26, label %L25
L25:
	br label %L28
L26:
	br i1 0, label %L22, label %L23
L22:
	br label %L24
L23:
	br label %L24
L24:
	%_213 = phi i1 [0, %L22], [1, %L23]
	br label %L27
L27:
	br label %L28
L28:
	%_214 = phi i1 [0, %L25], [%_213, %L27]
	ret i1 %_214
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

	%_215 = load i32, i32* %a
	%_216 = load i32, i32* %b
	%_217 = icmp slt i32 %_215, %_216
	br i1 %_217, label %L29, label %L30
L29:
	br label %L31
L30:
	br label %L31
L31:
	%_218 = phi i1 [0, %L29], [1, %L30]
	br i1 %_218, label %L37, label %L36
L36:
	br label %L39
L37:
	%_219 = load i1, i1* %c
	br i1 %_219, label %L33, label %L32
L32:
	br label %L35
L33:
	%_220 = load i1, i1* %d
	br label %L34
L34:
	br label %L35
L35:
	%_221 = phi i1 [0, %L32], [%_220, %L34]
	br label %L38
L38:
	br label %L39
L39:
	%_222 = phi i1 [0, %L36], [%_221, %L38]
	ret i1 %_222
}

