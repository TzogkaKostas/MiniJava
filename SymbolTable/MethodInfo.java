package SymbolTable;
import java.util.*;
import java.util.Map.Entry;

public class MethodInfo {
	String name;
	String returnType;
	Variables allVariables;
	Variables parameters;

	public MethodInfo(String name, String returnType) {
		this.name = name;
		this.returnType = returnType;
	}

	public MethodInfo(String name, String returnType, Variables allVariables) {
		this.name = name;
		this.returnType = returnType;
		this.allVariables = allVariables;
	}

	public String getName() {
		return this.name;
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

	public Variables getParameters() {
		return this.parameters;
	}

	public void setAllVariables(Variables allVariables) {
		this.allVariables = allVariables;
	}

	public void setParameters(Variables parameters) {
		this.parameters = new Variables(
			new LinkedHashMap<String, String>(parameters.getVariables()));
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

	public boolean validArguments(SymbolTable symbolTable, ArrayList<ExpressionInfo> args) {
		LinkedHashMap<String, String> params = parameters.getVariables();
		if (args.size() != params.size()) {
			return false;
		}
		int i = 0;
		for (Entry<String, String> entry : params.entrySet()) {
			ClassInfo classInfo = symbolTable.getClassInfo(args.get(i).getType());
			if (classInfo != null) {
				if (!classInfo.equivalentType(entry.getValue())) {
					return false;
				}
			}
			else {
				if (!args.get(i).getType().equals(entry.getValue())) {
					return false;
				}
			}
			i++;
		}
		return true;
	}

	public boolean exactValidArguments(ArrayList<ExpressionInfo> args) {
		LinkedHashMap<String, String> params = parameters.getVariables();
		if (args.size() != params.size()) {
			return false;
		}
		int i = 0;
		for (Entry<String, String> entry : params.entrySet()) {
			if (!args.get(i).getType().equals(entry.getValue())) {
				return false;
			}
			i++;
		}
		return true;
	}

	public void print() {
		System.out.println(" returns " + returnType);
		if (allVariables.getSize() != 0) {
			System.out.print("Var Declaration: ");
			allVariables.print();	
		}
	}

	public void printallVariables() {
		allVariables.print();
	}

}