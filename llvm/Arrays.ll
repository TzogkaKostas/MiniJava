@.Arrays_vtable = global [0 x i8*] []

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
	%x = alloca i32*
	%_0 = add i32 1, 2
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_2 = call i8* @calloc(i32 %_0, i32 4)
	%_3 = bitcast i8* %_2 to i32*
	store i32 2, i32* %_3
	store i32* %_3, i32** %x

	%_4 = load i32*, i32** %x
	%_6 = load i32, i32* %_4
	%_7 = icmp sge i32 0, 0
	%_8 = icmp slt i32 0, %_6
	%_9 = and i1 %_8, %_9
	br i1 %_9, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_10 = add i32 1, 0
	%_12 = getelementptr i32, i32* %_4, i32 %_10
	store i32 1, i32* %_12

	%_13 = load i32*, i32** %x
	%_15 = load i32, i32* %_13
	%_16 = icmp sge i32 1, 0
	%_17 = icmp slt i32 0, %_15
	%_18 = and i1 %_17, %_18
	br i1 %_18, label %L4, label %L5
L5:
	call void @throw_oob()
	br label %L4
L4:
	%_19 = add i32 1, 1
	%_21 = getelementptr i32, i32* %_13, i32 %_19
	store i32 2, i32* %_21

	%_22 = load i32*, i32** %x
	%_24 = load i32, i32* %_22
	%_25 = icmp sge i32 0, 0
	%_26 = icmp slt i32 0, %_24
	%_27 = and i1 %_25, %_26
	br i1 %_27, label %L6, label %L7
L7:
	call void @throw_oob()
	br label %L6
L6:
	%_28 = add i32 1, 0
	%_29 = getelementptr i32, i32* %_22, i32 %_28
	%_30 = load i32, i32* %_29
	%_32 = load i32*, i32** %x
	%_34 = load i32, i32* %_32
	%_35 = icmp sge i32 1, 0
	%_36 = icmp slt i32 1, %_34
	%_37 = and i1 %_35, %_36
	br i1 %_37, label %L8, label %L9
L9:
	call void @throw_oob()
	br label %L8
L8:
	%_38 = add i32 1, 1
	%_39 = getelementptr i32, i32* %_32, i32 %_38
	%_40 = load i32, i32* %_39
	%_42 = add i32 %_30, %_40
	call void (i32) @print_int(i32 %_42)

	ret i32 0
}

