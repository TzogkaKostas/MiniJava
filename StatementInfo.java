import SymbolTable.*;

public class StatementInfo {
	ClassInfo classInfo;
	String curFunctionName;

	public StatementInfo(ClassInfo classInfo, String curFunctionName) {
		this.classInfo = classInfo;
		this.curFunctionName = curFunctionName;
	}

	public ClassInfo getClassInfo() {
		return this.classInfo;
	}

	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}

	public String getCurFunctionName() {
		return this.curFunctionName;
	}

	public void setCurFunctionName(String curFunctionName) {
		this.curFunctionName = curFunctionName;
	}

	public boolean isVarDeclared(String identifier) {
		FunctionInfo functionInfo = classInfo.getFunctionInfo(curFunctionName);
		if (classInfo.isVarDeclared(identifier) && functionInfo.isDeclared(identifier)) {
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
		FunctionInfo functionInfo = classInfo.getFunctionInfo(curFunctionName);
		String type = functionInfo.getType(identifier);
		if (type != null) {
			return type;
		}
		else {
			return classInfo.getVarType(identifier);
		}
	}
}