#!/bin/bash - 
#===============================================================================
#
#          FILE: add-date-prefix.sh
# 
#         USAGE: ./add-date-prefix.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Alexey Balchunas
#  ORGANIZATION: 
#       CREATED: 01/26/2014 18:47:35 MSK
#      REVISION:  ---
#===============================================================================

find "$1" | while read i ; do
    if [ -f "$i" ] ; then
        DATE_TAKEN=`exiftool "$i" | grep "Create Date" | head -n 1 | sed -e 's/Create Date[^:]*: \(.*\) .*/\1/g' | sed -e 's/:/-/g'`
        if [ ! -z "$DATE_TAKEN" ] ; then
            mv "$i" "`dirname \"$i\"`/$DATE_TAKEN-`basename \"$i\"`"
        fi
    fi
done
