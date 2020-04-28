all: main SymbolTable CheckingVisitor IdentifierVisitor

main: Main.java
	javac Main.java

SymbolTable: SymbolTable/SymbolTable.java SymbolTable/ClassInfo.java SymbolTable/MethodInfo.java \
		SymbolTable/Variables.java SymbolTable/StatementInfo.java SymbolTable/ExpressionInfo.java \
		SymbolTable/OffsetTable.java
	javac SymbolTable/*.java

CheckingVisitor: CheckingVisitor.java
	javac CheckingVisitor.java

IdentifierVisitor: IdentifierVisitor.java
	javac IdentifierVisitor.java

clean:
	rm -f *.class *~ SymbolTable/*.class