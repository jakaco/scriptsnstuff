#!/bin/bash

echo This script requires links. It is also recommended to run this script with sudo.

sleep 1

echo Select a package and download its zst file, do not change the extension at the end. After you downloaded the file press Q to quit.

sleep 1

read -p "Press any key to continue.. " -n1 -s

links https://archive.archlinux.org/packages/

find . -type f -name "*.zst" > output

awk '/pattern/ {exit} {print}' output

cat output | xargs sudo pacman -U --noconfirm

cat output | xargs rm -rf

rm output
