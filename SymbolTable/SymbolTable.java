package SymbolTable;
import java.util.HashMap;

public class SymbolTable {
	String mainClassName;
	HashMap<String, ClassInfo> classes;

	public SymbolTable() {
		classes = new HashMap<>();
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

	public void print() {
		for (String name: classes.keySet()){
			System.out.print("class " + name);
			classes.get(name).print();
			System.out.println("");
		}
	}

}