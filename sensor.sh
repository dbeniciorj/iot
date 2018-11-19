#!/bin/bash
BTMAC="24:0A:C4:9A:E8:EA"
READ="$(gatttool -b $BTMAC --char-read --handle=0x002a | cut -d : -f2| xxd -r -p)"
echo READ= $READ
# exit
TEMP=$(echo $READ|cut -d "," -f1)
HUMD=$(echo $READ|cut -d "," -f2)
echo TEMP= $TEMP
echo HUMD= $HUMD