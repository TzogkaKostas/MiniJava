import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;

import Types.OffsetTable;
import Types.SymbolTable;
import syntaxtree.Goal;

class Main {
    public static void main (String [] args){
		if(args.length == 0){
			System.err.println("Usage: java Main <inputFiles>");
			System.exit(1);
		}
		for (String arg : args) {
			CheckingVisitor checkingVisitor = semanticAnalysis(arg);
			generateIR(arg, checkingVisitor.getSymbolTable(),
					checkingVisitor.getOffsetTable());
		}
	}

	public static CheckingVisitor semanticAnalysis(String fileName) {
		FileInputStream fis = null;
		CheckingVisitor checkingVisitor = null;
		try{
			fis = new FileInputStream(fileName);
			MiniJavaParser parser = new MiniJavaParser(fis);
			Goal root = parser.Goal();
			
			IdentifierVisitor idVisitor = new IdentifierVisitor();
			root.accept(idVisitor, null);
			SymbolTable symbolTable = idVisitor.getSymbolTable();

			checkingVisitor = new CheckingVisitor(symbolTable);
			root.accept(checkingVisitor, null);
			// System.out.println(fileName + " is semantically correct.");

			// checkingVisitor.getOffsetTable().print();
		}
		catch (RuntimeException e) {
			System.out.println(fileName + " error : " + e.getMessage() + "\n");
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
		return checkingVisitor;
	}

	public static void generateIR(String fileName, SymbolTable symbolTable,
			OffsetTable offsetTable) {
		FileInputStream fis = null;
		FileWriter  fileWriter = null;
		try{
			fis = new FileInputStream(fileName);
			MiniJavaParser parser = new MiniJavaParser(fis);
			Goal root = parser.Goal();

			GenerationVisitor generationVisitor = new GenerationVisitor(symbolTable,
					offsetTable);
			root.accept(generationVisitor, null);
			
			fileWriter = new FileWriter("my_llvm/" + getBaseName(fileName) + ".ll");
			fileWriter.write(generationVisitor.getCodeBuffer());
			fileWriter.flush();


		} catch (IOException e) {
			System.out.println("my_llvm/" + getBaseName(fileName) + ".ll");
			e.printStackTrace();
		} catch (ParseException ex) {
			System.out.println(ex.getMessage());
		} finally {
			try {
				if (fis != null)
					fis.close();
				if (fileWriter != null)
					fileWriter.close();
			} catch (IOException ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	public static String getBaseName(String path) {
        String last = path.substring(path.lastIndexOf("/")+1);
		return last.substring(0, last.lastIndexOf('.'));
	}

	public void createLLVMFile() {
		
	}
}
