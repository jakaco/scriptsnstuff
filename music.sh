#!/bin/bash

echo This script requires youtube-dl and ffmpeg/avconv

sleep 1

echo Paste the youtube link to extract the audio from it.

read -p 'Youtube link: ' varlink

echo What audio format? For example wav, mp3, opus

read -p 'Audio format: ' varformat

youtube-dl -x --audio-format "$varformat" "$varlink"

echo Do you want to play the file?

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

yes_or_no "$message" && youtube-dl --get-filename $varlink > output

sed -i "s/webm/"$varformat"/" output

sed -i "s/mp4/"$varformat"/" output

awk '{ print "\""$0"\""}' output > output2

cat output2 | xargs aplay

rm output output2
