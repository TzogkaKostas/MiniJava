package SymbolTable;
import java.util.LinkedHashMap;

public class ClassInfo {
	String extendsName;
	ClassInfo extendsInfo;
	Variables variables;
	LinkedHashMap<String, MethodInfo> methods;

	public ClassInfo(Variables variables) {
		this.extendsName = "";
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
	}

	public ClassInfo(String extendsName, ClassInfo extendsInfo, Variables variables) {
		this.extendsName = extendsName;
		this.extendsInfo = extendsInfo;
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
	}

	public ClassInfo(String methodName, MethodInfo methodInfo) {
		this.methods = new LinkedHashMap<>();
		this.methods.put(methodName, methodInfo);
	}

	public void insertVariable(String identifier, String type) {
		variables.insert(identifier, type);		
	}

	public void insertMethod(String name, MethodInfo method) {
		methods.put(name, method);
	}

	public void setExtendedName(String extendsName) {
		this.extendsName = extendsName;
	}

	public String getExtendedName() {
		return this.extendsName;
	}

	public Variables getVariables() {
		return this.variables;
	}

	public void setVariables(Variables variables) {
		this.variables = variables;
	}

	public LinkedHashMap<String,MethodInfo> getMethods() {
		return this.methods;
	}

	public void setMethods(LinkedHashMap<String,MethodInfo> methods) {
		this.methods = methods;
	}

	public MethodInfo getMethod(String methodName) {
		return methods.get(methodName);
	}

	public boolean isVarDeclared(String variable) {
		if (variables.exists(variable)) {
			return true;
		}
		else {
			return false;
		}
	}

	public boolean isMethodDeclared(String Name) {
		if (methods.get(Name) != null) {
			return true;
		}
		else {
			return false;
		}
	}

	public String getVarType(String identifier) {
		return variables.lookup(identifier);
	}

	public boolean methodExists(String methodName) {
		if (methods.get(methodName) != null)
			return true;
		else
			return false;
	}

	public void print() {
		System.out.println(" extends " + (extendsName != "" ? extendsName : " "));
		if (variables != null)
			variables.print();	
		if (!methods.isEmpty()) {
			for (String name: methods.keySet()){
				System.out.print("Method " + name);
				methods.get(name).print();
			}
		}
	}

	public void printMethods() {
		for (String name: methods.keySet()){
			methods.get(name).print();
		}
	}

	public void printMethodsNames() {
		System.out.println(methods.keySet());
	}
	
}