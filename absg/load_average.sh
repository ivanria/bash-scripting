#!/bin/bash


 
# Set up limit below
LIMIT="10.0"
 
 
# -----------------------------------------------------------------
 
# Os Specifc tweaks do not change anything below ;)
OS="$(uname)"
TRUE="1"
if [ "$OS" == "FreeBSD" ]; then
	SEP='load averages:'
elif [ "$OS" == "Linux" ]; then
	SEP='load average:'
fi
 
echo $SEP

while true ; do 
	sleep 5
	# get first 5 min load
	F5M=$(uptime | awk -F "$SEP" '{ print $2 }' | cut -d, -f1 | sed 's/ //g')
	# 10 min
	F10M=$(uptime | awk -F "$SEP" '{ print $2 }' | cut -d, -f2 | sed 's/ //g')
	# 15 min
	F15M=$(uptime | awk -F "$SEP" '{ print $2 }' | cut -d, -f3 | sed 's/ //g')
 
	RESULT=$(echo "$F5M > $LIMIT" | bc ) #echo 1.1 1.66 |awk '{print($1>$2,$1<$2)}'

	if (( RESULT == 1 )) ; then
		top -n 1 >> ~/overload
		continue
	else 
		continue
	fi
done

exit 0
