package Types;
import java.util.LinkedHashMap;
import java.util.*;

public class SymbolTable {
	String mainClassName;
	LinkedHashMap<String, ClassInfo> classes;

	public SymbolTable() {
		classes = new LinkedHashMap<>();
	}
	
	public void insertClass(String name, ClassInfo classInfo) {
		classes.put(name, classInfo);
	}

	public void insertMainClass(String name, ClassInfo classInfo) {
		classes.put(name, classInfo);
		mainClassName = name;
	}

	public String getMainClassName() {
		return mainClassName;
	}

	public ClassInfo getClassInfo(String className) {
		return classes.get(className);
	}

	public void setMainClassName(String mainClassName) {
		this.mainClassName = mainClassName;
	}

	public void printClassesNames() {
		System.out.println(classes.keySet());
	}

	public boolean classExists(String className) {
		if (classes.get(className) != null)
			return true;
		else
			return false;
	}

	public boolean classExtends(String subclass, String superclass) {
		ClassInfo classInfo = classes.get(subclass);
		if (classInfo == null) {
			return false;
		}
		return classInfo.classExtends(superclass);
	}

	public boolean classHasMethod(String className, String methodName) {
		return classes.get(className).isMethodDeclared(methodName);
	}

	public boolean validMethodArgs(SymbolTable symbolTable, String className, String methodName,
			ArrayList<ExpressionInfo> args) {		
		MethodInfo methodInfo = getClassInfo(className).getMethod(methodName);
		return methodInfo.validArguments(symbolTable, args);
	}

	public String getMethodReturnedType(String className, String methodName) {
		MethodInfo methodInfo = getClassInfo(className).getMethod(methodName);
		if (methodInfo == null) {
			methodInfo = getClassInfo(className).getExtendsInfo().getMethod(methodName);
		}
		return methodInfo.getReturnType();
	}

	public void print() {
		for (String name: classes.keySet()){
			System.out.print("class " + name);
			classes.get(name).print();
			System.out.println("");
		}
	}
}