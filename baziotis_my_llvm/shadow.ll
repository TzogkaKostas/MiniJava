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

	%_10 = load i8*, i8** %a
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 1
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i32 (i8*)*
	%_16 = call i32 %_15(i8* %_10)
	call void (i32) @print_int(i32 %_16)

	%_17 = load i8*, i8** %a
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 2
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32 (i8*)*
	%_23 = call i32 %_22(i8* %_17)
	call void (i32) @print_int(i32 %_23)

	%_24 = call i8* @calloc(i32 1, i32 20)
	%_25 = bitcast i8* %_24 to i8***
	%_26 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
	store i8** %_26, i8*** %_25
	store i8* %_24, i8** %a

	%_27 = load i8*, i8** %a
	%_28 = bitcast i8* %_27 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 0
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i1 (i8*)*
	%_33 = call i1 %_32(i8* %_27)
	store i1 %_33, i1* %dummy

	%_34 = load i8*, i8** %a
	%_35 = bitcast i8* %_34 to i8***
	%_36 = load i8**, i8*** %_35
	%_37 = getelementptr i8*, i8** %_36, i32 1
	%_38 = load i8*, i8** %_37
	%_39 = bitcast i8* %_38 to i32 (i8*)*
	%_40 = call i32 %_39(i8* %_34)
	call void (i32) @print_int(i32 %_40)

	%_41 = load i8*, i8** %a
	%_42 = bitcast i8* %_41 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 2
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i32 (i8*)*
	%_47 = call i32 %_46(i8* %_41)
	call void (i32) @print_int(i32 %_47)

	%_48 = call i8* @calloc(i32 1, i32 12)
	%_49 = bitcast i8* %_48 to i8***
	%_50 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_50, i8*** %_49
	store i8* %_48, i8** %c

	%_51 = load i8*, i8** %c
	%_52 = bitcast i8* %_51 to i8***
	%_53 = load i8**, i8*** %_52
	%_54 = getelementptr i8*, i8** %_53, i32 1
	%_55 = load i8*, i8** %_54
	%_56 = bitcast i8* %_55 to i32 (i8*)*
	%_57 = call i32 %_56(i8* %_51)
	call void (i32) @print_int(i32 %_57)

	%_58 = load i8*, i8** %c
	%_59 = bitcast i8* %_58 to i8***
	%_60 = load i8**, i8*** %_59
	%_61 = getelementptr i8*, i8** %_60, i32 0
	%_62 = load i8*, i8** %_61
	%_63 = bitcast i8* %_62 to i32 (i8*)*
	%_64 = call i32 %_63(i8* %_58)
	call void (i32) @print_int(i32 %_64)

	%_65 = call i8* @calloc(i32 1, i32 13)
	%_66 = bitcast i8* %_65 to i8***
	%_67 = getelementptr [4 x i8*], [4 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_67, i8*** %_66
	store i8* %_65, i8** %d

	%_68 = load i8*, i8** %d
	%_69 = bitcast i8* %_68 to i8***
	%_70 = load i8**, i8*** %_69
	%_71 = getelementptr i8*, i8** %_70, i32 2
	%_72 = load i8*, i8** %_71
	%_73 = bitcast i8* %_72 to i1 (i8*)*
	%_74 = call i1 %_73(i8* %_68)
	store i1 %_74, i1* %dummy

	%_75 = load i8*, i8** %d
	%_76 = bitcast i8* %_75 to i8***
	%_77 = load i8**, i8*** %_76
	%_78 = getelementptr i8*, i8** %_77, i32 3
	%_79 = load i8*, i8** %_78
	%_80 = bitcast i8* %_79 to i1 (i8*)*
	%_81 = call i1 %_80(i8* %_75)
	br i1 %_81, label %L0, label %L1
L0:
	call void (i32) @print_int(i32 1)


	br label %L2
L1:
	call void (i32) @print_int(i32 0)


	br label %L2
L2:

	%_82 = call i8* @calloc(i32 1, i32 14)
	%_83 = bitcast i8* %_82 to i8***
	%_84 = getelementptr [6 x i8*], [6 x i8*]* @.E_vtable, i32 0, i32 0
	store i8** %_84, i8*** %_83
	store i8* %_82, i8** %e

	%_85 = load i8*, i8** %e
	%_86 = bitcast i8* %_85 to i8***
	%_87 = load i8**, i8*** %_86
	%_88 = getelementptr i8*, i8** %_87, i32 2
	%_89 = load i8*, i8** %_88
	%_90 = bitcast i8* %_89 to i1 (i8*)*
	%_91 = call i1 %_90(i8* %_85)
	store i1 %_91, i1* %dummy

	%_92 = load i8*, i8** %e
	%_93 = bitcast i8* %_92 to i8***
	%_94 = load i8**, i8*** %_93
	%_95 = getelementptr i8*, i8** %_94, i32 3
	%_96 = load i8*, i8** %_95
	%_97 = bitcast i8* %_96 to i1 (i8*)*
	%_98 = call i1 %_97(i8* %_92)
	br i1 %_98, label %L3, label %L4
L3:
	call void (i32) @print_int(i32 1)


	br label %L5
L4:
	call void (i32) @print_int(i32 0)


	br label %L5
L5:

	%_99 = load i8*, i8** %e
	%_100 = bitcast i8* %_99 to i8***
	%_101 = load i8**, i8*** %_100
	%_102 = getelementptr i8*, i8** %_101, i32 4
	%_103 = load i8*, i8** %_102
	%_104 = bitcast i8* %_103 to i1 (i8*)*
	%_105 = call i1 %_104(i8* %_99)
	store i1 %_105, i1* %dummy

	%_106 = load i8*, i8** %e
	%_107 = bitcast i8* %_106 to i8***
	%_108 = load i8**, i8*** %_107
	%_109 = getelementptr i8*, i8** %_108, i32 5
	%_110 = load i8*, i8** %_109
	%_111 = bitcast i8* %_110 to i1 (i8*)*
	%_112 = call i1 %_111(i8* %_106)
	br i1 %_112, label %L6, label %L7
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

	%_113 = getelementptr i8, i8* %this, i32 8
	%_114 = bitcast i8* %_113 to i32*
	store i32 1, i32* %_114

	ret i1 1
}

define i32 @A.x(i8* %this) {

	%_116 = getelementptr i8, i8* %this, i32 8
	%_117 = bitcast i8* %_116 to i32*
	%_115 = load i32, i32* %_117
	ret i32 %_115
}

define i32 @A.y(i8* %this) {

	%_119 = getelementptr i8, i8* %this, i32 12
	%_120 = bitcast i8* %_119 to i32*
	%_118 = load i32, i32* %_120
	ret i32 %_118
}

define i1 @B.set_x(i8* %this) {

	%_121 = getelementptr i8, i8* %this, i32 16
	%_122 = bitcast i8* %_121 to i32*
	store i32 2, i32* %_122

	ret i1 1
}

define i32 @B.x(i8* %this) {

	%_124 = getelementptr i8, i8* %this, i32 16
	%_125 = bitcast i8* %_124 to i32*
	%_123 = load i32, i32* %_125
	ret i32 %_123
}

define i32 @C.get_class_x(i8* %this) {

	%_127 = getelementptr i8, i8* %this, i32 8
	%_128 = bitcast i8* %_127 to i32*
	%_126 = load i32, i32* %_128
	ret i32 %_126
}

define i32 @C.get_method_x(i8* %this) {
	%x = alloca i32

	store i32 3, i32* %x

	%_129 = load i32, i32* %x
	ret i32 %_129
}

define i1 @C.set_int_x(i8* %this) {

	%_130 = getelementptr i8, i8* %this, i32 8
	%_131 = bitcast i8* %_130 to i32*
	store i32 20, i32* %_131

	ret i1 1
}

define i1 @D.get_class_x2(i8* %this) {

	%_133 = getelementptr i8, i8* %this, i32 12
	%_134 = bitcast i8* %_133 to i1*
	%_132 = load i1, i1* %_134
	ret i1 %_132
}

define i1 @E.set_bool_x(i8* %this) {

	%_135 = getelementptr i8, i8* %this, i32 13
	%_136 = bitcast i8* %_135 to i1*
	store i1 1, i1* %_136

	ret i1 1
}

define i1 @E.get_bool_x(i8* %this) {

	%_138 = getelementptr i8, i8* %this, i32 13
	%_139 = bitcast i8* %_138 to i1*
	%_137 = load i1, i1* %_139
	ret i1 %_137
}

