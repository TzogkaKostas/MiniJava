import syntaxtree.*;
import visitor.GJDepthFirst;
import Types.*;
import java.util.*;
import java.util.Map.Entry;
import java.io.BufferedWriter;

public class GenerationVisitor extends GJDepthFirst<Object, Object> {
	SymbolTable symbolTable;
	OffsetTable offsetTable;
	BufferedWriter fileWriter;
	String codeBuffer;
	Map<String, String> types;
	Integer regCount;
	Integer labelCount;

	GenerationVisitor(SymbolTable symbolTable, OffsetTable offsetTable) {
		this.symbolTable = symbolTable;
		this.offsetTable = offsetTable;
		this.codeBuffer = "";
		this.regCount = 0;
		this.labelCount = 0;
		this.types = Map.of("boolean[]", "i8*", "boolean", "i1", "int[]", "i32*", "int", "i32");
	}

	public SymbolTable getSymbolTable() {
		return this.symbolTable;
	}

	public OffsetTable getOffsetTable() {
		return this.offsetTable;
	}

	public String getCodeBuffer() {
		return this.codeBuffer;
	}

	private void emit(String code) {
		// System.out.print(code);
		codeBuffer += code;
	}

	private void emitGeneralFunctions() {
		emit("declare i8* @calloc(i32, i32)\n");
		emit("declare i32 @printf(i8*, ...)\n");
		emit("declare void @exit(i32)\n\n");
		emit("@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n");
		emit("@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n");
		emit("@_cNSZ = constant [15 x i8] c\"Negative size\\0a\\00\"\n\n");
		emit("define void @print_int(i32 %i) {\n");
		emit("\t%_str = bitcast [4 x i8]* @_cint to i8*\n");
		emit("\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n");
		emit("\tret void\n");
		emit("}\n\n");
		emit("define void @throw_oob() {\n");
		emit("\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n");
		emit("\tcall i32 (i8*, ...) @printf(i8* %_str)\n");
		emit("\tcall void @exit(i32 1)\n");
		emit("\tret void\n");
		emit("}\n\n");
		emit("define void @throw_nsz() {\n");
		emit("\t%_str = bitcast [15 x i8]* @_cNSZ to i8*\n");
		emit("\tcall i32 (i8*, ...) @printf(i8* %_str)\n");
		emit("\tcall void @exit(i32 1)\n");
		emit("\tret void\n");
		emit("}\n\n");
	}

	private void emitVTables() {
		for (ClassInfo classInfo : symbolTable.getClasses()) {
			if (classInfo.getName() != symbolTable.getMainClassName()) {
				LinkedHashMap<String, MethodInfo> methods = classInfo.getTrueMethods();
				emit("@." + classInfo.getName() + "_vtable = global [" + methods.size() + " x i8*] [\n");
				emitVTable(classInfo, methods);
			} else {
				emit("@." + classInfo.getName() + "_vtable = global [0 x i8*] [");
			}
			emit("]\n\n");
		}
	}

	private void emitVTable(ClassInfo classInfo, LinkedHashMap<String, MethodInfo> methods) {
		Integer i = 0;
		for (MethodInfo methodInfo : methods.values()) {
			String entry = "\ti8* bitcast (" + getIRType(methodInfo.getReturnType()) + " "
					+ getIRTypes(methodInfo.getParamNames()) + "* @" +
					methodInfo.getOriginClassName() + "." + methodInfo.getName() + " to i8*)";

			// last row must not have a comma at the end
			if (i != methods.size() - 1) {
				emit(entry + ",\n");
			} else {
				emit(entry + "\n");
			}
			i += 1;
		}
	}

	private void nextReg() {
		this.regCount += 1;
	}

	private String newTemp() {
		String r = "%_" + String.valueOf(this.regCount);
		nextReg();
		return r;
	}

	private void nextLabel() {
		this.labelCount += 1;
	}

	private String newLabel() {
		String r = "L" + String.valueOf(this.labelCount);
		nextLabel();
		return r;
	}

	private String getIRType(String type) {
		String t = types.get(type);
		return t == null ? "i8*" : t;
	}

	private String getIRTypes(Collection<String> types) {
		String IRtypes = "(i8*";
		for (String type : types) {
			IRtypes += ", " + getIRType(type);
		}
		return IRtypes + ")";
	}

	private String typeOfPointer(String pointer) {
		return pointer.substring(0, pointer.lastIndexOf("*"));
	}

	private String getIRParams(MethodInfo methodInfo) {
		String IRParams = "(i8* %this";
		for (Entry<String, String> entry : methodInfo.getParameters().getEntries() ) {
			IRParams += ", " + getIRType(entry.getValue()) + " %." + entry.getKey();
		}
		return IRParams + ")";
	}

	private Integer getVarOffset(ClassInfo classInfo, String variable) {
		Integer varOffset = offsetTable.getVarOffset(classInfo.getName(), variable);
		if (varOffset != -1) {
			return varOffset;
		}
		else {
			return getVarOffset(classInfo.getExtendsInfo(), variable);
		}
	}

	private Integer getMethodOffset(ClassInfo classInfo, String methodName) {
		Integer varOffset = offsetTable.getMethodOffset(classInfo.getName(), methodName);
		if (varOffset != -1) {
			return varOffset;
		}
		else {
			return getMethodOffset(classInfo.getExtendsInfo(), methodName);
		}
	}

	private String paramsAllocation(MethodInfo methodInfo) {
		String localVariables = "";
		for (Entry<String, String> entry : methodInfo.getParameters().getEntries() ) {
			String IRtype = getIRType(entry.getValue());
			localVariables += "\t%" + entry.getKey() + " = alloca " + IRtype + "\n";
			localVariables += "\tstore " + IRtype + " %." + entry.getKey()+ ", " + IRtype + "* %" + 
					entry.getKey() + "\n";
		}
		return localVariables;
	}

	private String getMethodArgs(ArrayList<ExpressionInfo> args) {
		String IRargs = "";
		for (ExpressionInfo exprInfo : args) {
			IRargs += ", " + getIRType(exprInfo.getType()) + " " + exprInfo.getResult();
		}
		return IRargs;
	}

	private String getMethodArgsIRTypes(ArrayList<ExpressionInfo> args) {
		String IRargsTypes = "";
		for (ExpressionInfo exprInfo : args) {
			IRargsTypes += ", " + getIRType(exprInfo.getType());
		}
		return IRargsTypes;
	}

	private String getMethodArgsCode(ArrayList<ExpressionInfo> args) {
		String argsCode = "";
		for (ExpressionInfo exprInfo : args) {
			argsCode += exprInfo.getCode();
		}
		return argsCode;
	}
	

	// private ArrayList<String> classesThatInheritMethod(String superClass, String method) {
	// 	ArrayList<String> classes = new ArrayList<>();
	// 	for(ClassInfo classInfo : symbolTable.getClasses() ) {
	// 		if (classInfo.classExtends(superClass) && !classInfo.methodExists(method)) {
	// 			classes.add(classInfo.getName());
	// 		}
	// 	}
	// 	return classes;
	// }

	// private String removeLastComma(String str) {
	// 	return str.substring(0, str.lastIndexOf(","));
	// }

   /**
	* f0 -> Block()
	*       | AssignmentStatement()
	*       | ArrayAssignmentStatement()
	*       | IfStatement()
	*       | WhileStatement()
	*       | PrintStatement()
	*/
	public Object visit(Statement n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		String statementCode = (String) n.f0.accept(this, argu);
		statementInfo.appendCode(statementCode + "\n");

		return null;
	}

	/**
	* f0 -> "{"
	* f1 -> ( Statement() )*
	* f2 -> "}"
	*/
	public Object visit(Block n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		StatementInfo newStatementInfo = new StatementInfo(statementInfo.getClassInfo(),
				statementInfo.getCurMethodName());
		n.f1.accept(this, newStatementInfo);

		return newStatementInfo.getCode().toString();
	}

   	/**
	* f0 -> Identifier()
	* f1 -> "="
	* f2 -> Expression()
	* f3 -> ";"
	*/
	public Object visit(AssignmentStatement n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		String identifier = (String) n.f0.accept(this, statementInfo);
		String type = statementInfo.getType(identifier);

		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, statementInfo);
		String assignmentCode = exprInfo.getCode();
		if (statementInfo.isClassVariable(identifier)) {
			String t1 = newTemp();
			String t2 = newTemp();
			Integer varOffset = getVarOffset(statementInfo.getClassInfo(), identifier);
			assignmentCode += "\t" + t1 + " = getelementptr i8, i8* %this, i32 " +
					varOffset + "\n";
			assignmentCode += "\t" + t2 + " = bitcast i8* " + t1 + " to " + 
					getIRType(type) + "*\n";
			assignmentCode += "\tstore " + getIRType(type) + " " +
					exprInfo.getResult() + ", " + getIRType(type) + "* " + t2 + "\n";
		}
		else {
			assignmentCode += "\tstore " + getIRType(type) + " " + exprInfo.getResult() +
					", " + getIRType(type) + "* %" + identifier + "\n";
		
		}

		// String t1 = newTemp();
		// String t2 = newTemp();
		// String t3 = newTemp();

		// String storedVarName;
		// if (statementInfo.isClassVariable(identifier)) {
		// 	Integer varOffset = getVarOffset(statementInfo.getClassInfo(), identifier);
		// 	assignmentCode += "\t" + t1 + " = getelementptr i8, i8* %this, i32 " +
		// 			varOffset + "\n";
		// 	if (type.equals("int")) {
		// 		assignmentCode += "\t" + t2 + " = bitcast i8* " + t1 + " to i32*\n";
		// 	}
		// 	storedVarName = t2;
		// }
		// else {
		// 	storedVarName = "%" + identifier;
		// }

		// String exprIRtype;
		// // if (type.equals("int")) {
		// // 	t3 = exprInfo.getResult();
		// // 	exprIRtype = "i32";
		// // }
		// // else {
		// // 	assignmentCode += "\t" + t3 + " = zext i1 " + exprInfo.getResult() + " to i8\n";
		// // 	exprIRtype = "i8";
		// // }
		// exprIRtype = getIRType(type);

		// assignmentCode += "\tstore " + exprIRtype + " " + t3 + ", " + exprIRtype +
		// 		"* " + storedVarName + "\n";

		return assignmentCode;
	}

	/**
	* f0 -> Identifier()
	* f1 -> "["
	* f2 -> Expression()
	* f3 -> "]"
	* f4 -> "="
	* f5 -> Expression()
	* f6 -> ";"
	*/
	public Object visit(ArrayAssignmentStatement n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		String identifier = (String) n.f0.accept(this, statementInfo);
		String type = statementInfo.getType(identifier);

		ExpressionInfo exprInfo1 = (ExpressionInfo) n.f2.accept(this, statementInfo);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f5.accept(this, statementInfo);

		String t0 = newTemp();
		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();
		String t4 = newTemp();
		String t5 = newTemp();
		String t6 = newTemp();
		String t7 = newTemp();
		String t8 = newTemp();
		String label1 = newLabel();
		String label2 = newLabel();

		String arrayCode = exprInfo1.getCode();
		arrayCode += "\t" + t0 + " = load " + getIRType(type) + ", " + 
				getIRType(type) + "* %" + identifier + "\n";
		
		if (type.equals("boolean[]")) {
			arrayCode += "\t" + t1 + " = bitcast i8* " + t0 + " to i32*\n";
		}
		else {
			t1 = t0;
		}

		arrayCode += "\t" + t2 + " = load i32, i32* " + t1 + "\n";
		arrayCode += "\t" + t3 + " = icmp sge i32 " + exprInfo1.getResult() + ", 0\n";
		arrayCode += "\t" + t4 + " = icmp slt i32 0, " + t2 + "\n";
		arrayCode += "\t" + t5 + " = and i1 " + t4 + ", " + t5 + "\n";
		arrayCode += "\tbr i1 " + t5 + ", label %" + label1 + ", label %" + label2 + "\n";
		arrayCode += label2 + ":\n";
		arrayCode += "\tcall void @throw_oob()\n";
		arrayCode += "\tbr label %" + label1 + "\n";
		arrayCode += label1 + ":\n";
		String lengthIndex = type.equals("boolean[]") ? "4" : "1";
		arrayCode += "\t" + t6 + " = add i32 " + lengthIndex + ", " + exprInfo1.getResult() + "\n";

		String exprIRtype;
		if (type.equals("int[]")) {
			t7 = exprInfo2.getResult();
			exprIRtype = "i32";
		}
		else {
			arrayCode += exprInfo2.getCode() + "\t" + t7 + " = zext i1 " + 
					exprInfo2.getResult() + " to i8";
			exprIRtype = "i8";
		}

		arrayCode += "\t" + t8 + " = getelementptr " + exprIRtype + ", " + exprIRtype + 
				"* " + t0 + ", i32 " + t6 + "\n";
		arrayCode += "\tstore " + exprIRtype + " " + exprInfo2.getResult() + ", " +
				exprIRtype + "* " + t8 + "\n";

		return arrayCode;
	}

	/**
	* f0 -> "if"
	* f1 -> "("
	* f2 -> Expression()
	* f3 -> ")"
	* f4 -> Statement()
	* f5 -> "else"
	* f6 -> Statement()
	*/
	public Object visit(IfStatement n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, argu);

		String trueLabel = newLabel();
		String falseLabel = newLabel();
		String endLabel = newLabel();
	
		String ifCode = exprInfo.getCode();
		ifCode += "\tbr i1 " + exprInfo.getResult() + ", label %" + 
				trueLabel + ", label %" + falseLabel + "\n";

		ifCode += trueLabel + ":\n";
		StatementInfo statementInfo1 = new StatementInfo(statementInfo.getClassInfo(),
				statementInfo.getCurMethodName());
		n.f4.accept(this, statementInfo1);	
		ifCode += statementInfo1.getCode();
		ifCode += "\tbr label %" + endLabel + "\n";

		ifCode += falseLabel + ":\n";
		StatementInfo statementInfo2 = new StatementInfo(statementInfo.getClassInfo(), 
				statementInfo.getCurMethodName());
		n.f6.accept(this, statementInfo2);
		ifCode += statementInfo2.getCode();
		ifCode += "\tbr label %" + endLabel + "\n";
		ifCode += endLabel + ":\n";

		return ifCode;
	}

   	/**
	* f0 -> "while"
	* f1 -> "("
	* f2 -> Expression()
	* f3 -> ")"
	* f4 -> Statement()
	*/
	public Object visit(WhileStatement n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		String label1 = newLabel();
		String label2 = newLabel();
		String label3 = newLabel();

		String whileCode = "\tbr label %" + label1 + "\n";
		// start of loop
		whileCode += label1 + ":\n";

		// Check the condition
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, argu);
		whileCode += exprInfo.getCode();
		whileCode += "\tbr i1 " + exprInfo.getResult() + ", label %" + label2 + 
				", label %" + label3 + "\n";

		// Statements
		whileCode += label2 + ":\n";
		StatementInfo statementInfo1 = new StatementInfo(statementInfo.getClassInfo(),
				statementInfo.getCurMethodName());
		n.f4.accept(this, statementInfo1);
		whileCode += statementInfo1.getCode();

		// loop again
		whileCode += "\tbr label %" + label1 + "\n";

		// end of loop
		whileCode += label3 + ":\n";

		return whileCode;
	}

   	/**
	* f0 -> "System.out.println"
	* f1 -> "("
	* f2 -> Expression()
	* f3 -> ")"
	* f4 -> ";"
	*/
	public Object visit(PrintStatement n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, argu);

		String printCode = exprInfo.getCode();
		printCode += "\tcall void (i32) @print_int(i32 " + exprInfo.getResult() + ")\n";

		return printCode;
	 }

    /**
	* f0 -> Clause()
	* f1 -> "&&"
	* f2 -> Clause()
	*/
	public Object visit(AndExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String trueLabel = newLabel();
		String falseLabel = newLabel();
		String endFalseLabel = newLabel();
		String endLabel = newLabel();
		String result = newTemp();

		String andCode = exprInfo.getCode();
		andCode += "\tbr i1 " + exprInfo.getResult() + ", label %" + falseLabel + 
				", label %" + trueLabel + "\n";
		andCode += trueLabel + ":\n";
		andCode += "\tbr label %" + endLabel + "\n";

		andCode += falseLabel + ":\n";
		andCode += exprInfo2.getCode();
		andCode += "\tbr label %" + endFalseLabel + "\n";
		andCode += endFalseLabel + ":\n";
		andCode += "\tbr label %" + endLabel + "\n";

		andCode += endLabel + ":\n";
		andCode += "\t" + result + " = phi i1 [0, %" + trueLabel +"], [" + exprInfo2.getResult() +
				", %" + endFalseLabel + "]\n";

		return new ExpressionInfo("", "boolean", "", result, andCode);
	}

   	/**
	* f0 -> PrimaryExpression()
	* f1 -> "<"
	* f2 -> PrimaryExpression()
	*/
	public Object visit(CompareExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String result = newTemp();

		String compareCode = exprInfo.getCode() + exprInfo2.getCode();
		compareCode += "\t" + result + " = icmp slt i32 " + exprInfo.getResult() + ", " +
				exprInfo2.getResult() + "\n";

		return new ExpressionInfo("", "boolean", "", result, compareCode);
	}

	  /**
	* f0 -> PrimaryExpression()
	* f1 -> "+"
	* f2 -> PrimaryExpression()
	*/
	public Object visit(PlusExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String result = newTemp();

		String plusCode = exprInfo.getCode() + exprInfo2.getCode();
		plusCode += "\t" + result + " = " + "add i32 " + exprInfo.getResult() +
				", " + exprInfo2.getResult() + "\n";

		return new ExpressionInfo("", "int", "", result, plusCode);
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "-"
	  * f2 -> PrimaryExpression()
	  */
	 public Object visit(MinusExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String result = newTemp();

		String plusCode = exprInfo.getCode() + exprInfo2.getCode();
		plusCode += "\t" + result + " = " + " sub i32 " + exprInfo.getResult() +
				", " + exprInfo2.getResult() + "\n";

		return new ExpressionInfo("", "int", "", result, plusCode);
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "*"
	  * f2 -> PrimaryExpression()
	  */
	 public Object visit(TimesExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String result = newTemp();

		String plusCode = exprInfo.getCode() + exprInfo2.getCode();
		plusCode += "\t" + result + " = " + " mul i32 " + exprInfo.getResult() +
				", " + exprInfo2.getResult() + "\n";

		return new ExpressionInfo("", "int", "", result, plusCode);
	}
	
   /**
	* f0 -> PrimaryExpression()
	* f1 -> "["
	* f2 -> PrimaryExpression()
	* f3 -> "]"
	*/
	public Object visit(ArrayLookup n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		String type1 = exprInfo.getType();

		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);

		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();
		String t4 = newTemp();
		String t5 = newTemp();
		String t6 = newTemp();
		String t7 = newTemp();
		String t8 = newTemp();
		String result = newTemp();
		String label1 = newLabel();
		String label2 = newLabel();

		String lookupCode = exprInfo.getCode() + exprInfo2.getCode();
		if (type1.equals("boolean[]")) {
			lookupCode += "\t" + t1 + " = bitcast i8* " + exprInfo.getResult() + " to i32*";
		}
		else {
			t1 = exprInfo.getResult();
		}

		lookupCode += "\t" + t2 + " = load i32, i32* " + t1 + "\n";
		lookupCode += "\t" + t3 + " = icmp sge i32 " + exprInfo2.getResult() + ", 0\n";
		lookupCode += "\t" + t4 + " = icmp slt i32 " + exprInfo2.getResult() + ", " +
				t2 + "\n";
		lookupCode += "\t" + t5 + " = and i1 " + t3 + ", " + t4 + "\n";
		lookupCode += "\tbr i1 " + t5 + ", label %" + label1 + ", label %" +
				label2 + "\n";
		lookupCode += label2 + ":\n";
		lookupCode += "\tcall void @throw_oob()\n";
		lookupCode += "\tbr label %" + label1 + "\n";
		lookupCode += label1 + ":\n";
		lookupCode += "\t" + t6 + " = add i32 1, " + exprInfo2.getResult() + "\n";

		String elementType = type1.equals("boolean[]") ? "i8" : "i32";
		lookupCode += "\t" + t7 + " = getelementptr " + elementType + ", " +
				elementType + "* " + exprInfo.getResult() + ", i32 " + t6 + "\n";
		lookupCode += "\t" + t8 + " = load " + elementType + ", " + 
				elementType + "* " + t7 + "\n";

		if (type1.equals("boolean[]")) {
			lookupCode += "\t" + result + " = trunc i8 " + t8 + " to i1\n";
		}
		else {
			result = t8;
		}

		return new ExpressionInfo("", type1.substring(0, type1.indexOf('[')), 
				"", result, lookupCode);
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "."
	  * f2 -> "length"
	  */
	 public Object visit(ArrayLength n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		String type = exprInfo.getType();

		String t1 = newTemp();
		String result = newTemp();

		String lengthCode = exprInfo.getCode();
		if (type.equals("boolean[]")) {
			lengthCode += "\t" + t1 + " = bitcast i8* " + exprInfo.getResult() + " to i32*";
		}
		else {
			t1 = exprInfo.getResult();
		}

		lengthCode += "\t" + result + " = load i32, i32* " + t1 + "\n";

		return new ExpressionInfo("", "int", "", result, lengthCode);
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "."
	  * f2 -> Identifier()
	  * f3 -> "("
	  * f4 -> ( ExpressionList() )?
	  * f5 -> ")"
	  */
	 public Object visit(MessageSend n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		String methodName = (String) n.f2.accept(this, argu);
		String returnType = symbolTable.getMethodReturnedType(exprInfo.getType(),
				methodName);

		ArrayList<ExpressionInfo> args = new ArrayList<ExpressionInfo>();
		Object array[] = new Object[2];
		array[0] = (Object) statementInfo;
		array[1] = (Object) args;
		n.f4.accept(this, array);

		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();
		String t4 = newTemp();
		String t5 = newTemp();
		String t6 = newTemp();
		String result = newTemp();

		String messageCode = exprInfo.getCode() + getMethodArgsCode(args);
		messageCode += "\t" + t1 + " = bitcast i8* " + exprInfo.getResult() +
				" to i8***\n";
		messageCode += "\t" + t2 + " = load i8**, i8*** " + t1 + "\n";
		Integer methodOffset = getMethodOffset(symbolTable.getClassInfo(exprInfo.getType()), methodName);
		messageCode += "\t" + t3 + " = getelementptr i8*, i8** " + t2 + ", i32 " + 
				methodOffset/8 + "\n";
		messageCode += "\t" + t4 + " = load i8*, i8** " + t3 + "\n";
		messageCode += "\t" + t5 + " = bitcast i8* " + t4 + " to " + getIRType(returnType) +
				" (i8*" + getMethodArgsIRTypes(args) + ")*\n";
		messageCode += "\t" + t6 + " = call " + getIRType(returnType) + " " + 
				t5 + "(i8* " + exprInfo.getResult() + getMethodArgs(args) + ")\n";

		if (returnType.equals("boolean[]")) {
			messageCode += "\t" + result + " = trunc i8 " + t6 + " to i1\n";
		}
		else {
			result = t6;
		}
		return new ExpressionInfo("", returnType, "", result, messageCode);
	}
  
	/**
	  * f0 -> Expression()
	  * f1 -> ExpressionTail()
	*/
	@SuppressWarnings("unchecked")
	public Object visit(ExpressionList n, Object argu) {
		Object array[] = (Object[]) argu;

		StatementInfo statementInfo = (StatementInfo) array[0];
		ArrayList<ExpressionInfo> args = (ArrayList<ExpressionInfo>) array[1];

		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, statementInfo);
		args.add(exprInfo);
		
		n.f1.accept(this, argu);
		return null;
	}
  
	/**
	  * f0 -> ( ExpressionTerm() )*
	*/
	public Object visit(ExpressionTail n, Object argu) {
		return n.f0.accept(this, argu);
	}
  
	/**
	* f0 -> ","
	* f1 -> Expression()
	*/
	@SuppressWarnings("unchecked")
	 public Object visit(ExpressionTerm n, Object argu) {
		Object array[] = (Object[]) argu;

		StatementInfo statementInfo = (StatementInfo) array[0];
		ArrayList<ExpressionInfo> args = (ArrayList<ExpressionInfo>) array[1];

		ExpressionInfo exprInfo = (ExpressionInfo) n.f1.accept(this, statementInfo);
		args.add(exprInfo);
		return null;
	 }

	/**
	* f0 -> "!"
	* f1 -> Clause()
	*/
	public Object visit(NotExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f1.accept(this, argu);

		// String result = newTemp();
		// String btrue = newLabel();
		// String bfalse = newLabel();
		// String end = newLabel();

		// String notCode = exprInfo.getCode();
		// notCode += "br i1 " + exprInfo.getResult() + ", label %btrue, label %bfalse\n" ;
		// notCode += btrue + ":\n";
		// notCode += "\t" + result + " = add i1 0, 0\n";
		// notCode += "\tbr label %end\n";
		// notCode += bfalse + ":\n";
		// notCode += "\t" + result + " = add i1 1, 0\n";
		// notCode += "\tbr label %end\n";
		// notCode += end + ":\n";

		String result = newTemp();
		String trueLabel = newLabel();
		String falseLabel = newLabel();
		String endLabel = newLabel();

		String notCode = exprInfo.getCode();
		notCode += "\tbr i1 " + exprInfo.getResult() + ", label %" + trueLabel + 
				", label %" + falseLabel + "\n";
		notCode += trueLabel + ":\n";
		notCode += "\tbr label %" + endLabel + "\n";

		notCode += falseLabel + ":\n";
		notCode += "\tbr label %" + endLabel + "\n";

		notCode += endLabel + ":\n";
		notCode += "\t" + result + " = phi i1 [0, %" + trueLabel +"], [1, %" +
				falseLabel + "]\n";

		exprInfo.setResult(result);
		exprInfo.setCode(notCode);
		return exprInfo;
   }
  
	/**
	* f0 -> IntegerLiteral()
	*		| TrueLiteral()
	*		| FalseLiteral()
	*		| Identifier()
	*		| ThisExpression()
	*		| ArrayAllocationExpression()
	*		| AllocationExpression()
	*		| BracketExpression()
	*/
	public Object visit(PrimaryExpression n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;

		if (n.f0.which == 0) {
			String integerLiteral = (String) n.f0.accept(this, null);
			return new ExpressionInfo("", "int", integerLiteral, integerLiteral, "");
		}
		else if (n.f0.which == 1 || n.f0.which == 2) {
			String booleanLiteral = (String) n.f0.accept(this, null);
			String booleanValue = (booleanLiteral == "true" ? "1" : "0");
			return new ExpressionInfo("", "boolean", booleanLiteral, booleanValue, "");
		}
		else if (n.f0.which == 3) {
			String variable = (String) n.f0.accept(this, null);
			String type = statementInfo.getType(variable);

			String result = newTemp();

			String idCode;
			if (statementInfo.isClassVariable(variable)) {
				String t1 = newTemp();
				String t2 = newTemp();
				Integer varOffset = getVarOffset(statementInfo.getClassInfo(), variable);

				idCode = "\t" + t1 + " = getelementptr i8, i8* %this, i32 " + varOffset + "\n";
				idCode += "\t" + t2 + " = bitcast i8* " + t1 + " to " + getIRType(type) + "*\n";
				idCode += "\t" + result + " = load " + getIRType(type) + ", " +
						getIRType(type) + "* " + t2 + "\n";
			} else {
				idCode = "\t" + result + " = load " + getIRType(type) + ", " +
						getIRType(type) + "* %" + variable + "\n";	
			}

			// if (type.equals("boolean")) {
			// 	idCode += "\t" + result + " = trunc i8 " + t3 + " to i1\n";
			// }
			// else {
			// 	result = t3;
			// }

			return new ExpressionInfo(variable, type, "", result, idCode);
		}
		else if (n.f0.which == 4) {
			return new ExpressionInfo("", statementInfo.getName(), "this", "%this",
					"");
		}
		else if (n.f0.which == 6) {
			ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);

			return new ExpressionInfo("new", exprInfo.getType(), "", 
					exprInfo.getResult(), exprInfo.getCode());
		}
		else { // 5 || 7
			return n.f0.accept(this, argu);
		}
	}

	/**
	* f0 -> <INTEGER_LITERAL>
	*/
	public Object visit(IntegerLiteral n, Object argu) {
		return n.f0.toString();
	}

	/**
	* f0 -> "true"
	*/
	public Object visit(TrueLiteral n, Object argu) {
		return n.f0.toString();
	}

	/**
	* f0 -> "false"
	*/
	public Object visit(FalseLiteral n, Object argu) {
		return n.f0.toString();
	}

   /**
	* f0 -> "new"
	* f1 -> "boolean"
	* f2 -> "["
	* f3 -> Expression()
	* f4 -> "]"
	*/
	public Object visit(BooleanArrayAllocationExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f3.accept(this, argu);

		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();
		String t4 = newTemp();
		String label1 = newLabel();
		String label2 = newLabel();

		String boolArrayCode = exprInfo.getCode();
		boolArrayCode += "\t" + t1 + " = add i32 4, " + exprInfo.getResult() + "\n";
		boolArrayCode += "\t" + t2 + " = icmp sge i32 " + t1 + ", 4\n";
		boolArrayCode += "\tbr i1 " + t2 + ", label %" + label1 + ", label %" + 
				label2 + "\n";
		boolArrayCode += label2 + ":\n";
		boolArrayCode += "\tcall void @throw_nsz()\n";
		boolArrayCode += "\tbr label %" + label1 + "\n";
	
		boolArrayCode += label1 + ":\n";
		boolArrayCode += "\t" + t3 + " = call i8* @calloc(i32 1, i32 " + t1 + ")\n";
		boolArrayCode += "\t" + t4 + " = bitcast i8* " + t3 + " to i32*\n";
		boolArrayCode += "\tstore i32 " + exprInfo.getResult() + ", i32* " + t4 + "\n";

		return new ExpressionInfo("new", "boolean[]", "", t3, boolArrayCode);
	}

   /**
	* f0 -> "new"
	* f1 -> "int"
	* f2 -> "["
	* f3 -> Expression()
	* f4 -> "]"
	*/
   public Object visit(IntegerArrayAllocationExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f3.accept(this, argu);

		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();
		String t4 = newTemp();
		String label1 = newLabel();
		String label2 = newLabel();

		String intArrayCode = exprInfo.getCode();
		intArrayCode += "\t" + t1 + " = add i32 1, " + exprInfo.getResult() + "\n";
		intArrayCode += "\t" + t2 + " = icmp sge i32 " + t1 + ", 1\n";
		intArrayCode += "\tbr i1 " + t2 + ", label %" + label1 + ", label %" + label2 + "\n";
		intArrayCode += label2 + ":\n";
		intArrayCode += "\tcall void @throw_nsz()\n";
		intArrayCode += "\tbr label %" + label1 + "\n";
		intArrayCode += label1 + ":\n";
		intArrayCode += "\t" + t3 + " = call i8* @calloc(i32 " + t1 + ", i32 4)\n";
		intArrayCode += "\t" + t4 + " = bitcast i8* " + t3 + " to i32*\n";
		intArrayCode += "\t" + "store i32 " + exprInfo.getResult() + ", i32* " + t4 + "\n";
	
		return new ExpressionInfo("new", "int[]", "", t4, intArrayCode);
   	}

	/**
	* f0 -> "new"
	* f1 -> Identifier()
	* f2 -> "("
	* f3 -> ")"
	*/
	public Object visit(AllocationExpression n, Object argu) {
		// StatementInfo statementInfo = (StatementInfo) argu;		

		String identifier = (String) n.f1.accept(this, argu);
		// String type = statementInfo.getType(identifier);
		Integer size = symbolTable.getClassSize(identifier);
		Integer numOfMethods = symbolTable.getNumOfMethods(identifier);

		String t1 = newTemp();
		String t2 = newTemp();
		String t3 = newTemp();

		String allocationCode;
		allocationCode = "\t" + t1 + " = call i8* @calloc(i32 1, i32 " + size + ")\n";
		allocationCode += "\t" + t2 + " = bitcast i8* " + t1 + " to i8***\n";
		allocationCode += "\t" + t3 + " = getelementptr [" + numOfMethods + " x i8*], [" + 
				numOfMethods + " x i8*]* @." + identifier + "_vtable, i32 0, i32 0\n";
		allocationCode += "\tstore i8** " + t3 + ", i8*** " + t2 + "\n";

		return new ExpressionInfo("new", identifier, "", t1, allocationCode);
	}

	
    /**
	* f0 -> "("
	* f1 -> Expression()
	* f2 -> ")"
	*/
	public Object visit(BracketExpression n, Object argu) {
		return n.f1.accept(this, argu);
   	}  

   	/**
	* f0 -> "class"
	* f1 -> Identifier()
	* f2 -> "{"
	* f3 -> "public"
	* f4 -> "static"
	* f5 -> "void"
	* f6 -> "main"
	* f7 -> "("
	* f8 -> "String"
	* f9 -> "["
	* f10 -> "]"
	* f11 -> Identifier()
	* f12 -> ")"
	* f13 -> "{"
	* f14 -> ( VarDeclaration() )*
	* f15 -> ( Statement() )*
	* f16 -> "}"
	* f17 -> "}"
	*/
	public Object visit(MainClass n, Object argu) {
		emitVTables();
		emitGeneralFunctions();

		String className = (String) n.f1.accept(this, argu);
		ClassInfo classInfo = symbolTable.getClassInfo(className);
		
		emit("define i32 @main() {\n");

		StringBuilder varCode  = new StringBuilder("");
		n.f14.accept(this, varCode);
		emit(varCode.toString());

		StatementInfo statementInfo = new StatementInfo(classInfo, "main");
		n.f15.accept(this, statementInfo);
		emit(statementInfo.getCode().toString());

		emit("\tret i32 0\n}\n\n");
		return null;
	}

	/**
	* f0 -> "class"
	* f1 -> Identifier()
	* f2 -> "{"
	* f3 -> ( VarDeclaration() )*
	* f4 -> ( MethodDeclaration() )*
	* f5 -> "}"
	*/
	public Object visit(ClassDeclaration n, Object argu) {
		String className = (String) n.f1.accept(this, argu);
		ClassInfo classInfo = symbolTable.getClassInfo(className);

		// n.f3.accept(this, null);
		n.f4.accept(this, classInfo);
		return null;
	}
  
	/**
	 * f0 -> "class"
	* f1 -> Identifier()
	* f2 -> "extends"
	* f3 -> Identifier()
	* f4 -> "{"
	* f5 -> ( VarDeclaration() )*
	* f6 -> ( MethodDeclaration() )*
	* f7 -> "}"
	*/
	public Object visit(ClassExtendsDeclaration n, Object argu) {
		String className = (String) n.f1.accept(this, argu);
		ClassInfo classInfo = symbolTable.getClassInfo(className);

		// n.f5.accept(this, null);
		n.f6.accept(this, classInfo);
		return null;
	}

	/**
	* f0 -> "public"
	* f1 -> Type()
	* f2 -> Identifier()
	* f3 -> "("
	* f4 -> ( FormalParameterList() )?
	* f5 -> ")"
	* f6 -> "{"
	* f7 -> ( VarDeclaration() )*
	* f8 -> ( Statement() )*
	* f9 -> "return"
	* f10 -> Expression()
	* f11 -> ";"
	* f12 -> "}"
	*/
	public Object visit(MethodDeclaration n, Object argu) {
		ClassInfo classInfo = (ClassInfo) argu;
		String type = (String) n.f1.accept(this, argu);
		String methodName = (String) n.f2.accept(this, argu);

		String methodHeader = "define " + getIRType(type) + " @" + classInfo.getName() + "." +
				methodName + getIRParams(classInfo.getMethod(methodName)) + " {\n";
		String paramsAllocation = paramsAllocation(classInfo.getMethod(methodName));

		StringBuilder declarationCode = new StringBuilder("");
		n.f7.accept(this, declarationCode);

		StatementInfo statementInfo = new StatementInfo(classInfo, methodName);
		n.f8.accept(this, statementInfo);

		ExpressionInfo exprInfo = (ExpressionInfo) n.f10.accept(this, statementInfo);
		String returnCode = exprInfo.getCode() + "\tret " + getIRType(type) +
				" " + exprInfo.getResult() + "\n}\n\n";

		String body = paramsAllocation + declarationCode + statementInfo.getCode() + 
				returnCode;
		emit(methodHeader + body);
		return null;
	}

	/**
	* f0 -> Type()
	* f1 -> Identifier()
	* f2 -> ";"
	*/
	public Object visit(VarDeclaration n, Object argu) {
		StringBuilder declarationCode = (StringBuilder) argu;
		String type = (String) n.f0.accept(this, null);
		String identifier = (String) n.f1.accept(this, null);

		declarationCode.append("\t%" + identifier + " = alloca " + getIRType(type) + "\n");

		return null;
	 }

	/**
    * f0 -> <IDENTIFIER>
    */
	public Object visit(Identifier n, Object argu) {
		return n.f0.toString();
	}

 	/**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
	public Object visit(Type n, Object argu) {
		return n.f0.accept(this, argu);
	}
  
	/**
	* f0 -> BooleanArrayType()
	*       | IntegerArrayType()
	*/
	public Object visit(ArrayType n, Object argu) {
		return n.f0.accept(this, argu);
	}
  
	/**
	 * f0 -> "boolean"
	* f1 -> "["
	* f2 -> "]"
	*/
	public Object visit(BooleanArrayType n, Object argu) {
		return "boolean[]";
	}
  
	/**
	 * f0 -> "int"
	* f1 -> "["
	* f2 -> "]"
	*/
	public Object visit(IntegerArrayType n, Object argu) {
		return "int[]";
	}
  
	/**
	 * f0 -> "boolean"
	*/
	public Object visit(BooleanType n, Object argu) {
		return "boolean";
	}
  
	/**
	 * f0 -> "int"
	*/
	public Object visit(IntegerType n, Object argu) {
		return "int";
	}

}
