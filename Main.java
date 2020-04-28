import syntaxtree.*;
import java.io.*;
import SymbolTable.*;

class Main {
    public static void main (String [] args){
		if(args.length == 0){
			System.err.println("Usage: java Main <inputFiles>");
			System.exit(1);
		}
		for (String arg : args) {
			semanticAnalysis(arg);
		}
	}
	
	public static void semanticAnalysis(String fileName) {
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(fileName);
			MiniJavaParser parser = new MiniJavaParser(fis);
			Goal root = parser.Goal();
			System.err.println(fileName + " parsed successfully.");
 
			IdentifierVisitor idVisitor = new IdentifierVisitor();
			root.accept(idVisitor, null);

			SymbolTable symbolTable = idVisitor.getSymbolTable();
			// symbolTable.print();

			CheckingVisitor checkingVisitor = new CheckingVisitor(symbolTable);
			root.accept(checkingVisitor, null);
			System.err.println(fileName + " is semantically correct.\n");
		}
		catch(ParseException ex){
			System.out.println(ex.getMessage());
		}
		catch(FileNotFoundException ex){
			System.err.println(ex.getMessage());
		}
		finally{
			try{
				if(fis != null) fis.close();
			}
			catch(IOException ex){
				System.err.println(ex.getMessage());
			}
		}
	}
}
