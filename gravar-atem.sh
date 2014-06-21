#/bin/bash


NOME=$(zenity --entry --text "Nome do arquivo a ser gravado?" --entry-text "MEU-EVENTO-DIA1-");
PATH_RECORD=/media/dados/TEIA

gst-launch-0.10 -v shmsrc socket-path=/tmp/test ! 'video/mpegts, systemstream=(boolean)true, packetsize=(int)188' ! queue ! filesink location=$PATH_RECORD/$NOME
