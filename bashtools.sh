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
    rg1='^[0-9]{3}\-[0-9]{3}\-[0-9]{4}$'
    rg2='^\([0-9]{3}\) [0-9]{3}\-[0-9]{4}$'
    while read -r line	
    do
	#[[ "$line" =~ ^[:digit:]{3}\-[:digit:]{3}\-[:digit:]{4}$ || "$line" =~ ^\([:digit:]{3}\)\ [:digit:]{3}\-[:digit:]{4} ]] && echo "$line";
      	[[ "$line" =~ $rg1 || "$line" =~ $rg2 ]] && echo "$line";
    done <"$filename"
}
trpose() {
    [[ $# -eq 1 ]] || (echo "Missing #1 arg"; return)
    local filename=$1; first=`head -n 1 $filename`
    echo  "FIRST LINE IS :" $first
    local counting=`grep -o " " <<<"$first" | wc -l`
    counting=$((counting+1))
    echo "$counting"
}
rgengine() {
    match=`echo "happy not"| egrep "happy|happy not" | wc -w`;
    if [[ $match -eq 2 ]]; then
	echo "Your REGEX engine is TEXT-DIRECTED"
    elif [[ $match -eq 1 ]]; then
	echo "Your REGEX engine is REGEX-DIRECTED"   
    fi
}
