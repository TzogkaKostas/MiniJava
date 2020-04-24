package SymbolTable;
import java.util.*;
import java.util.Map.Entry;

public class Variables {
	HashMap<String, String> variables;

	public Variables() {
		variables = new HashMap<>();
	}

	public Variables(HashMap<String, String> variables) {
		this.variables = variables;
	}

	public Variables(String id, String type) {
		this.variables = new HashMap<>();
		variables.put(id, type);
	}

	public void insert(String identifier, String type) {
		variables.put(identifier, type);
	}

	public Set<Entry<String, String>> getEntries() {
		return variables.entrySet();
	}

	public HashMap<String, String> getVariables() {
		return variables;
	}

	public String lookup(String identifier) { 
		return variables.get(identifier);
	}

	public boolean exists(String identifier) {
		if (variables.get(identifier) != null)
			return true;
		else
			return false;
	}

	public boolean isEmpty() {
		return variables.isEmpty();
	}

	public void print() {
		if (variables.isEmpty())
			return;
		System.out.print("[");
		for (HashMap.Entry<String, String> entry : variables.entrySet()) {
			System.out.print("(" + entry.getKey() + ", " + entry.getValue() + "), ");
		}
		System.out.println("]");
	}
}