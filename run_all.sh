#!/bin/sh

args="";
for file in $2*; do
    args=$args" "$file;
done
make $1
java Main $args