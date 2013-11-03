#!/bin/bash - 
#===============================================================================
#
#          FILE: upload-sets-in-the-folder.sh
# 
#         USAGE: ./upload-sets-in-the-folder.sh FOLDER
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Alexey Balchunas 
#  ORGANIZATION: 
#       CREATED: 11/03/2013 13:53:03 MSK
#      REVISION:  ---
#===============================================================================

# 
PID_FILE="/tmp/`basename $0`.pid"
touch "$PID_FILE"
read PID < "$PID_FILE"
# if PID is not null and a process with that pid exists, exit
[ ! -z "$PID" ] ; [ ! -z "`ps -p $PID | sed -n 2p`" ] && echo "Running already..." && exit 0
echo $$ > "$PID_FILE"

echo Uploading all sets in the folder \"$1\"
for folder in `ls $1` ; do
    if [ -d "$1/$folder" ] ; then
        echo Uploading the folder \"$1/$folder\"
        `dirname "$0"`/upload-set.sh "$1/$folder"
    fi
done
