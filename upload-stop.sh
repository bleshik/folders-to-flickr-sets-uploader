#!/bin/bash - 
#===============================================================================
#
#          FILE: upload-stop.sh
# 
#         USAGE: ./upload-stop.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Alexey Balchunas, 
#  ORGANIZATION: 
#       CREATED: 12/31/2013 11:28:47 MSK
#      REVISION:  ---
#===============================================================================
for i in `ps aux | grep flick | grep -v grep | tr -s ' ' | cut -f2 -d ' '` ; do echo $i ; kill $i ; done

