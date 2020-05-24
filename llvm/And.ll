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
	br i1 %_0, label %L1, label %L0
L0:
	br label %L3
L1:
	%_1 = load i1, i1* %c
	br label %L2
L2:
	br label %L3
L3:
	%_2 = phi i1 [0, %L0], [%_1, %L2]
	br i1 %_2, label %L4, label %L5
L4:
	store i32 0, i32* %x

	br label %L6
L5:
	store i32 1, i32* %x

	br label %L6
L6:

	%_3 = load i32, i32* %x
	call void (i32) @print_int(i32 %_3)

	ret i32 0
}

