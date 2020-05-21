@.Classes_vtable = global [0 x i8*] []

@.Base_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @Base.set to i8*),
	i8* bitcast (i32 (i8*)* @Base.get to i8*)
]

@.Derived_vtable = global [2 x i8*] [
	i8* bitcast (i32 (i8*, i32)* @Derived.set to i8*),
	i8* bitcast (i32 (i8*)* @Derived.get to i8*)
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
	ret i32 0
}

define i32 @Base.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_6 = load i32, i32* %x
	%_7 = getelementptr i8, i8* %this, i32 0
	%_8 = bitcast i8* %_7 to i32*
	store i32 %_6, i32* %_8
	%_10 = getelementptr i8, i8* %this, i32 0
	%_11 = bitcast i8* %_10 to i32*
	%_9 = load i32, i32* %_11
	ret i32 %_9
}

define i32 @Base.get(i8* %this) {
	%_13 = getelementptr i8, i8* %this, i32 0
	%_14 = bitcast i8* %_13 to i32*
	%_12 = load i32, i32* %_14
	ret i32 %_12
}

define i32 @Derived.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_15 = load i32, i32* %x
	%_16 =  mul i32 %_15, 2
	%_17 = getelementptr i8, i8* %this, i32 -1
	%_18 = bitcast i8* %_17 to i32*
	store i32 %_16, i32* %_18
	%_20 = getelementptr i8, i8* %this, i32 -1
	%_21 = bitcast i8* %_20 to i32*
	%_19 = load i32, i32* %_21
	ret i32 %_19
}

