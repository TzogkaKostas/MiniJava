# MiniJava Compiler
Using the Visitor Pattern, the compiler performs Semantic Analysis and converts the
MiniJava Code into the intermediate representation (IR) used by the LLVM
compiler project.

## Execution: 
./run.sh <file1.java> <file2.java> <file3.java> ...

MiniJava files can be found on 'baziotis_java' and 'examples' folders. Output is
stored on files named <file1.ll>, <file2.ll>, <file3.ll>, ...
