package SymbolTable;
import java.util.HashMap;

public class Identifiers {
	HashMap<String, String> identifiers;

	public Identifiers() {
		identifiers = new HashMap<>();
	}

	public Identifiers(HashMap<String,String> identifiers) {
		this.identifiers = identifiers;
	}

	public void insert(String identifier, String type) {
		identifiers.put(identifier, type);
	}

	public String lookup(String identifier) { 
		return identifiers.get(identifier);
	}

	public void print() {
		for (HashMap.Entry<String, String> entry : identifiers.entrySet()) {
			System.out.println("key: " + entry.getKey() + "; value: " + entry.getValue());
		}
	}
}