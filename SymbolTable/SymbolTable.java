package SymbolTable;
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

	public boolean classExtends(String base, String derived) {
		ClassInfo classInfo = classes.get(derived);
		if (classInfo == null) {
			return false;
		}
		return classInfo.getExtendedName().equals(base); 
	}

	public boolean classHasMethod(String className, String methodName) {
		ClassInfo classInfo = classes.get(className);
		if (classInfo.isMethodDeclared(methodName)) {
			return true;
		}
		ClassInfo extendsClass = classInfo.getExtendsInfo();
		if (extendsClass != null) {
			return extendsClass.isMethodDeclared(methodName);
		}
		else {
			return false;
		}
	}

	public boolean validMethodArgs(String className, String methodName,
			ArrayList<ExpressionInfo> args) {		
		MethodInfo methodInfo = getClassInfo(className).getMethod(methodName);
		if (methodInfo == null) {
			methodInfo = getClassInfo(className).getExtendsInfo().getMethod(methodName);
		}
		return methodInfo.validArguments(args);
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