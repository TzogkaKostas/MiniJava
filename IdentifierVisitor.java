import syntaxtree.*;
import visitor.GJDepthFirst;
import SymbolTable.*;

public class IdentifierVisitor extends GJDepthFirst<String, String>{
	SymbolTable symbolTable = new SymbolTable();
	// ClassInfo classInfo = new ClassInfo();
	// FunctionInfo functionInfo = new FunctionInfo();
	Identifiers identifiers;
	
	public void print() {
		// symbolTable.printClassesNames();
		symbolTable.print();
	}


   /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
	public String visit(ClassDeclaration n, String argu) {
		String MainClassName = n.f1.accept(this, argu);

        identifiers = new Identifiers();
		n.f3.accept(this, argu);

		n.f4.accept(this, argu);

		ClassInfo classInfo = new ClassInfo("", identifiers);
		symbolTable.insertClass(MainClassName, classInfo);
		return MainClassName;
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
	public R visit(MethodDeclaration n, A argu) {
		R _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		n.f5.accept(this, argu);
		n.f6.accept(this, argu);
		n.f7.accept(this, argu);
		n.f8.accept(this, argu);
		n.f9.accept(this, argu);
		n.f10.accept(this, argu);
		n.f11.accept(this, argu);
		n.f12.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Type() f1 -> Identifier() f2 -> ";"
	 */
	public String visit(VarDeclaration n, String argu) {
		String type = n.f0.accept(this, argu);
		String id = n.f1.accept(this, argu);
		identifiers.insert(id, type);
		return id;
	}

	/**
    * f0 -> <IDENTIFIER>
    */
	public String visit(Identifier n, String argu) {
		return n.f0.toString();
	}


 	/**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
	public String visit(Type n, String argu) {
		return n.f0.accept(this, argu);
	}
  
	 /**
	  * f0 -> BooleanArrayType()
	  *       | IntegerArrayType()
	  */
	public String visit(ArrayType n, String argu) {
		return n.f0.accept(this, argu);
	}
  
	 /**
	  * f0 -> "boolean"
	  * f1 -> "["
	  * f2 -> "]"
	  */
	public String visit(BooleanArrayType n, String argu) {
		return "boolean[]";
	}
  
	 /**
	  * f0 -> "int"
	  * f1 -> "["
	  * f2 -> "]"
	  */
	public String visit(IntegerArrayType n, String argu) {
		return "int[]";
	}
  
	 /**
	  * f0 -> "boolean"
	  */
	public String visit(BooleanType n, String argu) {
		return "boolean";
	}
  
	 /**
	  * f0 -> "int"
	  */
	public String visit(IntegerType n, String argu) {
		return "int";
	}

}
