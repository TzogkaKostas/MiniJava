package SymbolTable;
import java.util.LinkedHashMap;
import java.util.*;
import java.util.Map.Entry;

public class ClassInfo {
	String name;
	String extendsName;
	ClassInfo extendsInfo;
	Variables variables;
	LinkedHashMap<String, MethodInfo> methods;

	public ClassInfo getExtendsInfo() {
		return this.extendsInfo;
	}

	public ClassInfo(String name, Variables variables) {
		this.name = name;
		this.extendsName = "";
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
	}

	public ClassInfo(String name, String extendsName, ClassInfo extendsInfo, Variables variables) {
		this.name = name;
		this.extendsName = extendsName;
		this.extendsInfo = extendsInfo;
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
	}

	public ClassInfo(String name, String methodName, MethodInfo methodInfo) {
		this.name = name;
		this.extendsName = "";
		this.variables = new Variables();
		this.methods = new LinkedHashMap<>();
		this.methods.put(methodName, methodInfo);
	}

	public void insertVariable(String identifier, String type) {
		variables.insert(identifier, type);		
	}

	public void insertMethod(String name, MethodInfo method) {
		methods.put(name, method);
	}

	// public void setName(String name) {
	// 	this.name = name;
	// }

	public String getName() {
		return name;
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
		MethodInfo methodInfo = methods.get(methodName);
		if (methodInfo != null) {
			return methodInfo;
		}
		if (extendsInfo != null) {
			return extendsInfo.getMethod(methodName);
		}
		else {
			return null;
		}
	}

	// public boolean isVarDeclared(String variable) {
	// 	if (variables.exists(variable)) {
	// 		return true;
	// 	}
	// 	else {
	// 		return false;
	// 	}
	// }

	public boolean isMethodDeclared(String methodName) {
		if (methods.get(methodName) != null) {
			return true;
		}
		if (extendsInfo != null) {
			return extendsInfo.isMethodDeclared(methodName);
		}
		else {
			return false;
		}
	}

	public String getVarType(String identifier) {
		String type = variables.lookup(identifier);
		if (type != null ){
			return type;
		}
		if (extendsInfo != null) {
			return extendsInfo.getVarType(identifier);
		}
		return null;
	}

	public boolean validDeclaration(String methodName, MethodInfo methodInfo) {
		if (methodExists(methodName)) {
			return false;
		}
		if (extendsInfo == null) {
			return true;
		}
		if (extendsInfo.methodExists(methodName)) {
			return isOverridden(methodName, methodInfo);
		}
		else {
			return true;
		}
	}

	public boolean equivalentType(String type) {
		if (type == this.name) {
			return true;
		}
		if (extendsInfo != null) {
			return extendsInfo.equivalentType(type);
		}
		else {
			return false;
		}
	}

	public boolean methodExists(String methodName) {
		if (methods.get(methodName) != null)
			return true;
		else
			return false;
	}

	// public boolean isOverload(String methodName, MethodInfo methodInfo) {
	// 	MethodInfo otherMethodInfo = methods.get(methodName);
	// 	if (otherMethodInfo == null) {
	// 		return false;
	// 	}
	// 	return !otherMethodInfo.validArguments(getAsList(methodInfo.getParameters()));
	// }

	public boolean isOverridden(String methodName, MethodInfo methodInfo) {
		MethodInfo otherMethodInfo = extendsInfo.getMethod(methodName);
		if (otherMethodInfo.getReturnType() == methodInfo.getReturnType() &&
				otherMethodInfo.exactValidArguments(getAsList(methodInfo.getParameters()))) {
			return true;
		}
		if (extendsInfo == null) {
			return false;
		}
		if (extendsInfo.methodExists(methodName)) {
			return extendsInfo.isOverridden(methodName, methodInfo);
		}
		else {
			return false;
		}
	}

	public ArrayList<ExpressionInfo> getAsList(Variables vars) {
		ArrayList<ExpressionInfo> args = new ArrayList<ExpressionInfo>();
		for (Entry<String, String> entry : vars.getEntries()) {
			args.add(new ExpressionInfo("", entry.getValue(), ""));
		}
		return args;
	}

	public void print() {
		if (variables != null && variables.getSize() != 0) {
			System.out.print("fields: ");
			variables.print();	
		}
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