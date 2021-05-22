#!/bin/bash

echo Funny message script, requires xorg and nano duh.

read -p "Press any key to continue.. " -n1 -s

nano message.txt

xmessage -file message.txt & clear

sleep 0.1

rm message.txt
