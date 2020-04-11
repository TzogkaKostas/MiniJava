package SymbolTable;
import java.util.HashMap;

public class ClassInfo {
	String extendedName;
	Identifiers variables;
	HashMap<String, FunctionInfo> functions;

	public ClassInfo(String extendedName, Identifiers variables,
		HashMap<String,FunctionInfo> functions) {
		this.extendedName = extendedName;
		this.variables = variables;
		this.functions = functions;
	}

	public ClassInfo(String extendedName, Identifiers variables) {
		this.extendedName = extendedName;
		this.variables = variables;
	}

	public ClassInfo() {
		variables = new Identifiers();
		functions = new HashMap<>();
	}

	public void insertFunction(String name, FunctionInfo function) {
		functions.put(name, function);
	}
	
	public void setExtendedName(String extendedName) {
		this.extendedName = extendedName;
	}

	public void print() {
		System.out.println(extendedName);
		variables.print();
		if (!functions.isEmpty()) {
			for (String name: functions.keySet()){
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