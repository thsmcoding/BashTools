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
