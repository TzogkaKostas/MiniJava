@.Main_vtable = global [0 x i8*] []

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i1 (i8*)* @A.set_x to i8*),
	i8* bitcast (i32 (i8*)* @A.x to i8*),
	i8* bitcast (i32 (i8*)* @A.y to i8*)
]

@.B_vtable = global [3 x i8*] [
	i8* bitcast (i1 (i8*)* @B.set_x to i8*),
	i8* bitcast (i32 (i8*)* @B.x to i8*),
	i8* bitcast (i32 (i8*)* @A.y to i8*)
]

@.C_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*)* @C.get_class_x to i8*),
	i8* bitcast (i32 (i8*)* @C.get_method_x to i8*),
	i8* bitcast (i1 (i8*)* @C.set_int_x to i8*)
]

@.D_vtable = global [4 x i8*] [
	i8* bitcast (i32 (i8*)* @C.get_class_x to i8*),
	i8* bitcast (i32 (i8*)* @C.get_method_x to i8*),
	i8* bitcast (i1 (i8*)* @C.set_int_x to i8*),
	i8* bitcast (i1 (i8*)* @D.get_class_x2 to i8*)
]

@.E_vtable = global [6 x i8*] [
	i8* bitcast (i32 (i8*)* @C.get_class_x to i8*),
	i8* bitcast (i32 (i8*)* @C.get_method_x to i8*),
	i8* bitcast (i1 (i8*)* @C.set_int_x to i8*),
	i8* bitcast (i1 (i8*)* @D.get_class_x2 to i8*),
	i8* bitcast (i1 (i8*)* @E.set_bool_x to i8*),
	i8* bitcast (i1 (i8*)* @E.get_bool_x to i8*)
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
	%c = alloca i8*
	%d = alloca i8*
	%e = alloca i8*
	%dummy = alloca i1

	%_0 = call i8* @calloc(i32 1, i32 16)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = load i8*, i8** %a
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	store i1 %_9, i1* %dummy

	%_11 = load i8*, i8** %a
	%_12 = bitcast i8* %_11 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 1
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i32 (i8*)*
	%_17 = call i32 %_16(i8* %_11)
	call void (i32) @print_int(i32 %_17)

	%_19 = load i8*, i8** %a
	%_20 = bitcast i8* %_19 to i8***
	%_21 = load i8**, i8*** %_20
	%_22 = getelementptr i8*, i8** %_21, i32 2
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i32 (i8*)*
	%_25 = call i32 %_24(i8* %_19)
	call void (i32) @print_int(i32 %_25)

	%_27 = call i8* @calloc(i32 1, i32 20)
	%_28 = bitcast i8* %_27 to i8***
	%_29 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_29, i8*** %_28
	store i8* %_27, i8** %a

	%_30 = load i8*, i8** %a
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 0
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i1 (i8*)*
	%_36 = call i1 %_35(i8* %_30)
	store i1 %_36, i1* %dummy

	%_38 = load i8*, i8** %a
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 1
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i32 (i8*)*
	%_44 = call i32 %_43(i8* %_38)
	call void (i32) @print_int(i32 %_44)

	%_46 = load i8*, i8** %a
	%_47 = bitcast i8* %_46 to i8***
	%_48 = load i8**, i8*** %_47
	%_49 = getelementptr i8*, i8** %_48, i32 2
	%_50 = load i8*, i8** %_49
	%_51 = bitcast i8* %_50 to i32 (i8*)*
	%_52 = call i32 %_51(i8* %_46)
	call void (i32) @print_int(i32 %_52)

	%_54 = call i8* @calloc(i32 1, i32 12)
	%_55 = bitcast i8* %_54 to i8***
	%_56 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_56, i8*** %_55
	store i8* %_54, i8** %c

	%_57 = load i8*, i8** %c
	%_58 = bitcast i8* %_57 to i8***
	%_59 = load i8**, i8*** %_58
	%_60 = getelementptr i8*, i8** %_59, i32 1
	%_61 = load i8*, i8** %_60
	%_62 = bitcast i8* %_61 to i32 (i8*)*
	%_63 = call i32 %_62(i8* %_57)
	call void (i32) @print_int(i32 %_63)

	%_65 = load i8*, i8** %c
	%_66 = bitcast i8* %_65 to i8***
	%_67 = load i8**, i8*** %_66
	%_68 = getelementptr i8*, i8** %_67, i32 0
	%_69 = load i8*, i8** %_68
	%_70 = bitcast i8* %_69 to i32 (i8*)*
	%_71 = call i32 %_70(i8* %_65)
	call void (i32) @print_int(i32 %_71)

	%_73 = call i8* @calloc(i32 1, i32 13)
	%_74 = bitcast i8* %_73 to i8***
	%_75 = getelementptr [4 x i8*], [4 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_75, i8*** %_74
	store i8* %_73, i8** %d

	%_76 = load i8*, i8** %d
	%_77 = bitcast i8* %_76 to i8***
	%_78 = load i8**, i8*** %_77
	%_79 = getelementptr i8*, i8** %_78, i32 2
	%_80 = load i8*, i8** %_79
	%_81 = bitcast i8* %_80 to i1 (i8*)*
	%_82 = call i1 %_81(i8* %_76)
	store i1 %_82, i1* %dummy

	%_84 = load i8*, i8** %d
	%_85 = bitcast i8* %_84 to i8***
	%_86 = load i8**, i8*** %_85
	%_87 = getelementptr i8*, i8** %_86, i32 3
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1 (i8*)*
	%_90 = call i1 %_89(i8* %_84)
	br i1 %_90, label %L0, label %L1
L0:
	call void (i32) @print_int(i32 1)


	br label %L2
L1:
	call void (i32) @print_int(i32 0)


	br label %L2
L2:

	%_92 = call i8* @calloc(i32 1, i32 14)
	%_93 = bitcast i8* %_92 to i8***
	%_94 = getelementptr [6 x i8*], [6 x i8*]* @.E_vtable, i32 0, i32 0
	store i8** %_94, i8*** %_93
	store i8* %_92, i8** %e

	%_95 = load i8*, i8** %e
	%_96 = bitcast i8* %_95 to i8***
	%_97 = load i8**, i8*** %_96
	%_98 = getelementptr i8*, i8** %_97, i32 2
	%_99 = load i8*, i8** %_98
	%_100 = bitcast i8* %_99 to i1 (i8*)*
	%_101 = call i1 %_100(i8* %_95)
	store i1 %_101, i1* %dummy

	%_103 = load i8*, i8** %e
	%_104 = bitcast i8* %_103 to i8***
	%_105 = load i8**, i8*** %_104
	%_106 = getelementptr i8*, i8** %_105, i32 3
	%_107 = load i8*, i8** %_106
	%_108 = bitcast i8* %_107 to i1 (i8*)*
	%_109 = call i1 %_108(i8* %_103)
	br i1 %_109, label %L3, label %L4
L3:
	call void (i32) @print_int(i32 1)


	br label %L5
L4:
	call void (i32) @print_int(i32 0)


	br label %L5
L5:

	%_111 = load i8*, i8** %e
	%_112 = bitcast i8* %_111 to i8***
	%_113 = load i8**, i8*** %_112
	%_114 = getelementptr i8*, i8** %_113, i32 4
	%_115 = load i8*, i8** %_114
	%_116 = bitcast i8* %_115 to i1 (i8*)*
	%_117 = call i1 %_116(i8* %_111)
	store i1 %_117, i1* %dummy

	%_119 = load i8*, i8** %e
	%_120 = bitcast i8* %_119 to i8***
	%_121 = load i8**, i8*** %_120
	%_122 = getelementptr i8*, i8** %_121, i32 5
	%_123 = load i8*, i8** %_122
	%_124 = bitcast i8* %_123 to i1 (i8*)*
	%_125 = call i1 %_124(i8* %_119)
	br i1 %_125, label %L6, label %L7
L6:
	call void (i32) @print_int(i32 1)


	br label %L8
L7:
	call void (i32) @print_int(i32 0)


	br label %L8
L8:

	ret i32 0
}

define i1 @A.set_x(i8* %this) {

	%_127 = getelementptr i8, i8* %this, i32 8
	%_128 = bitcast i8* %_127 to i32*
	store i32 1, i32* %_128

	ret i1 1
}

define i32 @A.x(i8* %this) {

	%_130 = getelementptr i8, i8* %this, i32 8
	%_131 = bitcast i8* %_130 to i32*
	%_129 = load i32, i32* %_131
	ret i32 %_129
}

define i32 @A.y(i8* %this) {

	%_133 = getelementptr i8, i8* %this, i32 12
	%_134 = bitcast i8* %_133 to i32*
	%_132 = load i32, i32* %_134
	ret i32 %_132
}

define i1 @B.set_x(i8* %this) {

	%_135 = getelementptr i8, i8* %this, i32 16
	%_136 = bitcast i8* %_135 to i32*
	store i32 2, i32* %_136

	ret i1 1
}

define i32 @B.x(i8* %this) {

	%_138 = getelementptr i8, i8* %this, i32 16
	%_139 = bitcast i8* %_138 to i32*
	%_137 = load i32, i32* %_139
	ret i32 %_137
}

define i32 @C.get_class_x(i8* %this) {

	%_141 = getelementptr i8, i8* %this, i32 8
	%_142 = bitcast i8* %_141 to i32*
	%_140 = load i32, i32* %_142
	ret i32 %_140
}

define i32 @C.get_method_x(i8* %this) {
	%x = alloca i32

	%_143 = getelementptr i8, i8* %this, i32 8
	%_144 = bitcast i8* %_143 to i32*
	store i32 3, i32* %_144

	%_146 = getelementptr i8, i8* %this, i32 8
	%_147 = bitcast i8* %_146 to i32*
	%_145 = load i32, i32* %_147
	ret i32 %_145
}

define i1 @C.set_int_x(i8* %this) {

	%_148 = getelementptr i8, i8* %this, i32 8
	%_149 = bitcast i8* %_148 to i32*
	store i32 20, i32* %_149

	ret i1 1
}

define i1 @D.get_class_x2(i8* %this) {

	%_151 = getelementptr i8, i8* %this, i32 12
	%_152 = bitcast i8* %_151 to i1*
	%_150 = load i1, i1* %_152
	ret i1 %_150
}

define i1 @E.set_bool_x(i8* %this) {

	%_153 = getelementptr i8, i8* %this, i32 13
	%_154 = bitcast i8* %_153 to i1*
	store i1 1, i1* %_154

	ret i1 1
}

define i1 @E.get_bool_x(i8* %this) {

	%_156 = getelementptr i8, i8* %this, i32 13
	%_157 = bitcast i8* %_156 to i1*
	%_155 = load i1, i1* %_157
	ret i1 %_155
}

