@.And_vtable = global [0 x i8*] []

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
	%b = alloca i1
	%c = alloca i1
	%x = alloca i32
	store i1 0, i1* %b

	store i1 1, i1* %c

	%_0 = load i1, i1* %b
	br i1 %_0, label %L0, label %L1
L0:
	br label %L2
L1:
	br label %L2
L2:
	%_1 = phi i1 [0, %L0], [1, %L1]
	br i1 %_1, label %L3, label %L4
L3:
	br label %L5
L4:
	br label %L5
L5:
	%_2 = phi i1 [0, %L3], [1, %L4]
	br i1 %_2, label %L6, label %L7
L6:
	br label %L8
L7:
	br label %L8
L8:
	%_3 = phi i1 [0, %L6], [1, %L7]
	br i1 %_3, label %L10, label %L9
L9:
	br label %L12
L10:
	%_4 = load i1, i1* %c
	br label %L11
L11:
	br label %L12
L12:
	%_5 = phi i1 [0, %L9], [%_4, %L11]
	br i1 %_5, label %L13, label %L14
L13:
	store i32 0, i32* %x

	br label %L15
L14:
	store i32 1, i32* %x

	br label %L15
L15:

	%_6 = load i32, i32* %x
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}

