#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: ufs [-h] [-g] system source target filesystem"
    echo
    echo "ufs can create a bootable Linux or Windows USB drive using an ISO image."
    echo
    echo "positional arguments:"
    echo "   system          Operating system - Windows or Linux"
    echo "   source          Source"
    echo "   target          Target"
    echo "   filesystem      Filesystem - GPT or MBR (Not required for Windows ISO's)"
    echo
    echo "optional arguments:"
    echo "-h     Show this help message"
fi
if [ "$1" == -h ]
then
    echo "Usage: ufs [-h] system source target filesystem"
    echo
    echo "ufs can create a bootable Linux or Windows USB drive using an ISO image."
    echo
    echo "positional arguments:"
    echo "   system          Operating system - Windows or Linux"
    echo "   source          Source"
    echo "   target          Target"
    echo "   filesystem      Filesystem - GPT or MBR (Not required for Windows ISO's)"
    echo
    echo "optional arguments:"
    echo "-h     Show this help message"
    else
        if [ -z "$1" ]
        then
            echo No system selected.
            exit
        fi
        if [ -z "$2" ]
        then
            echo No source selected.
            exit
        fi
        if [ -z "$3" ]
        then
            echo No target selected.
            exit
        fi
        if [ "$1" == linux ]
        then
            if [ -z "$4" ]
            then
                echo No filesystem selected.
                exit
            fi
        fi
        echo You have selected:
        echo
        echo System - "$1"
        echo Source - "$2"
        echo Target - "$3"
        if [ "$1" == linux ]
        then
            echo Filesystem - "$4"
        fi
        echo
        echo "If this isn't right press CTRL + C to cancel the script and run it again."
        echo
        read -p "Press any key to continue.. " -n1 -s
        clear
        if [ "$1" == linux ]
        then
            if [ "$4" == mbr ]
            then
                varpart=o
            fi
            if [ "$4" == gpt ]
            then
                varpart=g
            fi
        echo Wiping..
        wipefs -a "$3"
        echo Formatting..
        (echo "$varpart"; echo w; echo q) | sudo fdisk "$3"
        partprobe
        echo Writing..
        sudo dd if="$2" of="$3" bs=1M status=progress
        echo Syncing..
        sync
        echo Verifying..
        sudo cmp -n $(stat -c '%s' "$2") "$2" "$3"
        fi
        if [ "$1" == windows ]
        then
            echo Wiping..
            wipefs -a "$3"
            echo Writing..
            sudo woeusb -d "$2" "$3"
            echo Syncing..
            sync
        fi
    fi#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: ufs [-h] [-g] system source target filesystem"
    echo
    echo "ufs can create a bootable Linux or Windows USB drive using an ISO image."
    echo
    echo "positional arguments:"
    echo "   system          Operating system - Windows or Linux"
    echo "   source          Source"
    echo "   target          Target"
    echo "   filesystem      Filesystem - GPT or MBR (Not required for Windows ISO's)"
    echo
    echo "optional arguments:"
    echo "-h     Show this help message"
fi
if [ "$1" == -h ]
then
    echo "Usage: ufs [-h] system source target filesystem"
    echo
    echo "ufs can create a bootable Linux or Windows USB drive using an ISO image."
    echo
    echo "positional arguments:"
    echo "   system          Operating system - Windows or Linux"
    echo "   source          Source"
    echo "   target          Target"
    echo "   filesystem      Filesystem - GPT or MBR (Not required for Windows ISO's)"
    echo
    echo "optional arguments:"
    echo "-h     Show this help message"
    else
        if [ -z "$1" ]
        then
            echo No system selected.
            exit
        fi
        if [ -z "$2" ]
        then
            echo No source selected.
            exit
        fi
        if [ -z "$3" ]
        then
            echo No target selected.
            exit
        fi
        if [ "$1" == linux ]
        then
            if [ -z "$4" ]
            then
                echo No filesystem selected.
                exit
            fi
        fi
        echo You have selected:
        echo
        echo System - "$1"
        echo Source - "$2"
        echo Target - "$3"
        if [ "$1" == linux ]
        then
            echo Filesystem - "$4"
        fi
        echo
        echo "If this isn't right press CTRL + C to cancel the script and run it again."
        echo
        read -p "Press any key to continue.. " -n1 -s
        clear
        if [ "$1" == linux ]
        then
            if [ "$4" == mbr ]
            then
                varpart=o
            fi
            if [ "$4" == gpt ]
            then
                varpart=g
            fi
        echo Wiping..
        wipefs -a "$3"
        echo Formatting..
        (echo "$varpart"; echo w; echo q) | sudo fdisk "$3"
        partprobe
        echo Writing..
        sudo dd if="$2" of="$3" bs=1M status=progress
        echo Syncing..
        sync
        echo Verifying..
        sudo cmp -n $(stat -c '%s' "$2") "$2" "$3"
        fi
        if [ "$1" == windows ]
        then
            echo Wiping..
            wipefs -a "$3"
            echo Writing..
            sudo woeusb -d "$2" "$3"
            echo Syncing..
            sync
        fi
    fi
