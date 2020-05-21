@.Classes_vtable = global [0 x i8*] []

@.Base_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @Base.set to i8*),
	i8* bitcast (i32 (i8*)* @Base.get to i8*)
]

@.Derived_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @Derived.set to i8*),
	i8* bitcast (i32 (i8*)* @Base.get to i8*)
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
	%b = alloca i8*
	%d = alloca i8*
	%_0 = call i8* @calloc(i32 1, i32 4)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Base_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %b
	%_3 = call i8* @calloc(i32 1, i32 4)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [2 x i8*], [2 x i8*]* @.Derived_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	store i8* %_3, i8** %d
	%_6 = load i8*, i8** %d
	store i8* %_6, i8** %b
	ret i32 0
}

define i32 @Base.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_7 = load i32, i32* %x
	%_8 = getelementptr i8, i8* %this, i32 0
	%_9 = bitcast i8* %_8 to i32*
	store i32 %_7, i32* %_9
		%_11 = getelementptr i8, i8* %this, i32 0
	%_12 = bitcast i8* %_11 to i32*
	%_10 = load i32, i32* %_12
	ret i32 %_10
}

define i32 @Base.get(i8* %this) {
		%_14 = getelementptr i8, i8* %this, i32 0
	%_15 = bitcast i8* %_14 to i32*
	%_13 = load i32, i32* %_15
	ret i32 %_13
}

define i32 @Derived.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_16 = load i32, i32* %x
	%_17 =  mul i32 %_16, 2	%_18 = getelementptr i8, i8* %this, i32 0
	%_19 = bitcast i8* %_18 to i32*
	store i32 %_17, i32* %_19
		%_21 = getelementptr i8, i8* %this, i32 0
	%_22 = bitcast i8* %_21 to i32*
	%_20 = load i32, i32* %_22
	ret i32 %_20
}

