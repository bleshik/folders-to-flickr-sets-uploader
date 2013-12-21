#!/bin/bash - 
#===============================================================================
#
#          FILE: download-set.sh
# 
#         USAGE: ./download-set.sh SET-NAME
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Alexey Balchunas, 
#  ORGANIZATION: 
#       CREATED: 12/21/2013 18:06:00 MSK
#      REVISION:  ---
#===============================================================================

set -o nounset

SET_NAME=$1
if [ ! -d "$SET_NAME" ] ; then
    mkdir "$SET_NAME"
fi
cd "$SET_NAME"
SETS=`flickcurl photosets.getList`
SET_ID=`echo "$SETS" | grep "title: '$SET_NAME'" | head -n1 | sed -e 's/.*ID \([0-9]*\) .*/\1/g'`
PHOTOS=`flickcurl photosets.getPhotos "$SET_ID" | grep "ID \d\+" | sed -e 's/.*ID \([0-9]*\).*/\1/g'`
for PHOTO_ID in $PHOTOS ; do
    PHOTO_INFO=`flickcurl photos.getInfo "$PHOTO_ID"`
    FARM=`echo "$PHOTO_INFO" | grep farm | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    SERVER=`echo "$PHOTO_INFO" | grep server | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    ORIGINAL_SECRET=`echo "$PHOTO_INFO" | grep originalsecret | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    ORIGINAL_FORMAT=`echo "$PHOTO_INFO" | grep originalformat | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    TITLE=`echo "$PHOTO_INFO" | grep title | sed -e "s/.*value: '\(.*\)'.*/\1/g"`
    URL="http://farm$FARM.staticflickr.com/$SERVER/${PHOTO_ID}_${ORIGINAL_SECRET}_o.$ORIGINAL_FORMAT"
    if [ -z "$TITLE" ] ; then
        wget $URL
    else
        wget $URL -O "$TITLE.$ORIGINAL_FORMAT"
    fi
done
