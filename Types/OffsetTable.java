package Types;
import java.util.*;
import java.util.Map.Entry;

class Item {
	String itemName;
	Integer offset;

	Item(String itemName, Integer offset) {
		this.itemName = itemName;
		this.offset = offset;
	}

	String getItemName() {
		return itemName;
	}

	Integer getOffset() {
		return offset;
	}
}

class Items {
	ArrayList<Item> vars;
	ArrayList<Item> methods;
	Items() {
		vars = new ArrayList<Item>();
		methods = new ArrayList<Item>();
	}

	public void insertVar(String itemName, Integer offset) {
		vars.add(new Item(itemName, offset));
	}

	public void insertMethod(String itemName, Integer offset) {
		methods.add(new Item(itemName, offset));
	}

	public ArrayList<Item> getVars() {
		return vars;
	}

	
	public ArrayList<Item> getMethods() {
		return methods;
	}

	public void print(String className) {
		printVars(className);
		printMethods(className);
	}


	public void printVars(String className) {
		System.out.println("--Variables---");
		for (Item item: vars) {
			System.out.println(className + "." + item.getItemName() +
				" : " + item.getOffset() );
		}
	}

	public void printMethods(String className) {
		System.out.println("---Methods---");
		for (Item item: methods) {
			System.out.println(className + "." + item.getItemName() +
				" : " + item.getOffset() );
		}
	}
}


public class OffsetTable {
	LinkedHashMap<String, Items> items;

	public OffsetTable() {
		this.items = new LinkedHashMap<String, Items>();
	}

	public void insertVar(String className, String itemName, Integer offset) {
		items.get(className).insertVar(itemName, offset);
	}

	public void insertMethod(String className, String itemName, Integer offset) {
		items.get(className).insertMethod(itemName, offset);
	}

	public void insertClass(ClassInfo classInfo) {
		Items classItems = new Items();
		items.put(classInfo.getName(), classItems);
		insertVars(classInfo);
		insertMethods(classInfo);
	}

	public void insertVars(ClassInfo classInfo) {
		ClassInfo extendsInfo = classInfo.getExtendsInfo();
		Integer varOffset;
		if (extendsInfo == null) {
			varOffset = 0;
		}
		else {
			varOffset = extendsInfo.getVarOffset();
		}

		for (Entry<String, String> entry : classInfo.getVariables().getEntries() ) {
			insertVar(classInfo.getName(), entry.getKey(), varOffset);
			varOffset += sizeOf(entry.getValue());
		}
		classInfo.setVarOffset(varOffset);
	}

	public void insertMethods(ClassInfo classInfo) {
		ClassInfo extendsInfo = classInfo.getExtendsInfo();
		Integer methodOffset;
		if (extendsInfo == null) {
			methodOffset = 0;
		}
		else {
			methodOffset = extendsInfo.getMethodOffset();
		}

		for (Entry<String, MethodInfo> entry : classInfo.getMethods().entrySet()) {
			if (extendsInfo != null) {
				if (extendsInfo.getMethod(entry.getKey()) != null) {
					continue;
				}
			}
			insertMethod(classInfo.getName(), entry.getKey(), methodOffset);
			methodOffset += 8;
		}
		classInfo.setMethodOffset(methodOffset);
	}

	
	public Integer sizeOf(String type) {
		if (type == "int") {
			return 4;
		}
		else if (type == "boolean") {
			return 1;
		}
		else {
			return 8;
		}
	}

	public void print() {
		for (Entry<String, Items> entry : items.entrySet()) {
			System.out.println("-----------Class " + entry.getKey() + "-----------");
			entry.getValue().print(entry.getKey());
			System.out.println("");
		}
	}
}