#/bin/bash

echo $1
echo $2

#gst-launch-0.10 -v shmsrc socket-path=/tmp/test ! 'video/mpegts, systemstream=(boolean)true, packetsize=(int)188' ! queue ! filesink location=$2/$1
