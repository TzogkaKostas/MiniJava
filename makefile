all: main SymbolTable ClassInfo MethodFunction Variables

minijava: minijava.jj
	java -jar ../jtb-javacc-2016/jtb132di.jar minijava.jj

minijava-jtb: minijava-jtb.jj
	java -jar ../jtb-javacc-2016/javacc5.jar minijava-jtb.jj

main: Main.java
	javac Main.java

SymbolTable: SymbolTable/SymbolTable.java
	javac SymbolTable/SymbolTable.java

ClassInfo: SymbolTable/ClassInfo.java
	javac SymbolTable/ClassInfo.java

MethodFunction: SymbolTable/MethodFunction.java
	javac SymbolTable/MethodFunction.java

Variables: SymbolTable/Variables.java
	javac SymbolTable/Variables.java

clean:
	rm -f *.class *~ SymbolTable/*.class
