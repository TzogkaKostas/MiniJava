#!/bin/sh

args="";
for file in $1*; do
    args=$args" "$file;
done
make
java Main $args