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
	%i = alloca i32
	%j = alloca i32
	%z = alloca i32
	%x = alloca i32
	%sum = alloca i32
	%flag = alloca i1

	store i32 0, i32* %sum

	store i32 0, i32* %i

	br label %L0
L0:
	%_0 = load i32, i32* %i
	%_1 = icmp slt i32 %_0, 6
	br i1 %_1, label %L1, label %L2
L1:
	store i32 0, i32* %j

	br label %L3
L3:
	%_2 = load i32, i32* %j
	%_3 = icmp slt i32 %_2, 5
	br i1 %_3, label %L4, label %L5
L4:
	store i32 0, i32* %z

	br label %L6
L6:
	%_4 = load i32, i32* %z
	%_5 = icmp slt i32 %_4, 4
	br i1 %_5, label %L7, label %L8
L7:
	store i32 0, i32* %x

	br label %L9
L9:
	%_6 = load i32, i32* %x
	%_7 = icmp slt i32 %_6, 4
	br i1 %_7, label %L10, label %L11
L10:
	%_8 = load i32, i32* %sum
	%_9 = load i32, i32* %i
	%_10 = load i32, i32* %j
	%_11 = add i32 %_9, %_10
	%_12 = load i32, i32* %z
	%_13 = add i32 %_11, %_12
	%_14 = load i32, i32* %x
	%_15 = add i32 %_13, %_14
	%_16 = add i32 %_8, %_15
	store i32 %_16, i32* %sum

	%_17 = load i32, i32* %x
	%_18 = add i32 %_17, 1
	store i32 %_18, i32* %x


	br label %L9
L11:

	%_19 = load i32, i32* %z
	%_20 = add i32 %_19, 1
	store i32 %_20, i32* %z


	br label %L6
L8:

	%_21 = load i32, i32* %j
	%_22 = add i32 %_21, 1
	store i32 %_22, i32* %j


	br label %L3
L5:

	%_23 = load i32, i32* %i
	%_24 = add i32 %_23, 1
	store i32 %_24, i32* %i


	br label %L0
L2:

	%_25 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_25)

	store i32 0, i32* %sum

	store i32 0, i32* %i

	store i1 1, i1* %flag

	br label %L12
L12:
	%_26 = load i32, i32* %i
	%_27 = icmp slt i32 %_26, 6
	br i1 %_27, label %L13, label %L14
L13:
	store i32 0, i32* %j

	%_28 = load i1, i1* %flag
	br i1 %_28, label %L15, label %L16
L15:
	br label %L18
L18:
	%_29 = load i32, i32* %j
	%_30 = icmp slt i32 %_29, 5
	br i1 %_30, label %L19, label %L20
L19:
	store i32 0, i32* %z

	br label %L21
L21:
	%_31 = load i32, i32* %z
	%_32 = icmp slt i32 %_31, 4
	br i1 %_32, label %L22, label %L23
L22:
	store i32 0, i32* %x

	br label %L24
L24:
	%_33 = load i32, i32* %x
	%_34 = icmp slt i32 %_33, 4
	br i1 %_34, label %L25, label %L26
L25:
	%_35 = load i32, i32* %sum
	%_36 = load i32, i32* %i
	%_37 = load i32, i32* %j
	%_38 = add i32 %_36, %_37
	%_39 = load i32, i32* %z
	%_40 = add i32 %_38, %_39
	%_41 = load i32, i32* %x
	%_42 = add i32 %_40, %_41
	%_43 = add i32 %_35, %_42
	store i32 %_43, i32* %sum

	%_44 = load i32, i32* %x
	%_45 = add i32 %_44, 1
	store i32 %_45, i32* %x


	br label %L24
L26:

	%_46 = load i32, i32* %z
	%_47 = add i32 %_46, 1
	store i32 %_47, i32* %z


	br label %L21
L23:

	%_48 = load i32, i32* %j
	%_49 = add i32 %_48, 1
	store i32 %_49, i32* %j


	br label %L18
L20:

	store i1 0, i1* %flag


	br label %L17
L16:
	br label %L27
L27:
	%_50 = load i32, i32* %j
	%_51 = icmp slt i32 %_50, 4
	br i1 %_51, label %L28, label %L29
L28:
	store i32 0, i32* %z

	br label %L30
L30:
	%_52 = load i32, i32* %z
	%_53 = icmp slt i32 %_52, 10
	br i1 %_53, label %L31, label %L32
L31:
	store i32 0, i32* %x

	br label %L33
L33:
	%_54 = load i32, i32* %x
	%_55 = icmp slt i32 %_54, 4
	br i1 %_55, label %L34, label %L35
L34:
	%_56 = load i32, i32* %sum
	%_57 = load i32, i32* %i
	%_58 = load i32, i32* %j
	%_59 =  mul i32 %_57, %_58
	%_60 = load i32, i32* %z
	%_61 = add i32 %_59, %_60
	%_62 = load i32, i32* %x
	%_63 = add i32 %_61, %_62
	%_64 = add i32 %_56, %_63
	store i32 %_64, i32* %sum

	%_65 = load i32, i32* %x
	%_66 = add i32 %_65, 1
	store i32 %_66, i32* %x


	br label %L33
L35:

	%_67 = load i32, i32* %z
	%_68 = add i32 %_67, 1
	store i32 %_68, i32* %z


	br label %L30
L32:

	%_69 = load i32, i32* %j
	%_70 = add i32 %_69, 1
	store i32 %_70, i32* %j


	br label %L27
L29:

	store i1 0, i1* %flag


	br label %L17
L17:

	%_71 = load i32, i32* %i
	%_72 = add i32 %_71, 1
	store i32 %_72, i32* %i


	br label %L12
L14:

	%_73 = load i32, i32* %sum
	call void (i32) @print_int(i32 %_73)

	ret i32 0
}

