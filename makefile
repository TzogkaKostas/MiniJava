all: main Types CheckingVisitor IdentifierVisitor GenerationVisitor

main: Main.java
	javac Main.java

Types: Types/SymbolTable.java Types/ClassInfo.java Types/MethodInfo.java \
		Types/Variables.java Types/StatementInfo.java Types/ExpressionInfo.java \
		Types/OffsetTable.java
	javac Types/*.java

CheckingVisitor: CheckingVisitor.java
	javac CheckingVisitor.java

IdentifierVisitor: IdentifierVisitor.java
	javac IdentifierVisitor.java

GenerationVisitor: GenerationVisitor.java
	javac GenerationVisitor.java

clean:
	rm -f *.class *~ Types/*.class