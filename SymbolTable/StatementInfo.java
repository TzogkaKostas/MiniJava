package SymbolTable;

public class StatementInfo {
	ClassInfo classInfo;
	String curMethodName;

	public StatementInfo(ClassInfo classInfo, String curMethodName) {
		this.classInfo = classInfo;
		this.curMethodName = curMethodName;
	}

	public ClassInfo getClassInfo() {
		return this.classInfo;
	}

	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}

	public String getCurMethodName() {
		return this.curMethodName;
	}

	public void setCurMethodName(String curMethodName) {
		this.curMethodName = curMethodName;
	}

	public boolean isVarDeclared(String identifier) {
		MethodInfo methodInfo = classInfo.getMethod(curMethodName);
		if (classInfo.isVarDeclared(identifier) && methodInfo.isDeclared(identifier)) {
			return true;
		}
		else {
			return false;
		}
	}

	public boolean isMethodDeclared(String methodName) {
		return classInfo.isMethodDeclared(methodName);
	}

	public String getType(String identifier) {
		MethodInfo methodInfo = classInfo.getMethod(curMethodName);
		String type = methodInfo.getType(identifier);
		if (type != null) {
			return type;
		}
		else {
			return classInfo.getVarType(identifier);
		}
	}
}