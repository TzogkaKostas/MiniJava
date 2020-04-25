import syntaxtree.*;
import java.io.*;

import SymbolTable.*;

class Main {
    public static void main (String [] args){
		if(args.length != 1){
			System.err.println("Usage: java Driver <inputFile>");
			System.exit(1);
		}
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(args[0]);
			MiniJavaParser parser = new MiniJavaParser(fis);
			Goal root = parser.Goal();
			System.err.println("Program parsed successfully.\n");
 
			IdentifierVisitor idVisitor = new IdentifierVisitor();
			root.accept(idVisitor, null);

			SymbolTable symbolTable = idVisitor.getSymbolTable();
			// symbolTable.print();

			CheckingVisitor checkingVisitor = new CheckingVisitor(symbolTable);
			root.accept(checkingVisitor, null);
			
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
