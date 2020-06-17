@.zero_length_vtable = global [0 x i8*] []

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
	%arr = alloca i32*

	%_0 = add i32 1, 0
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_2 = call i8* @calloc(i32 %_0, i32 4)
	%_3 = bitcast i8* %_2 to i32*
	store i32 0, i32* %_3
	store i32* %_3, i32** %arr

	%_4 = load i32*, i32** %arr
	%_6 = load i32, i32* %_4
	%_7 = icmp sge i32 0, 0
	%_8 = icmp slt i32 0, %_6
	%_9 = and i1 %_7, %_8
	br i1 %_9, label %L2, label %L3
L3:
	call void @throw_oob()
	br label %L2
L2:
	%_10 = add i32 1, 0
	%_11 = getelementptr i32, i32* %_4, i32 %_10
	%_12 = load i32, i32* %_11
	call void (i32) @print_int(i32 %_12)

	ret i32 0
}

