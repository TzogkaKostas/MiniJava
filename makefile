all: main

main: Main.java
	javac Main.java

clean:
	rm -f *.class *~ SymbolTable/*.class
