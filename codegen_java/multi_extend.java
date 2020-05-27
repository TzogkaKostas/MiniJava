class multi_extend {
	public static void main(String[] irrelevant) {
		A a;
		C c;
		a = new D();
		c = new C();
		System.out.println(a.foo( (((a.get_x())+((a.get_x())+(a.get_x())))+(a.get_x()))+(a.get_x()),
				a.get_b(), c, ((a.foo(1, true, a, 2))*5)-3 ));
	}
}

class A {
	public int foo(int x, boolean b, A a, int last) {
		// System.out.println(99);
		return 0;
	}
    public boolean get_b() {
		return false;
	}

	public int get_x() {
		return 1;
	}
}

class B extends A{

}

class C extends B {

}

class D extends C {
	public int foo(int x, boolean b, A a, int last) {
		// System.out.println(last+1000);
		return last;
	}
}