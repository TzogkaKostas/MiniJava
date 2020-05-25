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
	%flag = alloca i1

	br i1 1, label %L0, label %L1
L0:
	br i1 1, label %L3, label %L4
L3:
	br i1 1, label %L6, label %L7
L6:
	br i1 1, label %L9, label %L10
L9:
	br i1 1, label %L12, label %L13
L12:
	call void (i32) @print_int(i32 1)


	br label %L14
L13:
	call void (i32) @print_int(i32 0)


	br label %L14
L14:

	call void (i32) @print_int(i32 2)


	br label %L11
L10:
	call void (i32) @print_int(i32 0)


	br label %L11
L11:

	call void (i32) @print_int(i32 3)


	br label %L8
L7:
	call void (i32) @print_int(i32 0)


	br label %L8
L8:

	call void (i32) @print_int(i32 4)


	br label %L5
L4:
	call void (i32) @print_int(i32 0)


	br label %L5
L5:

	call void (i32) @print_int(i32 5)


	br label %L2
L1:
	call void (i32) @print_int(i32 0)


	br label %L2
L2:

	br i1 1, label %L16, label %L15
L15:
	br label %L18
L16:
	br label %L17
L17:
	br label %L18
L18:
	%_0 = phi i1 [0, %L15], [1, %L17]
	br i1 %_0, label %L30, label %L29
L29:
	br label %L32
L30:
	br i1 0, label %L19, label %L20
L19:
	br label %L21
L20:
	br label %L21
L21:
	%_1 = phi i1 [0, %L19], [1, %L20]
	br i1 %_1, label %L26, label %L25
L25:
	br label %L28
L26:
	br i1 0, label %L22, label %L23
L22:
	br label %L24
L23:
	br label %L24
L24:
	%_2 = phi i1 [0, %L22], [1, %L23]
	br label %L27
L27:
	br label %L28
L28:
	%_3 = phi i1 [0, %L25], [%_2, %L27]
	br label %L31
L31:
	br label %L32
L32:
	%_4 = phi i1 [0, %L29], [%_3, %L31]
	br i1 %_4, label %L34, label %L33
L33:
	br label %L36
L34:
	%_5 = icmp slt i32 100, 1000
	br label %L35
L35:
	br label %L36
L36:
	%_6 = phi i1 [0, %L33], [%_5, %L35]
	store i1 %_6, i1* %flag

	br i1 1, label %L38, label %L37
L37:
	br label %L40
L38:
	%_7 = load i1, i1* %flag
	br label %L39
L39:
	br label %L40
L40:
	%_8 = phi i1 [0, %L37], [%_7, %L39]
	br i1 %_8, label %L52, label %L51
L51:
	br label %L54
L52:
	br i1 0, label %L41, label %L42
L41:
	br label %L43
L42:
	br label %L43
L43:
	%_9 = phi i1 [0, %L41], [1, %L42]
	br i1 %_9, label %L48, label %L47
L47:
	br label %L50
L48:
	br i1 0, label %L44, label %L45
L44:
	br label %L46
L45:
	br label %L46
L46:
	%_10 = phi i1 [0, %L44], [1, %L45]
	br label %L49
L49:
	br label %L50
L50:
	%_11 = phi i1 [0, %L47], [%_10, %L49]
	br label %L53
L53:
	br label %L54
L54:
	%_12 = phi i1 [0, %L51], [%_11, %L53]
	br i1 %_12, label %L55, label %L56
L55:
	br i1 1, label %L59, label %L58
L58:
	br label %L61
L59:
	%_13 = load i1, i1* %flag
	br label %L60
L60:
	br label %L61
L61:
	%_14 = phi i1 [0, %L58], [%_13, %L60]
	br i1 %_14, label %L73, label %L72
L72:
	br label %L75
L73:
	br i1 0, label %L62, label %L63
L62:
	br label %L64
L63:
	br label %L64
L64:
	%_15 = phi i1 [0, %L62], [1, %L63]
	br i1 %_15, label %L69, label %L68
L68:
	br label %L71
L69:
	br i1 0, label %L65, label %L66
L65:
	br label %L67
L66:
	br label %L67
L67:
	%_16 = phi i1 [0, %L65], [1, %L66]
	br label %L70
L70:
	br label %L71
L71:
	%_17 = phi i1 [0, %L68], [%_16, %L70]
	br label %L74
L74:
	br label %L75
L75:
	%_18 = phi i1 [0, %L72], [%_17, %L74]
	br i1 %_18, label %L76, label %L77
L76:
	br i1 1, label %L80, label %L79
L79:
	br label %L82
L80:
	%_19 = load i1, i1* %flag
	br label %L81
L81:
	br label %L82
L82:
	%_20 = phi i1 [0, %L79], [%_19, %L81]
	br i1 %_20, label %L94, label %L93
L93:
	br label %L96
L94:
	br i1 0, label %L83, label %L84
L83:
	br label %L85
L84:
	br label %L85
L85:
	%_21 = phi i1 [0, %L83], [1, %L84]
	br i1 %_21, label %L90, label %L89
L89:
	br label %L92
L90:
	br i1 0, label %L86, label %L87
L86:
	br label %L88
L87:
	br label %L88
L88:
	%_22 = phi i1 [0, %L86], [1, %L87]
	br label %L91
L91:
	br label %L92
L92:
	%_23 = phi i1 [0, %L89], [%_22, %L91]
	br label %L95
L95:
	br label %L96
L96:
	%_24 = phi i1 [0, %L93], [%_23, %L95]
	br i1 %_24, label %L97, label %L98
L97:
	br i1 1, label %L101, label %L100
L100:
	br label %L103
L101:
	%_25 = load i1, i1* %flag
	br label %L102
L102:
	br label %L103
L103:
	%_26 = phi i1 [0, %L100], [%_25, %L102]
	br i1 %_26, label %L115, label %L114
L114:
	br label %L117
L115:
	br i1 0, label %L104, label %L105
L104:
	br label %L106
L105:
	br label %L106
L106:
	%_27 = phi i1 [0, %L104], [1, %L105]
	br i1 %_27, label %L111, label %L110
L110:
	br label %L113
L111:
	br i1 0, label %L107, label %L108
L107:
	br label %L109
L108:
	br label %L109
L109:
	%_28 = phi i1 [0, %L107], [1, %L108]
	br label %L112
L112:
	br label %L113
L113:
	%_29 = phi i1 [0, %L110], [%_28, %L112]
	br label %L116
L116:
	br label %L117
L117:
	%_30 = phi i1 [0, %L114], [%_29, %L116]
	br i1 %_30, label %L118, label %L119
L118:
	%_31 = load i1, i1* %flag
	br i1 %_31, label %L122, label %L121
L121:
	br label %L124
L122:
	%_32 = load i1, i1* %flag
	br label %L123
L123:
	br label %L124
L124:
	%_33 = phi i1 [0, %L121], [%_32, %L123]
	br i1 %_33, label %L136, label %L135
L135:
	br label %L138
L136:
	br i1 0, label %L125, label %L126
L125:
	br label %L127
L126:
	br label %L127
L127:
	%_34 = phi i1 [0, %L125], [1, %L126]
	br i1 %_34, label %L132, label %L131
L131:
	br label %L134
L132:
	br i1 0, label %L128, label %L129
L128:
	br label %L130
L129:
	br label %L130
L130:
	%_35 = phi i1 [0, %L128], [1, %L129]
	br label %L133
L133:
	br label %L134
L134:
	%_36 = phi i1 [0, %L131], [%_35, %L133]
	br label %L137
L137:
	br label %L138
L138:
	%_37 = phi i1 [0, %L135], [%_36, %L137]
	br i1 %_37, label %L139, label %L140
L139:
	call void (i32) @print_int(i32 1)


	br label %L141
L140:
	call void (i32) @print_int(i32 0)


	br label %L141
L141:

	call void (i32) @print_int(i32 2)


	br label %L120
L119:
	call void (i32) @print_int(i32 0)


	br label %L120
L120:

	call void (i32) @print_int(i32 3)


	br label %L99
L98:
	call void (i32) @print_int(i32 0)


	br label %L99
L99:

	call void (i32) @print_int(i32 4)


	br label %L78
L77:
	call void (i32) @print_int(i32 0)


	br label %L78
L78:

	call void (i32) @print_int(i32 5)


	br label %L57
L56:
	call void (i32) @print_int(i32 0)


	br label %L57
L57:

	ret i32 0
}

