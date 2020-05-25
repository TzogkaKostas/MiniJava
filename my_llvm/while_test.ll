@.Main_vtable = global [0 x i8*] []

@.A_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*, i32, i1)* @A.bar to i8*)
]

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
	%dummy = alloca i32
	%a = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = load i8*, i8** %a
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*)*
	%_9 = call i32 %_8(i8* %_3)
	store i32 %_9, i32* %dummy

	ret i32 0
}

define i32 @A.foo(i8* %this) {
	%a = alloca i32
	%b = alloca i32

	store i32 3, i32* %a

	br label %L0
L0:
	%_11 = load i32, i32* %a
	%_12 = icmp slt i32 %_11, 4
	br i1 %_12, label %L1, label %L2
L1:
	%_13 = load i32, i32* %a
	%_14 = add i32 %_13, 1
	store i32 %_14, i32* %a


	br label %L0
L2:

	%_15 = load i32, i32* %a
	call void (i32) @print_int(i32 %_15)

	%_16 = bitcast i8* %this to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 1
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32 (i8*, i32, i1)*
	%_21 = call i32 %_20(i8* %this, i32 7, i1 1)
	store i32 %_21, i32* %b

	%_23 = load i32, i32* %b
	call void (i32) @print_int(i32 %_23)

	ret i32 0
}

define i32 @A.bar(i8* %this, i32 %.a, i1 %.cond) {
	%a = alloca i32
	store i32 %.a, i32* %a
	%cond = alloca i1
	store i1 %.cond, i1* %cond
	%b = alloca i32

	br label %L3
L3:
	%_24 = load i1, i1* %cond
	br i1 %_24, label %L4, label %L5
L4:
	%_25 = load i32, i32* %a
	store i32 %_25, i32* %b

	%_26 = load i1, i1* %cond
	br i1 %_26, label %L6, label %L7
L6:
	store i32 2, i32* %a


	br label %L8
L7:

	br label %L8
L8:

	store i1 0, i1* %cond


	br label %L3
L5:

	%_27 = load i32, i32* %b
	ret i32 %_27
}

