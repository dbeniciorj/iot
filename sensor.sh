#!/bin/bash
BTMAC="24:0A:C4:9A:E8:EA"
DB=iot
DBPWD=1
READ="$(gatttool -b $BTMAC --char-read --handle=0x002a 2>&1)"
if [[ $READ =~ "refused" ]]; then
	echo "DEV $BTMAC nao encontrado."
else
	ANSW="$(echo $READ | cut -d : -f2| xxd -r -p)"
	# echo ANSW= $ANSW
	TEMP=$(echo $ANSW|cut -d "," -f1)
	HUMD=$(echo $ANSW|cut -d "," -f2)
	# echo TEMP= $TEMP
	# echo HUMD= $HUMD
	mysql $DB -p$DBPWD -e "insert into tempLog values (now(),$TEMP,$HUMD)"
fi

