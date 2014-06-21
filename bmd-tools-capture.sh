#/bin/bash

#define your src folder
$HOME=/home/jardim/src

rm /tmp/test
cd $HOME/bmd-tools
./bmd-streamer | gst-launch-0.10 -v fdsrc ! 'video/mpegts, systemstream=(boolean)true, packetsize=(int)188' ! shmsink socket-path=/tmp/test shm-size=10000000 wait-for-connection=0 sync=false
