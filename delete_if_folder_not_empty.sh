#!/bin/bash

# Script help: https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash

usage() { echo "Usage: $0 [-f <file name>] [-d <dry run>] [-o <output file>]" 1>&2; exit 1; }

while getopts ":f:d:o:" o; do
    case "${o}" in
        f)
            fileName=${OPTARG}
            ;;
        d)
            dryRun=${OPTARG}
            ;;
        o)
            outputFile=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${fileName}" ] || [ -z "${dryRun}" ]  || [ -z "${outputFile}" ]; then
    usage
fi

echo "Folder List File = ${fileName}"
echo "Dry Run = ${dryRun}"
echo "Output File = ${outputFile}"

while read p; do
    echo "$p"
    FILE=""
    DIR="$p"
    # init
    # look for empty dira
    if [ -d "$DIR" ]
    then
        if [ "$(ls -A $DIR)" ]; then
            if [ $dryRun = "true" ]; then
                echo "Take action $DIR is not Empty"
            else
                echo "Attempting to delete $DIR as it is not Empty"
                rm -rf $DIR
                echo $(date) 'Deleted' ${DIR} >> $outputFile
            fi
        else
            echo "$DIR is Empty"
        fi
    else
        echo "Directory $DIR not found."
    fi
    # rest of the logic
done <$fileName
