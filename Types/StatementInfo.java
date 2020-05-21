package Types;
import java.util.*;

public class StatementInfo {
	ClassInfo classInfo;
	String curMethodName;
	StringBuilder code;

	public StatementInfo(ClassInfo classInfo, String curMethodName) {
		this.classInfo = classInfo;
		this.curMethodName = curMethodName;
		this.code = new StringBuilder("");
	}

	public StatementInfo(ClassInfo classInfo, String curMethodName, StringBuilder code) {
		this.classInfo = classInfo;
		this.curMethodName = curMethodName;
		this.code = code;
	}

	public ClassInfo getClassInfo() {
		return this.classInfo;
	}

	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}

	public String getName() {
		return classInfo.getName();
	}

	public String getCurMethodName() {
		return this.curMethodName;
	}

	public void setCurMethodName(String curMethodName) {
		this.curMethodName = curMethodName;
	}

	public StringBuilder getCode() {
		return this.code;
	}

	public void setCode(StringBuilder code) {
		this.code = code;
	}

	public void appendCode(String code) {
		this.code.append(code);
	}

	// public boolean isVarDeclared(String identifier) {
	// 	MethodInfo methodInfo = classInfo.getMethod(curMethodName);
	// 	if (classInfo.isVarDeclared(identifier) || methodInfo.isDeclared(identifier)) {
	// 		return true;
	// 	}
	// 	else {
	// 		return false;
	// 	}
	// }

	public boolean classHasMethod(String methodName) {
		return classInfo.isMethodDeclared(methodName);
	}

	public boolean validMethodArgs(SymbolTable symbolTable, String methodName, ArrayList<ExpressionInfo> args) {
		MethodInfo methodInfo = classInfo.getMethod(methodName);
		if (methodInfo == null ) {
			methodInfo = classInfo.getExtendsInfo().getMethod(methodName);
		}
		return methodInfo.validArguments(symbolTable, args);
	}

	public String getType(String identifier) {
		MethodInfo methodInfo = classInfo.getMethod(curMethodName);
		String type = methodInfo.getType(identifier);
		if (type != null) {
			return type;
		}
		return classInfo.getVarType(identifier);
	}

	public String getMethodReturnedType(String methodName) {
		MethodInfo methodInfo = classInfo.getMethod(methodName);
		if (methodInfo == null ) {
			methodInfo = classInfo.getExtendsInfo().getMethod(methodName);
		}
		return classInfo.getMethod(methodName).getReturnType();
	}

	public boolean isClassVariable(String variable) {
		return classInfo.variableExists(variable);
	}

	public void print() {
		classInfo.print();
		System.out.println(curMethodName);
	}
}