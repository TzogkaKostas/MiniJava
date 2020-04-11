package SymbolTable;

public class FunctionInfo {
	String returnType;
	Identifiers parameters;
	Identifiers variables;

	public void insertParameter(String name, String type) {
		parameters.insert(name, type);
	}

	public void insertVariable(String name, String type) {
		variables.insert(name, type);
	}

	public String getParameter(String name) {
		return parameters.lookup(name);
	}

	public String getinsertVariable(String name) {
		return variables.lookup(name);
	}

	public void setExtendedName(String returnType) {
		this.returnType = returnType;
	}

	public void print() {
		System.out.println(returnType);
		parameters.print();
		variables.print();
	}

	public void printParameters() {
		parameters.print();
	}

	public void printVariables() {
		variables.print();
	}

}