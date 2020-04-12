package SymbolTable;

public class FunctionInfo {
	String returnType;
	Identifiers parameters;
	Identifiers variables;

	public FunctionInfo(String returnType) {
		this.returnType = returnType;
	}

	public FunctionInfo(String returnType, Identifiers parameters,
		Identifiers variables) {
		this.returnType = returnType;
		this.parameters = parameters;
		this.variables = variables;
	}

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

	public String getReturnType() {
		return this.returnType;
	}

	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}

	public Identifiers getParameters() {
		return this.parameters;
	}

	public void setParameters(Identifiers parameters) {
		this.parameters = parameters;
	}

	public Identifiers getVariables() {
		return this.variables;
	}

	public void setVariables(Identifiers variables) {
		this.variables = variables;
	}

	public void print() {
		System.out.println(" returns " + returnType);
		System.out.print("Params: ");
		parameters.print();
		System.out.print("Var Declaration: ");
		variables.print();
	}

	public void printParameters() {
		parameters.print();
	}

	public void printVariables() {
		variables.print();
	}

}