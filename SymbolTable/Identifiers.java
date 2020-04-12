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

	public Identifiers(String id, String type) {
		this.identifiers = new HashMap<>();
		identifiers.put(id, type);
	}

	public void insert(String identifier, String type) {
		identifiers.put(identifier, type);
	}

	public String lookup(String identifier) { 
		return identifiers.get(identifier);
	}

	public void print() {
		if (identifiers.isEmpty())
			return;
		System.out.print("[");
		for (HashMap.Entry<String, String> entry : identifiers.entrySet()) {
			System.out.print("(" + entry.getKey() + ", " + entry.getValue() + "), ");
		}
		System.out.println("]");
	}
}