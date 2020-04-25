package SymbolTable;
import java.util.*;
import java.util.Map.Entry;

public class MethodInfo {
	String returnType;
	Variables allVariables;
	Variables parameters;

	public MethodInfo(String returnType) {
		this.returnType = returnType;
	}

	public MethodInfo(String returnType, Variables allVariables) {
		this.returnType = returnType;
		this.allVariables = allVariables;
	}

	public void insertVariable(String name, String type) {
		allVariables.insert(name, type);
	}

	public String getVariable(String name) {
		return allVariables.lookup(name);
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

	public Variables getAllVariables() {
		return this.allVariables;
	}

	public void setAllVariables(Variables allVariables) {
		this.allVariables = allVariables;
	}

	public void setParameters(Variables parameters) {
		this.parameters = new Variables(new LinkedHashMap<String, String>(parameters.getVariables()));
	}

	public boolean isDeclared(String identifier) {
		if (allVariables.exists(identifier)) {
			return true;
		} else {
			return false;
		}
	}

	public String getType(String identifier) {
		return allVariables.lookup(identifier);
	}

	public boolean validArguments(ArrayList<ExpressionInfo> args) {
		LinkedHashMap<String, String> params = parameters.getVariables();
		if (args.size() != params.size()) {
			return false;
		}
		int i = 0;
		for (Entry<String, String> entry : params.entrySet()) {
			if (args.get(i).getType() != entry.getValue() ) {
				return false;
			}
			i++;
		}
		return true;
	}

	public void print() {
		System.out.println(" returns " + returnType);
		System.out.print("Var Declaration: ");
		allVariables.print();
	}

	public void printallVariables() {
		allVariables.print();
	}

}