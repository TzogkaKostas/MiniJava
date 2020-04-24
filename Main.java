import syntaxtree.*;
import java.io.*;

import SymbolTable.SymbolTable;

class Main {
    public static void main (String [] args){
		if(args.length != 1){
			System.err.println("Usage: java Driver <inputFile>");
			System.exit(1);
		}
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(args[0]);
			// fis = new FileInputStream("test.java");
			MiniJavaParser parser = new MiniJavaParser(fis);
			System.err.println("Program parsed successfully.\n");
			IdentifierVisitor idVisitor = new IdentifierVisitor();
			Goal root = parser.Goal();
			root.accept(idVisitor, null);
			SymbolTable symbolTable = idVisitor.getSymbolTable();
			symbolTable.print();
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
