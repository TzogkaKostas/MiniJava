package SymbolTable;
import java.util.*;
import java.util.Map.Entry;

class Item {
	String className;
	String itemName;
	Integer offset;

	Item(String className, String itemName, Integer offset) {
		this.className = className;
		this.itemName = itemName;
		this.offset = offset;
	}

	String getClassName() {
		return className;
	}

	String getItemName() {
		return itemName;
	}

	Integer getOffset() {
		return offset;
	}
}

public class OffsetTable {
	ArrayList<Item> items;

	public OffsetTable() {
		this.items = new ArrayList<>();
	}

	public void insertItem(String className, String itemName, Integer offset) {
		items.add(new Item(className, itemName, offset));
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

	public void insertClass(String className, ClassInfo classInfo) {
		ClassInfo extendsInfo = classInfo.getExtendsInfo();
		Integer varOffset;
		if (extendsInfo == null) {
			varOffset = 0;
		}
		else {
			varOffset = extendsInfo.getVarOffset();
		}

		for (Entry<String, String> entry : classInfo.getVariables().getEntries() ) {
			insertItem(className, entry.getKey(), varOffset);
			varOffset += sizeOf(entry.getValue());
		}
		classInfo.setVarOffset(varOffset);
	}

	public void print() {
		for (Item item: items) {
			System.out.println(item.getClassName() + "." + item.getItemName() +
				" : " + item.getOffset() );
		}
	}
}