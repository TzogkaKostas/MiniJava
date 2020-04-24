import java.util.*;

import SymbolTable.*;

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

class OffsetTable {
    ArrayList<Item> items;

    OffsetTable() {
        this.items = new ArrayList<>();
    }

    void insertItem(String className, String itemName, Integer offset) {
        items.add(new Item(className, itemName, offset));
    }

    Integer sizeOf(String type) {
        return 1;
    }

    void insertClass(String className, ClassInfo classInfo, Integer varOffset,
            Integer methodOffset) {
		for (HashMap.Entry<String, String> entry : classInfo.getVariables().getEntries() ) {
			System.out.print("(" + entry.getKey() + ", " + entry.getValue() + "), ");
            insertItem(className, entry.getKey(), varOffset);
            varOffset += sizeOf(entry.getValue());
        }
    }

    public void print() {
		for (Item item: items) {
            System.out.println(item.getClassName() + "." + item.getItemName() +
                " : " + item.getOffset() );
		}
	}
}