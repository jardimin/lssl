#!/bin/bash
# sempre baixarmos atualizações do clint e renomear pasta para "casparcg-client"

# set the rundown and pd patch names
PD_NAME=pd-atem-control-GUI.pd
RUNDOWN_NAME=atem.xml


# using pre-compiled client from http://sourceforge.net/projects/casparcg/files/CasparCG_Client/
# call casparcg client
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:casparcg-client/lib
export LD_LIBRARY_PATH
casparcg-client/bin/client -rundown casparcg-rundowns/$RUNDOWN_NAME &


#call pd patch
/usr/bin/pd-extended pd/$PD_NAME &


# if compiled from source we need to declare all paths and execute the 'shell' binary

# LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Widgets/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Core/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Common/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Gpi/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Osc/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../TriCaster/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Caspar/:/home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/../Atem/:/home/jardim/src/Client/src/Shell/../../lib/gpio-client/lib/linux/:/home/jardim/src/Client/src/Shell/../../lib/oscpack/lib/linux/:/home/jardim/src/Client/src/Shell/../../lib/qatemcontrol/lib/linux/release/ /home/jardim/src/Client/Solution-build-desktop-Qt_4_8_2_in_PATH__System__Release/Shell/shell "$@" &



 

