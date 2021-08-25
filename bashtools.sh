#!/bin/bash
fillin() {
    [[ $# -eq 2 ]] ||(echo "Function fillin : missing args"; return)
    nameF=$2
    count=$1
    [[ -f './$nameF' ]] || touch ./"$nameF"
    echo "Enter text to fill in your file :" line
    for ((i=1; i<$count;i++))
    do
	echo $line >> $nameF
    done
}
printN() {
    [[ $# -eq 2 ]] || (echo "Function printN : Missing filename or line number"&&return)
    nrows=$(eval wc -l "$1" | awk '{ print $1 }');
    if [[ $nrows -ge $2 ]] ; then
	cat -n $1 | grep $2 | awk -F $2 '{ print $NF }'
    else
	echo "Fewer lines in the file than given arg."; return;
    fi    
}
checkphoneN() {
    [[ $# -eq 1 ]] || (echo "Function checkphoneN : Please enter an argument"; return)
    filename=$1
    rg1='^[:digit]{3}\-[:digit:]{3}\-[:digit:]{4}$'
    rg2='^\([:digit:]{3}\) [:digit:]{3}\-[:digit:]{4}$'
    while read -r line	
    do
	#[[ "$line" =~ ^[:digit:]{3}\-[:digit:]{3}\-[:digit:]{4}$ || "$line" =~ ^\([:digit:]{3}\)\ [:digit:]{3}\-[:digit:]{4} ]] && echo "$line";
      	[[ "$line" =~ $rg1 || "$line" =~ $rg2 ]] && echo "$line";
    done <"$filename"
}
trpose() {
    [[ $# -eq 1 ]] || (echo "Missing #1 arg"; return)
    local filename=$1; first=`head -n 1 $filename`
    #echo  "FIRST LINE IS :" $first
    local counting=`grep -o " " <<<"$first" | wc -l`
    counting=$((counting+1))
    #echo "$counting"
    awk '
    NR == 1 {
       	    n = NF
    	    for (i = 1;i <= NF; i++)
	     	row[i] = $i
	    next
    }
    {
	if (NF > n)
		   n = NF
		for(i= 1; i<=NF; i++)
		       row[i] = row[i] " " $i	 
    }
    END {
	     for(i = 1; i<=n; i++)
	     print row[i]
    }' ${1+"$@"}

}
rgengine() {
    match=`echo "happy not"| egrep "happy|happy not" | wc -w`;
    if [[ $match -eq 2 ]]; then
	echo "Your REGEX engine is TEXT-DIRECTED"
    elif [[ $match -eq 1 ]]; then
	echo "Your REGEX engine is REGEX-DIRECTED"   
    fi
}
wdfreq() {
    [[ $# -eq 1 ]] || (echo "Missing file"; return)
    fileN=$1
    tr -s [:blank:] '\n' < $fileN| tr -s [:punct:] ' '|xargs -d '\n' -I{} sh -c 'v={}; echo {} $(eval grep -ow {} '$fileN'|wc -w) `expr length {}`'|sort -k2 -nr|uniq
}
