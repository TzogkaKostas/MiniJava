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
		this.types = Map.of("boolean[]", "i1*", "boolean", "i1", "int[]", "i32*", "int", "i32");
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
					+ getIRTypes(methodInfo.getParamNames()) + "* @" + classInfo.getName() + "." + methodInfo.getName()
					+ " to i8*)";

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
		this.regCount += 1;
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

	private String getIRParams(MethodInfo methodInfo) {
		String IRParams = "(i8* %this";
		for (Entry<String, String> entry : methodInfo.getParameters().getEntries() ) {
			IRParams += ", " + getIRType(entry.getValue()) + " %." + entry.getKey();
		}
		return IRParams + ")";
	}

	private Integer getVarOffset(ClassInfo classInfo, String identifier) {
		Integer varOffset = offsetTable.getVarOffset(classInfo.getName(), identifier);
		if (varOffset != -1) {
			return varOffset;
		}
		else {
			return getVarOffset(classInfo.getExtendsInfo(), identifier);
		}
	}

	private String paramsAllocation(MethodInfo methodInfo) {
		String localVariables = "";
		for (Entry<String, String> entry : methodInfo.getParameters().getEntries() ) {
			localVariables += "\t%" + entry.getKey() + " = alloca i32\n";
			localVariables += "\tstore i32 %." + entry.getKey()+ ", i32* %" + 
					entry.getKey() + "\n";
		}
		return localVariables;
	}

	// private String emitInheritedMethods(String superClass, String method) {
	// 	for(ClassInfo classInfo : symbolTable.getClasses() ) {
	// 		if (classInfo.classExtends(superClass) && !classInfo.methodExists(method)) {

	// 		}
	// 	}
	// }

	// private String removeLastComma(String str) {
	// 	return str.substring(0, str.lastIndexOf(","));
	// }

	// private Integer getSize(String identifier) {

	// 	return 1;
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
		statementInfo.appendCode(statementCode);

		return null;
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
		if (type == null) {
			throw new RuntimeException("Identifier " + identifier + " is not declared");
		}
		
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, statementInfo);
		if (!exprInfo.getType().equals("int")) {
			throw new RuntimeException(exprInfo.getType() +
				" can't be an index of " + identifier + " array");
		}

		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f5.accept(this, statementInfo);
		if (!type.equals(exprInfo2.getType() + "[]")) {
			throw new RuntimeException("Invalid ArrayAssignmentStatement");
		}
		return null;
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
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, argu);

		String trueLabel = newLabel();
		String falseLabel = newLabel();
		String endLabel = newLabel();
	
		String ifCode = exprInfo.getCode();
		ifCode += "\tbr i1 " + exprInfo.getResult() + ", label %" + 
				trueLabel + ", label %" + falseLabel + "\n";

		ifCode += "\t" + trueLabel + ":\n";
		n.f4.accept(this, argu);	
		ifCode += "\t" + "br label %" + endLabel + "\n";

		ifCode += "\t" + falseLabel + ":\n";
		n.f6.accept(this, argu);
		ifCode += "\t" + "br label %" + endLabel + "\n";

		ifCode += "\t" + endLabel + ":\n";
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
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("boolean")) {
			throw new RuntimeException(exprInfo.getType() + 
				" cannot be converted to boolean in WhileStatement");		
		}
		n.f4.accept(this, argu);
		return null;
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
		String endLabel = newLabel();
		String result = newTemp();
		String t1 = newTemp();
		String t2 = newTemp();
		String andCode = exprInfo.getCode() + exprInfo2.getCode();
		andCode = "\tbr i1 " + exprInfo.getResult() + " , label %" + falseLabel + 
				", label %" + trueLabel + "\n";
		andCode += "\t" + trueLabel + ":\n";
		andCode += "\t" + t1 + " = add i1 0, " + exprInfo.getResult();
		andCode += "\tbr label %" + endLabel + "\n";

		andCode += "\t" + falseLabel + ":\n";
		andCode += "\t" + t2 + " = add i1 0, " + exprInfo2.getResult();
		andCode += "\tbr label %" + endLabel + "\n";

		andCode += "\t" + endLabel + ":\n";
		andCode += "\t" + result + " = phi i1 [" + t1 + ", %" + trueLabel +"], [" + t2 +
				", %" + falseLabel + "]\n";

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

		String trueLabel = newLabel();
		String falseLabel = newLabel();
		String endLabel = newLabel();
		String cmp = newTemp();
		String t1 = newTemp();
		String t2 = newTemp();
		String result = newTemp();

		String compareCode = exprInfo.getCode() + exprInfo2.getCode();
		compareCode += "\t" + cmp + " = icmp slt i32 " + exprInfo.getResult() + ", " +
				exprInfo2.getResult() + "\n";

		compareCode += "\tbr i1 " + cmp + " , label %" + trueLabel + 
				", label %" + falseLabel+ "\n";
		compareCode += "\t" + trueLabel + ":\n";
		compareCode += "\t" + t1 + " = add i1 0, 0\n";
		compareCode += "\tbr label %" + endLabel + "\n";

		compareCode += "\t" + falseLabel + ":\n";
		compareCode += "\t" + t2 + " = add i1 0, 1\n";
		compareCode += "\tbr label %" + endLabel + "\n";

		compareCode += "\t" + endLabel + ":\n";
		compareCode += "\t" + result + " = phi i1 [" + t1 + ", %" + trueLabel +"], [" + t2 +
				", %" + falseLabel + "]\n";

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
		plusCode += "\t" + result + " = " + " add i32 " + exprInfo.getResult() +
				", " + exprInfo2.getResult();

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
				", " + exprInfo2.getResult();

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
				", " + exprInfo2.getResult();

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
		if (!exprInfo.getType().contains("[]")) {
			throw new RuntimeException(exprInfo.getId() + " is not an array");
		}
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo2.getType().equals("int")) {
			throw new RuntimeException(exprInfo2.getType() +
				" can't be an index");
		}

		String type = exprInfo.getType();
		return new ExpressionInfo("", type.substring(0, type.indexOf('[')), "",
				exprInfo.getResult() + " [" + exprInfo2.getResult() + "]");
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "."
	  * f2 -> "length"
	  */
	 public Object visit(ArrayLength n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		if (!exprInfo.getType().contains("[]")) {
			throw new RuntimeException(exprInfo.toString() +
				": length is only valid for arrays");
		}
		return new ExpressionInfo("", "int", "");
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
		String identifier = (String) n.f2.accept(this, argu);
		if (exprInfo.getType().contains("int") || exprInfo.getType().contains("boolean") ) {
			throw new RuntimeException("dot (.) operator can't used be on " +
				exprInfo.getType());
		}
		if (!symbolTable.classHasMethod(exprInfo.getType(), identifier)) {
			throw new RuntimeException("There isn't a declaration of method " +
				identifier + " in class " + exprInfo.getType());
		}

		ArrayList<ExpressionInfo> args = new ArrayList<ExpressionInfo>();
		Object array[] = new Object[2];
		array[0] = (Object) statementInfo;
		array[1] = (Object) args;
		n.f4.accept(this, array);
		if (!symbolTable.validMethodArgs(symbolTable, exprInfo.getType(),
				identifier, args)) {
			throw new RuntimeException("invalid arguments at function call " + 
				exprInfo.getType() + "." + identifier);
		}

		return new ExpressionInfo("", 
			symbolTable.getMethodReturnedType(exprInfo.getType(), identifier), "");
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

		String t = newTemp();
		String result = newTemp();
		String btrue = newLabel();
		String bfalse = newLabel();
		String end = newLabel();

		String notCode = exprInfo.getCode();
		notCode += t + " = icmp eq i32 " + exprInfo.getResult() + ", 1\n";
		notCode += "br i1 " + t + ", label %btrue, label %bfalse\n" ;
		notCode += btrue + ":\n";
		notCode += "\t" + result + " = add i32 0, 0\n";
		notCode += "\tbr label %end\n";
		notCode += bfalse + ":\n";
		notCode += "\t" + result + " = add i32 1, 0\n";
		notCode += "  br label %end\n";
		notCode += end + ":\n";

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
			String value = (booleanLiteral == "true" ? "1" : "0");
			return new ExpressionInfo("", "boolean", booleanLiteral, value, "");
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
			return new ExpressionInfo(variable, type, "", result, idCode);
		}
		else if (n.f0.which == 4) {
			return new ExpressionInfo("", statementInfo.getName(), "this", "TODO");
		}
		else if (n.f0.which == 6) {
			ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);

			return new ExpressionInfo("new", exprInfo.getType(), "", exprInfo.getResult());
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
		n.f3.accept(this, argu);
		return new ExpressionInfo("new", "boolean[]", "");
	}

   /**
	* f0 -> "new"
	* f1 -> "int"
	* f2 -> "["
	* f3 -> Expression()
	* f4 -> "]"
	*/
   public Object visit(IntegerArrayAllocationExpression n, Object argu) {
		n.f3.accept(this, argu);
		return new ExpressionInfo("new", "int[]", "");
   	}

	/**
	* f0 -> "new"
	* f1 -> Identifier()
	* f2 -> "("
	* f3 -> ")"
	*/
	public Object visit(AllocationExpression n, Object argu) {
		StatementInfo statementInfo = (StatementInfo) argu;		

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
		String returnStatement = "\tret " + getIRType(type) + " " + 
				exprInfo.getResult() + "\n}\n\n";

		String methodCode = methodHeader + paramsAllocation + declarationCode +
				statementInfo.getCode() + returnStatement;
		emit(methodCode);

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
