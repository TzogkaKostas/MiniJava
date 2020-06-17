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
	%b = alloca i8*
	%c = alloca i32

	%_0 = add i32 4, 2
	%_1 = icmp sge i32 %_0, 4
	br i1 %_1, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_2 = call i8* @calloc(i32 1, i32 %_0)
	%_3 = bitcast i8* %_2 to i32*
	store i32 2, i32* %_3
	store i8* %_2, i8** %b

	%_4 = sub i32 0, 1
	store i32 %_4, i32* %c

	%_5 = load i8*, i8** %b
	%_6 = load i32, i32* %c
	%_7 = bitcast i8* %_5 to i32*
	%_8 = load i32, i32* %_7
	%_9 = icmp sge i32 %_6, 0
	%_10 = icmp slt i32 %_6, %_8
	%_11 = and i1 %_9, %_10
	br i1 %_11, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_12 = add i32 4, %_6
	%_13 = getelementptr i8, i8* %_5, i32 %_12
	%_14 = load i8, i8* %_13
	%_15 = trunc i8 %_14 to i1
	br i1 %_15, label %L4, label %L5
L4:
	call void (i32) @print_int(i32 1)


	br label %L6
L5:
	call void (i32) @print_int(i32 0)


	br label %L6
L6:

	ret i32 0
}

