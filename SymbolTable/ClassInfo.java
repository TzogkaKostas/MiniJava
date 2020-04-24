package SymbolTable;
import java.util.HashMap;

public class ClassInfo {
	String extendsName;
	ClassInfo extendsInfo;
	Variables variables;
	HashMap<String, FunctionInfo> functions;

	public ClassInfo(Variables variables) {
		this.extendsName = "";
		this.variables = variables;
		this.functions = new HashMap<>();
	}

	public ClassInfo(String extendsName, ClassInfo extendsInfo, Variables variables) {
		this.extendsName = extendsName;
		this.extendsInfo = extendsInfo;
		this.variables = variables;
		this.functions = new HashMap<>();
	}

	public ClassInfo(String functionName, FunctionInfo functionInfo) {
		this.functions = new HashMap<>();
		this.functions.put(functionName, functionInfo);
	}

	public void insertVariable(String identifier, String type) {
		variables.insert(identifier, type);		
	}

	public void insertFunction(String name, FunctionInfo function) {
		functions.put(name, function);
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

	public HashMap<String,FunctionInfo> getFunctions() {
		return this.functions;
	}

	public void setFunctions(HashMap<String,FunctionInfo> functions) {
		this.functions = functions;
	}

	public FunctionInfo getFunctionInfo(String functionName) {
		return functions.get(functionName);
	}

	public boolean isVarDeclared(String variable) {
		if (variables.exists(variable)) {
			return true;
		}
		else {
			return false;
		}
	}

	public boolean isMethodDeclared(String methodName) {
		if (functions.get(methodName) != null) {
			return true;
		}
		else {
			return false;
		}
	}

	public String getVarType(String identifier) {
		return variables.lookup(identifier);
	}

	public boolean functionExists(String functionName) {
		if (functions.get(functionName) != null)
			return true;
		else
			return false;
	}

	public void print() {
		System.out.println(" extends " + (extendsName != "" ? extendsName : " "));
		if (variables != null)
			variables.print();	
		if (!functions.isEmpty()) {
			for (String name: functions.keySet()){
				System.out.print("Function " + name);
				functions.get(name).print();
			}
		}
	}

	public void printFunctions() {
		for (String name: functions.keySet()){
			functions.get(name).print();
		}
	}

	public void printFunctionsNames() {
		System.out.println(functions.keySet());
	}
	
}