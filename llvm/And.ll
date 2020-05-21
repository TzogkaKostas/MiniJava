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
	store i32 0, i32* %x
	store i32 1, i32* %x
	br i1 %_0 , label %L0, label %L0
	L0:
	%_6 = add i1 0, %_0	br label %L0
	L0:
	%_7 = add i1 0, %_1	br label %L0
	L0:
	%_5 = phi i1 [%_6, %L0], [%_7, %L0]
	br i1 %_5, label %L0, label %L0
	L0:
	br label %L0
	L0:
	br label %L0
	L0:
	%_11 = load i32, i32* %x
	call void (i32) @print_int(i32 %_11)
	ret i32 0
}

