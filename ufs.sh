#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: ufs [-h] [-g] system source target filesystem"
    echo "You can also run a guided flasher by just running ufs by itself"
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
    echo "-g     Launch the guided flasher"
fi
if [ "$1" == -g ]
then
    echo This is a basic iso write script using dd you can also run ufs -h for a quicker version.
    read -p 'Which system? (windows / linux): ' varos
    read -p 'What iso (~/Documents/artix.iso): ' variso
    read -p 'What drive (/dev/sdb): ' vardrive
    if [ "$varos" == linux ]
    then
        read -p 'GPT or MBR?: ' varpart
    fi
    echo You have selected:
    echo
    echo System - "$varos"
    echo Source - "$variso"
    echo Target - "$vardrive"
    if [ "$varos" == linux ]
    then
        echo Filesystem - "$varpart"
    fi
    echo
    echo "If this isn't right press CTRL + C to cancel the script and run it again."
    echo
    read -p "Press any key to continue.. " -n1 -s
    clear
    if [ "$varos" == linux ]
    then
        if [ "$varpart" == mbr ]
        then
            varpart2=o
        fi
        if [ "$varpart" == gpt ]
        then
            varpart2=g
        fi
        echo Wiping..
        (echo w; echo q) | sudo fdisk -w auto "$vardrive"
        echo Formatting..
        (echo "$varpart2"; echo w; echo q) | sudo fdisk "$vardrive"
        partprobe
        echo Writing..
        sudo dd if="$variso" of="$vardrive" bs=1M status=progress
        echo Syncing..
        sync
        echo Verifying..
        sudo cmp -n $(stat -c '%s' "$variso") "$variso" "$vardrive"
    fi
    if [ "$varos" == windows ]
    then
        echo Wiping..
        (echo w; echo q) | sudo fdisk -w auto "$vardrive"
        echo Writing..
        sudo woeusb -d "$variso" "$vardrive"
        echo Syncing..
        sync
    fi
else
    if [ "$1" == -h ]
    then
        echo "Usage: ufs [-h] [-g] system source target filesystem"
        echo "You can also run a guided flasher by just running ufs by itself"
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
        echo "-g     Launch the guided flasher"
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
            (echo w; echo q) | sudo fdisk -w auto "$3"
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
                (echo w; echo q) | sudo fdisk -w auto "$3"
                echo Writing..
                sudo woeusb -d "$2" "$3"
                echo Syncing..
                sync
            fi
        fi
    fi
