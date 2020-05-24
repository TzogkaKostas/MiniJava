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

	%_6 = load i8*, i8** %b
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 0
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*, i32)*
	%_12 = call i32 %_11(i8*%_6, i32 1)
	call void (i32) @print_int(i32 %_12)

	%_14 = load i8*, i8** %d
	store i8* %_14, i8** %b

	%_15 = load i8*, i8** %b
	%_16 = bitcast i8* %_15 to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 0
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32 (i8*, i32)*
	%_21 = call i32 %_20(i8*%_15, i32 3)
	call void (i32) @print_int(i32 %_21)

	ret i32 0
}

define i32 @Base.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_23 = load i32, i32* %x
	%_24 = getelementptr i8, i8* %this, i32 0
	%_25 = bitcast i8* %_24 to i32*
	store i32 %_23, i32* %_25

	%_27 = getelementptr i8, i8* %this, i32 0
	%_28 = bitcast i8* %_27 to i32*
	%_26 = load i32, i32* %_28
	ret i32 %_26
}

define i32 @Base.get(i8* %this) {
	%_30 = getelementptr i8, i8* %this, i32 0
	%_31 = bitcast i8* %_30 to i32*
	%_29 = load i32, i32* %_31
	ret i32 %_29
}

define i32 @Derived.set(i8* %this, i32 %.x) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%_32 = load i32, i32* %x
	%_33 =  mul i32 %_32, 2	%_34 = getelementptr i8, i8* %this, i32 0
	%_35 = bitcast i8* %_34 to i32*
	store i32 %_33, i32* %_35

	%_37 = getelementptr i8, i8* %this, i32 0
	%_38 = bitcast i8* %_37 to i32*
	%_36 = load i32, i32* %_38
	ret i32 %_36
}

