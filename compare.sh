#!/bin/sh

for file in $1*; do
	basename "$file" > /dev/null 2>&1
	f="$(basename -- $file)"
	f="${f%.*}"

	if cmp -s "$file" "codegen_out/$f.out"; then
		printf "$file : same\n"
	else
		printf "$file : not same\n"
	fi
done