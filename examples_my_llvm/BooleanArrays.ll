@.BooleanArrays_vtable = global [0 x i8*] []

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
	%_0 = add i32 4, 10
	%_1 = icmp sge i32 %_0, 4
	br i1 %_1, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_2 = call i8* @calloc(i32 1, i32 %_0)
	%_3 = bitcast i8* %_2 to i32*
	store i32 10, i32* %_3
	store i8* %_2, i8** %b

	%_4 = load i8*, i8** %b
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = icmp sge i32 0, 0
	%_8 = icmp slt i32 0, %_6
	%_9 = and i1 %_8, %_9
	br i1 %_9, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_10 = add i32 4, 0
	%_11 = zext i1 1 to i8	%_12 = getelementptr i8, i8* %_4, i32 %_10
	store i8 1, i8* %_12

	%_13 = load i8*, i8** %b
	%_14 = bitcast i8* %_13 to i32*	%_15 = load i32, i32* %_14
	%_16 = icmp sge i32 1, 0
	%_17 = icmp slt i32 1, %_15
	%_18 = and i1 %_16, %_17
	br i1 %_18, label %L4, label %L5
L5:
	call void @throw_oob()
	br label %L4
L4:
	%_19 = add i32 1, 1
	%_20 = getelementptr i8, i8* %_13, i32 %_19
	%_21 = load i8, i8* %_20
	%_22 = trunc i8 %_21 to i1
	br i1 %_22, label %L6, label %L7
L6:
	call void (i32) @print_int(i32 1)


	br label %L8
L7:
	call void (i32) @print_int(i32 2)


	br label %L8
L8:

	ret i32 0
}

