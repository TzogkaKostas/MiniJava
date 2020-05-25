@.Main_vtable = global [0 x i8*] []

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
	%size = alloca i32
	%index = alloca i32
	%sum = alloca i32
	%int_array = alloca i32*
	%int_array_ref = alloca i32*
	%boolean_array = alloca i8*
	%flag = alloca i1

	store i32 1024, i32* %size

	%_0 = load i32, i32* %size
	%_1 = add i32 %_0, 1
	%_2 =  sub i32 %_1, 1
	%_3 = add i32 1, %_2
	%_4 = icmp sge i32 %_3, 1
	br i1 %_4, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_5 = call i8* @calloc(i32 %_3, i32 4)
	%_6 = bitcast i8* %_5 to i32*
	store i32 %_2, i32* %_6
	store i32* %_6, i32** %int_array

	%_7 = load i32*, i32** %int_array
	%_9 = load i32, i32* %_7
	%_10 = load i32, i32* %size
	%_11 = icmp slt i32 %_9, %_10
	br i1 %_11, label %L2, label %L3
L2:
	br label %L4
L3:
	br label %L4
L4:
	%_12 = phi i1 [0, %L2], [1, %L3]
	br i1 %_12, label %L9, label %L8
L8:
	br label %L11
L9:
	%_13 = load i32, i32* %size
	%_14 = load i32*, i32** %int_array
	%_16 = load i32, i32* %_14
	%_17 = icmp slt i32 %_13, %_16
	br i1 %_17, label %L5, label %L6
L5:
	br label %L7
L6:
	br label %L7
L7:
	%_18 = phi i1 [0, %L5], [1, %L6]
	br label %L10
L10:
	br label %L11
L11:
	%_19 = phi i1 [0, %L8], [%_18, %L10]
	br i1 %_19, label %L12, label %L13
L12:
	%_20 = load i32*, i32** %int_array
	%_22 = load i32, i32* %_20
	call void (i32) @print_int(i32 %_22)


	br label %L14
L13:
	call void (i32) @print_int(i32 2020)


	br label %L14
L14:

	%_23 = load i32, i32* %size
	%_24 = add i32 %_23, 1
	%_25 =  sub i32 %_24, 1
	%_26 = add i32 4, %_25
	%_27 = icmp sge i32 %_26, 4
	br i1 %_27, label %L15, label %L16
L16:
	call void @throw_nsz()
	br label %L15
L15:
	%_28 = call i8* @calloc(i32 1, i32 %_26)
	%_29 = bitcast i8* %_28 to i32*
	store i32 %_25, i32* %_29
	store i8* %_28, i8** %boolean_array

	%_30 = load i8*, i8** %boolean_array
	%_31 = bitcast i8* %_30 to i32*	%_32 = load i32, i32* %_31
	%_33 = load i32, i32* %size
	%_34 = icmp slt i32 %_32, %_33
	br i1 %_34, label %L17, label %L18
L17:
	br label %L19
L18:
	br label %L19
L19:
	%_35 = phi i1 [0, %L17], [1, %L18]
	br i1 %_35, label %L24, label %L23
L23:
	br label %L26
L24:
	%_36 = load i32, i32* %size
	%_37 = load i8*, i8** %boolean_array
	%_38 = bitcast i8* %_37 to i32*	%_39 = load i32, i32* %_38
	%_40 = icmp slt i32 %_36, %_39
	br i1 %_40, label %L20, label %L21
L20:
	br label %L22
L21:
	br label %L22
L22:
	%_41 = phi i1 [0, %L20], [1, %L21]
	br label %L25
L25:
	br label %L26
L26:
	%_42 = phi i1 [0, %L23], [%_41, %L25]
	br i1 %_42, label %L27, label %L28
L27:
	%_43 = load i8*, i8** %boolean_array
	%_44 = bitcast i8* %_43 to i32*	%_45 = load i32, i32* %_44
	call void (i32) @print_int(i32 %_45)


	br label %L29
L28:
	call void (i32) @print_int(i32 2020)


	br label %L29
L29:

	store i32 0, i32* %index

	br label %L30
L30:
	%_46 = load i32, i32* %index
	%_47 = load i32*, i32** %int_array
	%_49 = load i32, i32* %_47
	%_50 = icmp slt i32 %_46, %_49
	br i1 %_50, label %L31, label %L32
L31:
	%_51 = load i32, i32* %index
	%_56 = load i32*, i32** %int_array
	%_58 = load i32, i32* %_56
	%_59 = icmp sge i32 %_51, 0
	%_60 = icmp slt i32 %_51, %_58
	%_61 = and i1 %_60, %_61
	br i1 %_61, label %L33, label %L34
L34:
	call void @throw_oob()
	br label %L33
L33:
	%_62 = add i32 1, %_51
	%_52 = load i32, i32* %index
	%_53 =  mul i32 %_52, 2
	%_64 = getelementptr i32, i32* %_56, i32 %_62
	store i32 %_53, i32* %_64

	%_65 = load i32, i32* %index
	%_66 = add i32 %_65, 1
	store i32 %_66, i32* %index


	br label %L30
L32:

	store i32 0, i32* %index

	%_67 = load i32*, i32** %int_array
	store i32* %_67, i32** %int_array_ref

	store i32 0, i32* %sum

	br label %L35
L35:
	%_68 = load i32, i32* %index
	%_69 = load i32*, i32** %int_array_ref
	%_71 = load i32, i32* %_69
	%_72 = icmp slt i32 %_68, %_71
	br i1 %_72, label %L36, label %L37
L36:
	%_73 = load i32*, i32** %int_array_ref
	%_74 = load i32, i32* %index
	%_76 = load i32, i32* %_73
	%_77 = icmp sge i32 %_74, 0
	%_78 = icmp slt i32 %_74, %_76
	%_79 = and i1 %_77, %_78
	br i1 %_79, label %L38, label %L39
L39:
	call void @throw_oob()
	br label %L38
L38:
	%_80 = add i32 1, %_74
	%_81 = getelementptr i32, i32* %_73, i32 %_80
	%_82 = load i32, i32* %_81
	%_84 = load i32, i32* %sum
	%_85 = add i32 %_82, %_84
	store i32 %_85, i32* %sum

	%_86 = load i32, i32* %index
	%_87 = add i32 %_86, 1
	store i32 %_87, i32* %index


	br label %L35
L37:

	%_88 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_88)

	store i32 0, i32* %index

	store i1 1, i1* %flag

	br label %L40
L40:
	%_89 = load i32, i32* %index
	%_90 = load i8*, i8** %boolean_array
	%_91 = bitcast i8* %_90 to i32*	%_92 = load i32, i32* %_91
	%_93 = icmp slt i32 %_89, %_92
	br i1 %_93, label %L41, label %L42
L41:
	%_94 = load i32, i32* %index
	%_98 = load i8*, i8** %boolean_array
	%_99 = bitcast i8* %_98 to i32*
	%_100 = load i32, i32* %_99
	%_101 = icmp sge i32 %_94, 0
	%_102 = icmp slt i32 %_94, %_100
	%_103 = and i1 %_102, %_103
	br i1 %_103, label %L43, label %L44
L44:
	call void @throw_oob()
	br label %L43
L43:
	%_104 = add i32 4, %_94
	%_95 = load i1, i1* %flag
	%_105 = zext i1 %_95 to i8	%_106 = getelementptr i8, i8* %_98, i32 %_104
	store i8 %_95, i8* %_106

	%_107 = load i1, i1* %flag
	br i1 %_107, label %L45, label %L46
L45:
	br label %L47
L46:
	br label %L47
L47:
	%_108 = phi i1 [0, %L45], [1, %L46]
	store i1 %_108, i1* %flag

	%_109 = load i32, i32* %index
	%_110 = add i32 %_109, 1
	store i32 %_110, i32* %index


	br label %L40
L42:

	store i32 0, i32* %index

	store i32 0, i32* %sum

	br label %L48
L48:
	%_111 = load i32, i32* %index
	%_112 = load i8*, i8** %boolean_array
	%_113 = bitcast i8* %_112 to i32*	%_114 = load i32, i32* %_113
	%_115 = icmp slt i32 %_111, %_114
	br i1 %_115, label %L49, label %L50
L49:
	%_116 = load i8*, i8** %boolean_array
	%_117 = load i32, i32* %index
	%_118 = bitcast i8* %_116 to i32*	%_119 = load i32, i32* %_118
	%_120 = icmp sge i32 %_117, 0
	%_121 = icmp slt i32 %_117, %_119
	%_122 = and i1 %_120, %_121
	br i1 %_122, label %L51, label %L52
L52:
	call void @throw_oob()
	br label %L51
L51:
	%_123 = add i32 1, %_117
	%_124 = getelementptr i8, i8* %_116, i32 %_123
	%_125 = load i8, i8* %_124
	%_126 = trunc i8 %_125 to i1
	br i1 %_126, label %L53, label %L54
L53:
	%_127 = load i32, i32* %sum
	%_128 = add i32 %_127, 1
	store i32 %_128, i32* %sum


	br label %L55
L54:
	%_129 = load i32, i32* %sum
	%_130 = add i32 %_129, 10
	store i32 %_130, i32* %sum


	br label %L55
L55:

	%_131 = load i32, i32* %index
	%_132 = add i32 %_131, 1
	store i32 %_132, i32* %index


	br label %L48
L50:

	%_133 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_133)

	ret i32 0
}

