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
	%b = alloca i32*
	%x = alloca i32

	%_0 =  sub i32 1, 2
	store i32 %_0, i32* %x

	%_1 = load i32, i32* %x
	%_2 = add i32 1, %_1
	%_3 = icmp sge i32 %_2, 1
	br i1 %_3, label %L0, label %L1
L1:
	call void @throw_nsz()
	br label %L0
L0:
	%_4 = call i8* @calloc(i32 %_2, i32 4)
	%_5 = bitcast i8* %_4 to i32*
	store i32 %_1, i32* %_5
	store i32* %_5, i32** %b

	ret i32 0
}

