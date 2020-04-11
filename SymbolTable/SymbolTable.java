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

	public void setMainClassName(String mainClassName) {
		this.mainClassName = mainClassName;
	}

	public void printClassesNames() {
		System.out.println(classes.keySet());
	}

	public void print() {
		for (String name: classes.keySet()){
			classes.get(name).print();
		}
	}

}