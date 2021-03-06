package Types;

public class ExpressionInfo {
	String id;
	String type;
	String value;
	String result;
	String code;

	public ExpressionInfo(String id, String type, String value, String result) {
		this.id = id;
		this.type = type;
		this.value = value;
		this.result = result;
	}

	public ExpressionInfo(String id, String type, String value, String result,
			String code) {
		this.id = id;
		this.type = type;
		this.value = value;
		this.result = result;
		this.code = code;
	}

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

	public String getResult() {
		return this.result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String toString() {
		return "{" +
			" id='" + getId() + "'" +
			", type='" + getType() + "'" +
			", value='" + getValue() + "'" +
			"}";
	}

}