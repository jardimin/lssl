#/bin/bash

rm /tmp/test
cd bmd-tools
./bmd-streamer | gst-launch-0.10 -v fdsrc ! 'video/mpegts, systemstream=(boolean)true, packetsize=(int)188' ! shmsink socket-path=/tmp/test shm-size=10000000 wait-for-connection=0 sync=false
