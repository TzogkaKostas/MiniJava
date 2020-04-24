public class ExpressionInfo {
	String type;
	String value;

	public ExpressionInfo() {
	}

	public ExpressionInfo(String type) {
		this.type = type;
	}
	public ExpressionInfo(String type, String value) {
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
}