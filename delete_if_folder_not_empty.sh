#!/bin/bash
echo "Folder List File: $1"
echo "Dry Run: $2"

while read p; do
    echo "$p"
    FILE=""
    DIR="$p"
    # init
    # look for empty dira
    if [ -d "$DIR" ]
    then
        if [ "$(ls -A $DIR)" ]; then
            if [ $2 = "true" ]; then
                echo "Take action $DIR is not Empty"
            else
                echo "Attempting to delete $DIR as it is not Empty"
                rm -rf $DIR
            fi
        else
            echo "$DIR is Empty"
        fi
    else
        echo "Directory $DIR not found."
    fi
    # rest of the logic
done <$1
