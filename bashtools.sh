#!/bin/bash
printN() {
    [[ $# -eq 2 ]] || (echo "Missing filename or line number"&&return)
    nrows=$(eval wc -l "$1" | awk '{ print $1 }');
    echo "FILE COUNT LINES: " $nrows
    if [[ $nrows -ge $2 ]] ; then
	cat -n $1 | grep $2 | awk -F $2 '{ print $NF }'
    else
	echo "Fewer lines in the file than given arg."; return;
    fi    
}
checkphoneN() {
    [[ $# -eq 1 ]] || (echo "Please enter an argument"; return)
    filename=$1
    while read -r line
    do
	[[ "$line" =~ ^[0-9]{3}\-[0-9]{3}\-[0-9]{4}$ || "$line" =~ ^\([0-9]{3}\)\ [0-9]{3}\-[0-9]{4} ]] && echo "$line";
    done <"$filename"
}
