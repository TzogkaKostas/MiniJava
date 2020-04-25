package SymbolTable;

public class ExpressionInfo {
	String id;
	String type;
	String value;

	public ExpressionInfo(String id, String type, String value) {
		this.id = id;
		this.type = type;
		this.value = value;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String toString() {
		return "{" +
			" id='" + getId() + "'" +
			", type='" + getType() + "'" +
			", value='" + getValue() + "'" +
			"}";
	}

}