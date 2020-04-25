import syntaxtree.*;
import visitor.GJDepthFirst;
import SymbolTable.*;
import java.util.*;

public class CheckingVisitor extends GJDepthFirst <Object, Object> {
	SymbolTable symbolTable;
	
	CheckingVisitor(SymbolTable symbolTable) {
		this.symbolTable = symbolTable;
	}

	public SymbolTable getSymbolTable() {
		return this.symbolTable;
	}

	public void terminate(String errorMessage) {
		System.out.print(errorMessage);
		System.exit(1);
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
		if (type == null) {
			throw new Error("Identifier " + identifier + " is not declared");
		}		

		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, statementInfo);

		String className;
		if (exprInfo.getValue().equals("this")) {
			className = statementInfo.getMainName();
		}
		else {
			className = exprInfo.getType(); 
		}
		if (!type.equals(className) && 
				!symbolTable.classExtends(type, className)) {	
			throw new Error("incompatible types: " + type + "(" + identifier + ")"
				+ " = " + exprInfo.getType());
		}
		return null;
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
			throw new Error("Identifier " + identifier + " is not declared");
		}
		
		ExpressionInfo exprInfo = (ExpressionInfo) n.f2.accept(this, statementInfo);
		if (!exprInfo.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() +
				" can't be an index of " + identifier);
		}

		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f5.accept(this, statementInfo);
		if (!type.equals(exprInfo2.getType() + "[]")) {
			throw new Error("incompatible types: " + type + "(" + identifier + ")"
				+ " = " + exprInfo2.getType());	
		}
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
		if (!exprInfo.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() +
				" can't be an argument of System.out.println");
		}
		return null;
	 }

    /**
	* f0 -> Clause()
	* f1 -> "&&"
	* f2 -> Clause()
	*/
	public Object visit(AndExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("boolean") ||
				!exprInfo2.getType().equals("boolean")) {
			throw new Error("incompatible types: " + exprInfo.getType() + " && " +
				exprInfo2.getType());
		}
		return new ExpressionInfo("", "boolean", "");
	}

   	/**
	* f0 -> PrimaryExpression()
	* f1 -> "<"
	* f2 -> PrimaryExpression()
	*/
	public Object visit(CompareExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("int") ||
				!exprInfo2.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() + " < " +
				exprInfo2.getType());
		}

		return new ExpressionInfo("", "boolean", "");
	}

	  /**
	* f0 -> PrimaryExpression()
	* f1 -> "+"
	* f2 -> PrimaryExpression()
	*/
	public Object visit(PlusExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("int") || !exprInfo2.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() + " + " +
				exprInfo2.getType());
		}

		return new ExpressionInfo("", "int", "");
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "-"
	  * f2 -> PrimaryExpression()
	  */
	 public Object visit(MinusExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("int") || !exprInfo2.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() + " - " +
				exprInfo2.getType());
		}

		return new ExpressionInfo("", "int", "");
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "*"
	  * f2 -> PrimaryExpression()
	  */
	 public Object visit(TimesExpression n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo.getType().equals("int") || !exprInfo2.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo.getType() + " * " +
				exprInfo2.getType());
		}

		return new ExpressionInfo("", "int", "");
	}
	
   /**
	* f0 -> PrimaryExpression()
	* f1 -> "["
	* f2 -> PrimaryExpression()
	* f3 -> "]"
	*/
	public Object visit(ArrayLookup n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		if (exprInfo.getId().equals("")) {
			throw new Error("incompatible types: Id or new is only allowed before []");
		}
		if (!exprInfo.getType().contains("[]")) {
			throw new Error("incompatible types: " + exprInfo.getId() + " is not an array");
		}
		ExpressionInfo exprInfo2 = (ExpressionInfo) n.f2.accept(this, argu);
		if (!exprInfo2.getType().equals("int")) {
			throw new Error("incompatible types: " + exprInfo2.getType() +
				" can't be an index");
		}

		String type = exprInfo.getType();
		return new ExpressionInfo("", type.substring(0, type.indexOf('[')), "");
	 }
  
	 /**
	  * f0 -> PrimaryExpression()
	  * f1 -> "."
	  * f2 -> "length"
	  */
	 public Object visit(ArrayLength n, Object argu) {
		ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, argu);
		if (!exprInfo.getType().contains("[]")) {
			throw new Error("incompatible types: " + exprInfo.toString() +
				": length is only valid for array");
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
		if (exprInfo.getId().equals("") && !exprInfo.getValue().equals("this")) {
			throw new Error("incompatible types: invalid use of dot (.) operator: " +
				exprInfo.toString());
		}
		if (exprInfo.getValue().equals("this")) {
			if (!statementInfo.isMethodDeclared(identifier)) {
				throw new Error("incompatible types: There isn't a declaration of method " +
					identifier + " in class this ");
			}
		}
		else {
			if (!symbolTable.classHasMethod(exprInfo.getType(), identifier)) {
				throw new Error("incompatible types: There isn't a declaration of method " +
					identifier + " in class " + exprInfo.getType());
			}
		}


		ArrayList<ExpressionInfo> args = new ArrayList<ExpressionInfo>();
		Object array[] = new Object[2];
		array[0] = (Object) statementInfo;
		array[1] = (Object) args;
		n.f4.accept(this, array);
		if (exprInfo.getValue().equals("this")) {
			if (!statementInfo.validMethodArgs(identifier, args)) {
				throw new Error("incompatible types: invalid arguments at function call " + 
					"this." + identifier);
			}
		}
		else {
			if (!symbolTable.validMethodArgs(exprInfo.getType(), identifier, args)) {
				throw new Error("incompatible types: invalid arguments at function call " + 
					exprInfo.getType() + "." + identifier);
			}
		}

		String type;
		if (exprInfo.getValue().equals("this")) {
			type = statementInfo.getMethodReturnedType(identifier);
		}
		else {
			type = symbolTable.getMethodReturnedType(exprInfo.getType(), identifier);
		}
		return new ExpressionInfo("", type, "");
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
		return n.f1.accept(this, argu);
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
			return new ExpressionInfo("", "int", (String) n.f0.accept(this, null));
		}
		else if (n.f0.which == 1 || n.f0.which == 2) {
			return new ExpressionInfo("", "boolean", (String) n.f0.accept(this, null));
		}
		else if (n.f0.which == 3) {
			String variable = (String) n.f0.accept(this, null);
			if (!statementInfo.isVarDeclared(variable)) {
				System.out.println(variable);
				statementInfo.print();
				throw new Error("Identifier " + variable + " is not declared");
			}
			return new ExpressionInfo(variable, statementInfo.getType(variable), "");
		}
		else if (n.f0.which == 4) {
			return new ExpressionInfo("", "", "this");
		}
		else if (n.f0.which == 6) {
			ExpressionInfo exprInfo = (ExpressionInfo) n.f0.accept(this, null);
			if (!symbolTable.classExists(exprInfo.getType())) {
				throw new Error("Class " + exprInfo.getType() + " is not declared");
			}
			return new ExpressionInfo("new", exprInfo.getType(), "");
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
		return new ExpressionInfo("new", (String) n.f1.accept(this, argu), "");
	}

	
    /**
	* f0 -> "("
	* f1 -> Expression()
	* f2 -> ")"
	*/
	public Object visit(BracketExpression n, Object argu) {
		return n.f1.accept(this, argu);
   	}  

	// /**
	// * f0 -> MainClass()
	// * f1 -> ( TypeDeclaration() )*
	// * f2 -> <EOF>
	// */
	// public Object visit(Goal n, Object argu) {
	// 	ClassInfo mainClassInfo = new ClassInfo();
	// 	String mainClassName = (String) n.f0.accept(this, mainClassInfo);
	// 	symbolTable.insertClass(mainClassName, mainClassInfo);
	// 	n.f1.accept(this, null);
	// 	return null;
	// }

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
		String className = (String) n.f1.accept(this, argu);
		ClassInfo classInfo = symbolTable.getClassInfo(className);
		classInfo.setName(className);
		
		n.f15.accept(this, new StatementInfo(classInfo, "main"));
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
		classInfo.setName(className);

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
		classInfo.setName(className);

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
		
		StatementInfo statementInfo = new StatementInfo(classInfo, methodName);
		n.f8.accept(this, statementInfo);

		ExpressionInfo exprInfo = (ExpressionInfo) n.f10.accept(this, statementInfo);
		if (!type.equals(exprInfo.getType())) {
			throw new Error("method " + methodName + " must return " + type + ", not " + 
				exprInfo.getType());
		}
		return null;
	}

   	// /**
    // * f0 -> FormalParameter()
    // * f1 -> FormalParameterTail()
    // */
	// public Object visit(FormalParameterList n, Object argu) {
	// 	Identifiers identifiers = (Identifiers) argu;
	// 	String[] strArray = (String[]) n.f0.accept(this, null);
	// 	identifiers.insert(strArray[0], strArray[1]);
	// 	n.f1.accept(this, argu);
	// 	return null;
	// }
  
	// /**
	// * f0 -> Type()
	// * f1 -> Identifier()
	// */
	// public Object visit(FormalParameter n, Object argu) {
	// 	String strArray[] = new String[2];
	// 	strArray[0] = (String) n.f0.accept(this, null);
	// 	strArray[1] = (String) n.f1.accept(this, null);
	// 	return strArray;
	// }
  
	// /**
	// * f0 -> ( FormalParameterTerm() )*
	// */
	// // public Object visit(FormalParameterTail n, Object argu) {
	// 	// return n.f0.accept(this, argu);
	// // }
  
	// /**
	// * f0 -> ","
	// * f1 -> FormalParameter()
	// */
	// public Object visit(FormalParameterTerm n, Object argu) {
	// 	Identifiers identifiers = (Identifiers) argu;
	// 	String[] strArray = (String[]) n.f0.accept(this, null);
	// 	identifiers.insert(strArray[0], strArray[1]);
	// 	return null;
	// }

	// /**
	// * f0 -> Type()
	// * f1 -> Identifier()
	// * f2 -> ";"
	// */
	// public Object visit(VarDeclaration n, Object argu) {
	// 	Identifiers identifiers = (Identifiers) argu;
	// 	String type = (String) n.f0.accept(this, null);
	// 	String id = (String) n.f1.accept(this, null);
	// 	identifiers.insert(id, type);
	// 	return null;
	//  }

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
