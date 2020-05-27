@.multi_extend_vtable = global [0 x i8*] []

@.A_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*, i32, i1, i8*, i32)* @A.foo to i8*),
	i8* bitcast (i1 (i8*)* @A.get_b to i8*),
	i8* bitcast (i32 (i8*)* @A.get_x to i8*)
]

@.B_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*, i32, i1, i8*, i32)* @A.foo to i8*),
	i8* bitcast (i1 (i8*)* @A.get_b to i8*),
	i8* bitcast (i32 (i8*)* @A.get_x to i8*)
]

@.C_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*, i32, i1, i8*, i32)* @A.foo to i8*),
	i8* bitcast (i1 (i8*)* @A.get_b to i8*),
	i8* bitcast (i32 (i8*)* @A.get_x to i8*)
]

@.D_vtable = global [3 x i8*] [
	i8* bitcast (i32 (i8*, i32, i1, i8*, i32)* @D.foo to i8*),
	i8* bitcast (i1 (i8*)* @A.get_b to i8*),
	i8* bitcast (i32 (i8*)* @A.get_x to i8*)
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
	%a = alloca i8*
	%c = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.D_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %a

	%_3 = call i8* @calloc(i32 1, i32 8)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
	store i8** %_5, i8*** %_4
	store i8* %_3, i8** %c

	%_6 = load i8*, i8** %a
	%_7 = load i8*, i8** %a
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 2
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*)*
	%_13 = call i32 %_12(i8* %_7)
	%_14 = load i8*, i8** %a
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 2
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_14)
	%_21 = load i8*, i8** %a
	%_22 = bitcast i8* %_21 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 2
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i32 (i8*)*
	%_27 = call i32 %_26(i8* %_21)
	%_28 = add i32 %_20, %_27
	%_29 = add i32 %_13, %_28
	%_30 = load i8*, i8** %a
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 2
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i32 (i8*)*
	%_36 = call i32 %_35(i8* %_30)
	%_37 = add i32 %_29, %_36
	%_38 = load i8*, i8** %a
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 2
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i32 (i8*)*
	%_44 = call i32 %_43(i8* %_38)
	%_45 = add i32 %_37, %_44
	%_46 = load i8*, i8** %a
	%_47 = bitcast i8* %_46 to i8***
	%_48 = load i8**, i8*** %_47
	%_49 = getelementptr i8*, i8** %_48, i32 1
	%_50 = load i8*, i8** %_49
	%_51 = bitcast i8* %_50 to i1 (i8*)*
	%_52 = call i1 %_51(i8* %_46)
	%_53 = load i8*, i8** %c
	%_54 = load i8*, i8** %a
	%_55 = load i8*, i8** %a
	%_56 = bitcast i8* %_54 to i8***
	%_57 = load i8**, i8*** %_56
	%_58 = getelementptr i8*, i8** %_57, i32 0
	%_59 = load i8*, i8** %_58
	%_60 = bitcast i8* %_59 to i32 (i8*, i32, i1, i8*, i32)*
	%_61 = call i32 %_60(i8* %_54, i32 1, i1 1, i8* %_55, i32 2)
	%_62 = mul i32 %_61, 5
	%_63 = sub i32 %_62, 3
	%_64 = bitcast i8* %_6 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 0
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i32 (i8*, i32, i1, i8*, i32)*
	%_69 = call i32 %_68(i8* %_6, i32 %_45, i1 %_52, i8* %_53, i32 %_63)
	call void (i32) @print_int(i32 %_69)

	ret i32 0
}

define i32 @A.foo(i8* %this, i32 %.x, i1 %.b, i8* %.a, i32 %.last) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%b = alloca i1
	store i1 %.b, i1* %b
	%a = alloca i8*
	store i8* %.a, i8** %a
	%last = alloca i32
	store i32 %.last, i32* %last

	ret i32 0
}

define i1 @A.get_b(i8* %this) {

	ret i1 0
}

define i32 @A.get_x(i8* %this) {

	ret i32 1
}

define i32 @D.foo(i8* %this, i32 %.x, i1 %.b, i8* %.a, i32 %.last) {
	%x = alloca i32
	store i32 %.x, i32* %x
	%b = alloca i1
	store i1 %.b, i1* %b
	%a = alloca i8*
	store i8* %.a, i8** %a
	%last = alloca i32
	store i32 %.last, i32* %last

	%_70 = load i32, i32* %last
	ret i32 %_70
}

