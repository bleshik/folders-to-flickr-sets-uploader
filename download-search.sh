#!/bin/bash - 

set -o nounset

DIR_NAME="search-result-`date +%s`"
if [ ! -d "$DIR_NAME" ] ; then
    mkdir "$DIR_NAME"
fi
cd "$DIR_NAME"
PHOTOS=`flickcurl photos.search $* | grep "ID \d\+" | sed -e 's/.*ID \([0-9]*\).*/\1/g'`
for PHOTO_ID in $PHOTOS ; do
    PHOTO_INFO=`flickcurl photos.getInfo "$PHOTO_ID"`
    if [ -z "`echo "$PHOTO_INFO" | grep video`" ] ; then
        ORIGINAL_FORMAT=`echo "$PHOTO_INFO" | grep originalformat | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    else
        ORIGINAL_FORMAT="mov"
    fi
    TITLE=`echo "$PHOTO_INFO" | grep title | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    URL=`flickcurl photos.getSizes $PHOTO_ID | grep orig | sed "s/.*\(https:.*\)/\1/"1`
    if [ -z "$TITLE" ] ; then
        wget $URL
    else
        wget $URL -O "$TITLE.$ORIGINAL_FORMAT"
    fi
done
