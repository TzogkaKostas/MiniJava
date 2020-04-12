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
		this.functions = new HashMap<>();
	}

	public ClassInfo() {
		variables = new Identifiers();
		functions = new HashMap<>();
	}

	public ClassInfo(String className, String argsName, Identifiers variables) {
		this.variables = new Identifiers();
		this.functions = new HashMap<>();
		this.functions.put("main", new FunctionInfo("void",
			new Identifiers("String[]", argsName), variables));
	}

	public void insertVariable(String identifier, String type) {
		variables.insert(identifier, type);		
	}

	public void insertFunction(String name, FunctionInfo function) {
		functions.put(name, function);
	}

	public void setExtendedName(String extendedName) {
		this.extendedName = extendedName;
	}

	public String getExtendedName() {
		return this.extendedName;
	}

	public Identifiers getVariables() {
		return this.variables;
	}

	public void setVariables(Identifiers variables) {
		this.variables = variables;
	}

	public HashMap<String,FunctionInfo> getFunctions() {
		return this.functions;
	}

	public void setFunctions(HashMap<String,FunctionInfo> functions) {
		this.functions = functions;
	}

	public void print() {
		System.out.println(" extends " + (extendedName != "" ? extendedName : " "));
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