#!/bin/sh

args="";
for file in $1*; do
    args=$args" "$file;
done
make 
java Main $args

for file in $2*; do
    basename "$file"
    f="$(basename -- $file)"
    f="${f%.*}"
    clang-4.0 -o out1 $file -Wno-override-module && ./out1 > my_out/$f".out"
done