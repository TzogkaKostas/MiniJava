all: main SymbolTable ClassInfo FunctionInfo Identifiers \
	# minijava minijava-jtb

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

FunctionInfo: SymbolTable/FunctionInfo.java
	javac SymbolTable/FunctionInfo.java

Identifiers: SymbolTable/Identifiers.java
	javac SymbolTable/Identifiers.java

clean:
	rm -f *.class *~ SymbolTable/*.class
