class array_from_method {
	public static void main(String[] irrelevant) {
        A a1;
        A a2;
        int i;
        a1 = new A();
        a2 = new D();

        
        i = 0;
        while (i < ((a1.foo()).length)) {
            System.out.println((a1.foo())[i]);
            i = i + 1;
        }

        i = 0;
        while (i < ((a2.foo()).length)) {
            System.out.println((a2.foo())[i]);
            i = i + 1;
        }

	}
}

class A {
	public int[] foo() {
        int[] arr;
        arr = new int[5];
        arr[0] = 11;
        arr[1] = 22;
        arr[2] = 33;
        arr[3] = 44;
        arr[4] = 55;

		return arr;
	}

}

class B extends A{

}

class C extends B {

}

class D extends C {
	public int[] foo() {
        int[] arr;
        arr = new int[5];
        arr[0] = 111;
        arr[1] = 222;
        arr[2] = 333;
        arr[3] = 444;
        arr[4] = 555;
		return arr;
	}
}