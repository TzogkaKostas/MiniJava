import syntaxtree.*;
import visitor.GJDepthFirst;
import SymbolTable.*;

public class IdentifierVisitor extends GJDepthFirst <Object, Object>{
	SymbolTable symbolTable = new SymbolTable();

	public SymbolTable getSymbolTable() {
		return this.symbolTable;
	}

	/**
	* f0 -> MainClass()
	* f1 -> ( TypeDeclaration() )*
	* f2 -> <EOF>
	*/
	public Object visit(Goal n, Object argu) {
		ClassInfo mainClassInfo = new ClassInfo();
		String mainClassName = (String) n.f0.accept(this, mainClassInfo);
		symbolTable.insertClass(mainClassName, mainClassInfo);
		n.f1.accept(this, null);
		return null;
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
		String className = (String) n.f1.accept(this, null);
		String argsName = (String) n.f11.accept(this, null);
		
		Identifiers identifiers = new Identifiers();
		n.f14.accept(this, identifiers);

		ClassInfo classInfo = new ClassInfo(className, argsName, identifiers);
		symbolTable.insertClass(className, classInfo);
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

		Identifiers variables = new Identifiers();
		n.f3.accept(this, variables);

		ClassInfo classInfo = new ClassInfo("", variables);

		n.f4.accept(this, classInfo);

		symbolTable.insertClass(className, classInfo);
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

		Identifiers variables = new Identifiers();
		n.f5.accept(this, variables);

		ClassInfo classInfo = new ClassInfo("extends", variables);

		n.f6.accept(this, classInfo);

		symbolTable.insertClass(className, classInfo);
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
		String returnType = (String) n.f1.accept(this, argu);
		String functionName = (String) n.f2.accept(this, argu);

		FunctionInfo functionInfo = new FunctionInfo(returnType);

		Identifiers parameters = new Identifiers();
		n.f4.accept(this, argu);
		functionInfo.setParameters(parameters);

		Identifiers variables = new Identifiers();
		n.f7.accept(this, variables);
		functionInfo.setVariables(variables);

		classInfo.insertFunction(functionName, functionInfo);
		return null;
	}

   	/**
    * f0 -> FormalParameter()
    * f1 -> FormalParameterTail()
    */
	public Object visit(FormalParameterList n, Object argu) {
		Identifiers identifiers = (Identifiers) argu;
		String[] strArray = (String[]) n.f0.accept(this, null);
		identifiers.insert(strArray[0], strArray[1]);
		n.f1.accept(this, argu);
		return null;
	}
  
	/**
	* f0 -> Type()
	* f1 -> Identifier()
	*/
	public Object visit(FormalParameter n, Object argu) {
		String strArray[] = new String[2];
		strArray[0] = (String) n.f0.accept(this, null);
		strArray[1] = (String) n.f1.accept(this, null);
		return strArray;
	}
  
	/**
	* f0 -> ( FormalParameterTerm() )*
	*/
	// public Object visit(FormalParameterTail n, Object argu) {
		// return n.f0.accept(this, argu);
	// }
  
	/**
	* f0 -> ","
	* f1 -> FormalParameter()
	*/
	public Object visit(FormalParameterTerm n, Object argu) {
		Identifiers identifiers = (Identifiers) argu;
		String[] strArray = (String[]) n.f0.accept(this, null);
		identifiers.insert(strArray[0], strArray[1]);
		return null;
	}

	/**
	* f0 -> Type()
	* f1 -> Identifier()
	* f2 -> ";"
	*/
	public Object visit(VarDeclaration n, Object argu) {
		Identifiers identifiers = (Identifiers) argu;
		String type = (String) n.f0.accept(this, null);
		String id = (String) n.f1.accept(this, null);
		identifiers.insert(id, type);
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
		return (String) n.f0.accept(this, argu);
	}
  
	/**
	* f0 -> BooleanArrayType()
	*       | IntegerArrayType()
	*/
	public Object visit(ArrayType n, Object argu) {
		return (String) n.f0.accept(this, argu);
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
