@.Simple_vtable = global [0 x i8*] []

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
	%x = alloca i32
	store i32 10, i32* %x
	%_0 = load i32, i32* %x
	%_4 = icmp slt i32 %_0, 2
	br i1 %_4 , label %L1, label %L2
	L1:
	%_5 = add i1 0, 0
	br label %L3
	L2:
	%_6 = add i1 0, 1
	br label %L3
	L3:
	%_7 = phi i1 [%_5, %L1], [%_6, %L2]
	br i1 %_7, label %L8, label %L9
	L8:
	call void (i32) @print_int(i32 0)
	br label %L10
	L9:
	call void (i32) @print_int(i32 1)
	br label %L10
	L10:
	ret i32 0
}

