#!/bin/bash

target=$2
target_dir=$(dirname "$target")
file_name=$(basename "$target")

if [[ $# -ne 2 ]]; then
	echo "You need exactly 2 arguments(You entered "$#")"
	echo "Use arguments \$1 - target file \$2 - final file"
	exit
fi

if [[ ! -a $1 ]]; then
	echo "File with EMAILS does not exist"
	exit
fi

makedir=0


if [[ ! -d $target_dir ]]; then
	echo "Directory "$target_dir" does not exist"
	echo -n "Create "$target_dir"? (Y/N):"
	read makedir
	case "$makedir" in
	"Y" | "y")
		echo "Directory "$target_dir" created"
		mkdir $target_dir;;
	"N" | "n")
		echo "Bye"
		exit;;
	*)
		exit
	esac
fi
emails_see=0
grep -E -o "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" $1 > $2
total_emails=$(grep -Ec -o "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" $1)
echo "$total_emails"
if [[ -a $2 ]]; then
	echo "Successful pars!"
	echo -n "Would you like to see successfully parsed emails?(Y/N):"
	read emails_see
	case $emails_see in
	"Y" | "y")
		echo "Result:"
		grep -E -o "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" $1 ;;
	"N" | "n")
		echo "Have a nice day! Bye"
		exit
	esac
fi
