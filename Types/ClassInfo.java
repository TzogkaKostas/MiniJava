package Types;
import java.util.LinkedHashMap;
import java.util.*;
import java.util.Map.Entry;

public class ClassInfo {
	String name;
	String extendsName;
	ClassInfo extendsInfo;
	Variables variables;
	LinkedHashMap<String, MethodInfo> methods;
	Integer varOffset;
	Integer methodOffset;

	public ClassInfo(String name, Variables variables) {
		this.name = name;
		this.extendsName = "";
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
		this.varOffset = 0;
		this.methodOffset = 0;
	}

	public ClassInfo(String name, String extendsName, ClassInfo extendsInfo, Variables variables) {
		this.name = name;
		this.extendsName = extendsName;
		this.extendsInfo = extendsInfo;
		this.variables = variables;
		this.methods = new LinkedHashMap<>();
		this.varOffset = 0;
		this.methodOffset = 0;
	}

	public ClassInfo(String name, String methodName, MethodInfo methodInfo) {
		this.name = name;
		this.extendsName = "";
		this.variables = new Variables();
		this.methods = new LinkedHashMap<>();
		this.methods.put(methodName, methodInfo);
		this.varOffset = 0;
		this.methodOffset = 0;
	}

	public void insertVariable(String identifier, String type) {
		variables.insert(identifier, type);		
	}

	public void insertMethod(String name, MethodInfo method) {
		methods.put(name, method);
	}

	// public void setName(String name) {
	// 	this.name = name;
	// }

	public String getName() {
		return name;
	}

	public ClassInfo getExtendsInfo() {
		return this.extendsInfo;
	}

	public void setExtendedName(String extendsName) {
		this.extendsName = extendsName;
	}

	public String getExtendedName() {
		return this.extendsName;
	}

	public Variables getVariables() {
		return this.variables;
	}

	public void setVariables(Variables variables) {
		this.variables = variables;
	}

	public void setVarOffset(Integer varOffset) {
		this.varOffset = varOffset;
	}	
	
	public void setMethodOffset(Integer methodOffset) {
		this.methodOffset = methodOffset;
	}	

	public LinkedHashMap<String,MethodInfo> getMethods() {
		return this.methods;
	}

	public void setMethods(LinkedHashMap<String,MethodInfo> methods) {
		this.methods = methods;
	}

	public MethodInfo getMethod(String methodName) {
		MethodInfo methodInfo = methods.get(methodName);
		if (methodInfo != null) {
			return methodInfo;
		}
		if (extendsInfo != null) {
			return extendsInfo.getMethod(methodName);
		}
		else {
			return null;
		}
	}

	public Integer getVarOffset() {
		return this.varOffset;
	}

	public Integer getMethodOffset() {
		return this.methodOffset;
	}

	public boolean isMethodDeclared(String methodName) {
		if (methods.get(methodName) != null) {
			return true;
		}
		if (extendsInfo != null) {
			return extendsInfo.isMethodDeclared(methodName);
		}
		else {
			return false;
		}
	}

	public String getVarType(String identifier) {
		String type = variables.lookup(identifier);
		if (type != null ){
			return type;
		}
		if (extendsInfo != null) {
			return extendsInfo.getVarType(identifier);
		}
		return null;
	}

	public Integer validDeclaration(MethodInfo methodInfo) {
		if (methodExists(methodInfo.getName())) {
			return 0;
		}
		if (extendsInfo == null) {
			return 1;
		}
		MethodInfo otherMethodInfo = extendsInfo.getMethod(methodInfo.getName());
		if(otherMethodInfo != null) {
			return equalMethod(otherMethodInfo, methodInfo) ? 2 : 0;
		}
		else {
			return 1;
		}
	}

	public boolean equivalentType(String type) {
		if (type.equals(this.name)) {
			return true;
		}
		if (extendsInfo != null) {
			return extendsInfo.equivalentType(type);
		}
		else {
			return false;
		}
	}

	public boolean methodExists(String methodName) {
		if (methods.get(methodName) != null)
			return true;
		else
			return false;
	}

	public boolean classExtends(String superclass) {
		if (extendsInfo == null) {
			return false;
		}
		if (extendsInfo.getName().equals(superclass)){
			return true;
		}
		else {
			return extendsInfo.classExtends(superclass);
		}
	}

	public Boolean isOverridden(MethodInfo methodInfo) {
		MethodInfo otherMethodInfo = getMethod(methodInfo.getName());
		if (otherMethodInfo != null) {
			return equalMethod(otherMethodInfo, methodInfo);
		}
		return extendsInfo.isOverridden(methodInfo);
	}

	public boolean equalMethod(MethodInfo otherMethodInfo, MethodInfo methodInfo) {
		return otherMethodInfo.getReturnType().equals(methodInfo.getReturnType()) &&
				otherMethodInfo.exactValidArguments(getAsList(methodInfo.getParameters()));
	}

	public ArrayList<ExpressionInfo> getAsList(Variables vars) {
		ArrayList<ExpressionInfo> args = new ArrayList<ExpressionInfo>();
		for (Entry<String, String> entry : vars.getEntries()) {
			args.add(new ExpressionInfo("", entry.getValue(), ""));
		}
		return args;
	}

	public void print() {
		if (variables.getSize() != 0) {
			System.out.print("fields: ");
			variables.print();	
		}
		if (!methods.isEmpty()) {
			for (String name: methods.keySet()){
				System.out.print("Method " + name);
				methods.get(name).print();
			}
		}
	}

	public void printMethods() {
		for (String name: methods.keySet()){
			methods.get(name).print();
		}
	}

	public void printMethodsNames() {
		System.out.println(methods.keySet());
	}
	
}