#!/bin/bash - 
#===============================================================================
#
#          FILE: flickr-uploader.sh
# 
#         USAGE: ./flickr-uploader.sh FOLDER
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Alexey Balchunas, 
#  ORGANIZATION: 
#       CREATED: 10/28/2013 15:12:45 MSK
#      REVISION:  ---
#===============================================================================

set -o nounset

SETS=`flickcurl photosets.getList`
DIR=`basename "$1"`
cd "$1/.."

find "$DIR" | while read i ; do
    if [ -f "$i" ] ; then
        FILE_NAME=`basename "$i"`
        if [ "$FILE_NAME" == ".DS_Store" ] || [ "$FILE_NAME" == ".uploaded" ] ; then
            continue
        fi

        DIR=`dirname "$i"`
        SET_NAME=`echo $DIR | sed -e 's/\//. /g'`
        TAGS=`echo $DIR | sed -e 's/\// /g'`
        SET_ID=`echo "$SETS" | grep "title: '$SET_NAME'" | head -n1 | sed -e 's/.*ID \([0-9]*\) .*/\1/g'`
        
        if [ ! -f "$DIR/.uploaded" ] ; then
            touch "$DIR/.uploaded"
        fi
        
        UPLOADED=`cat "$DIR/.uploaded"`
        FILE_IS_UPLOADED=0
        while read u_file ; do
            if [ "$u_file" == "$FILE_NAME" ] ; then
                FILE_IS_UPLOADED=1
                break
            fi
        done < "$DIR/.uploaded"
        if [ $FILE_IS_UPLOADED -eq 0 ] ; then
            echo Uploading \"$i\"
            PHOTO_ID=`flickcurl upload "$i" title "" tags $TAGS | grep "Photo ID: " | head -n1 | sed -e 's/.*Photo ID: \([0-9]*\).*/\1/g'`
            if [ ! -z "$PHOTO_ID" ] ; then
                echo Uploaded \"$i\"
                if [ "$SET_ID" == "" ] ; then
                    echo Creating the set \"$SET_NAME\" with the primary photo \"$i\"
                    SET_ID=`flickcurl photosets.create "$SET_NAME" "" $PHOTO_ID | grep "Photoset " | head -n1 | sed -e 's/.*Photoset \([0-9]*\).*/\1/g'`
                    SETS=`flickcurl photosets.getList`
                    echo Created the set with ID \"$SET_ID\"
                else
                    echo Adding to the set \"$SET_NAME\" with ID \"$SET_ID\"
                    flickcurl photosets.addPhoto $SET_ID $PHOTO_ID
                    echo Added the photo
                fi
                echo "$FILE_NAME" >> "$DIR/.uploaded"
            fi
        else
            echo \"$i\" is already uploaded
        fi
    fi
done
