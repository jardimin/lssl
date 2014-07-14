**LSSL - Linux Switch and Stream Laptop**
=============

O projeto busca reunir aplicativos, bibliotecas e informação para operação da mesa de corte Blackmagic ATEM TVS com o sistema operacional GNU/Linux. Especificamente, colocaremos em uso um Laptop (mínimo i5 e 4GB RAM) para capturar, gravar e re-estrimar o fluxo de vídeo gerado pela ATEM TVS, além de realizar operações simples e efetivas da placa e como dar "preview", cortar, aplicar Downstream key e controlar volume dos canais de áudio da mesma. A parte de "streaming" é realizada pelo framework *Gstreamer* e as funções de corte e controle são possibilitadas pela biblioteca  https://github.com/petersimonsson/libqatemcontrol recentemente incorporada pelo cliente oficial de CasparCG https://github.com/CasparCG/Client. Também utilizamos Puredata com os "externals" de osc (open sound control) de Mr Peach para interfaciar as operações e automações (se desejadas) com o cliente do CasparCG, além de extender o controle e comandos para hardwares externos e controladores midis por exemplo.


*The project aims to gather apps, libs and info for putting up a GNU/Linux based Laptop (minimum i5 and 4 GB RAM) for capturing, recording and Re-streaming the mpegts stream file from the modest Blackmagic ATEM TVS, as well as doing some simple and effective  operations (not all operations at the moment) like previewing, cutting, downstream keying and controlling audio channels. The streaming part of it is done by *Gstreamer* and the control functions of the hardware are based in  https://github.com/petersimonsson/libqatemcontrol  recently build into CasparCG client https://github.com/CasparCG/Client. We use also Puredata with Mr Peaches open sound control externals for interfacing with CasparCG client and extending the operation and automation (if desired) to it's almost limitless power (connecting midi controllers, external hardwares, creating macros and so forth).*


**Dependências**

- bmd-tools: Biblioteca para captura do stream gerado pela ATEM TVS - https://github.com/fabled/bmd-tools - No sistema de teste as últimas versões do Fabled quebraram compatibilidade com nossa versão funcional, então neste repositório se encontra uma versão funcional do código-fonte para Debian Testing/Sid: Dependências libusb-1.0-dev (versão >= a 1.0.16) e o ".exe"  do driver para Windows, necessário para a extração do Firmware (deve ser a mesma versão do Firmware da sua ATEM TVS, testado com versão 4.2 que pode ser baixada aqui http://bit.ly/1nXVf5B . Primeiro passo é extrair o Firmware do executável (copie o BMDStreamingServer.exe, da pasta "program files/Blackmagic" de uma instalação de Windows para a pasta "bmd-tools"):

> $ cd bmd-tools 

> $ ./bmd-extractfw < BMDStreamingServer.exe

- Gstreamer (0.10). Manipula o fluxo em "mpeg2 transport stream" (h264 e aac) da ATEM TVS, já capturado pelo bmd-tools, o decodifica e o manipula. Chamamos as duas tarefas do gstreamer por dois scripts, um para pegar via pipe do bmd-tools e o deixar disponível  (bmd-tools-capture.sh )  e um segundo para gravar o fluxo original que já vem comprimido da ATEM (gravar-atem.sh). Precisamos do "gstreamer0.10-plugins-bad" para excutar os compoenetes necessários e o zenity para o auxilair a gravação e nomerar os arquivos:

> $ sudo apt-get install gstreamer0.10-plugins-bad zenity

- Flumotion - codifica o fluxo e transmite para servidores (não entrará no escopo deste projeto) Importante que qualquer outra aplicação de streaming via Gstreamer pode ser usada no lugar dele se desejado.

- CasparCG Client - ele dispara as ações de corte e afins na ATEM TVS e é necessário configurá-la na rede local, fornecendo o IP da mesma (Edit > Settings > Mixer > Atem +). Para a configuração incluída funcionar, você deverá dar o nome de sua placa de "atem". O binário do software ja está incluído no repositório e ele é chamado no script "mesa-de-corte.sh". Após ser executados, devemos carregar o arquivo de configuração no caspar-cg client, estes são chamados de "rundown" e tem extensão .xml 

- Pd-extended - atua como interface de operação. Pacotes em  http://sourceforge.net/projects/pure-data/files/pd-extended/ . Baixar o pacote .deb e instalá-lo com:

> sudo dpkg -i pd-extended_xxxx.deb

> sudo apt-get -f install


**Mão na Massa**

- Conecte o cabo usb da ATEM TVS no seu computador e Dê permissão de leitura do dispositivo usb pro bmd-tools, adicionando seu user ao grupo root (Eu sei que não é a melhor prática de segurança, mas é a forma mais rápida)

> sudo usermod -a -G root seu_usuario

- Baixar este repositório

> git clone https://github.com/jardimin/lssl

> cd lssl 

> ./bmd-tools-capture.sh (começa a captura do fluxo)

> ./gravar-atem.sh (em outra aba do terminal - escolha o nome do arquivo e a pasta ele gravará o arquivo original no formato "mpeg2 transport stream" .ts )

> ./mesa-de-corte.sh (também  em outra aba do terminal e uma vez que é a primieira vez que vocẽ roda o Casparcg-client, temos que adicionar a Atem TVS, dando o ip do hardware e o nomeando conforme explicado acima e por último. Após a configuração, carregue o rundown : file > open rundowns > casparcg-rundown > atem.xml )

Voilá - já podemos cortar os canais através da interface do PD. 


**English**

**Dependencies**

- bmd-tools: For capturing the mpeg2 steram from Atem TVS - https://github.com/fabled/bmd-tools - There is a copy of a working version of the libe in this repo (some commits ago, flabled coe stoped working in the test system - Debian Sid/Testing . It depends on libusb-1.0-dev 1.0.16 or newer and you will need a ".exe" from the /windows oficcial driver for etracing the firmware (this one /i could not distribute in here ad you can find it in http://bit.ly/1nXVf5B (It must match your Atem TVS firmware version, here it's working with 4.2 version  . First step is extracting the firmware. Copy BMDStreamingServer.exe, from a windows installation in "program files/Blackmagic" to the bmd-tools folder" and run:

> $ cd bmd-tools 

> $ ./bmd-extractfw < BMDStreamingServer.exe

- Gstreamer (0.10). It decodes and handle (stream, record, etc) the stream from ATEM TVS once this has been captured from  bmd-tools. In the app, we call it twice, feeding from bmd-tools pipe  (bmd-tools-capture.sh ) and for recording the stream as it is (gravar-atem.sh). We need "gstreamer0.10-plugins-bad" and zenity for the bash script:

> $ sudo apt-get install gstreamer0.10-plugins-bad zenity

- Flumotion is used in the project but will not be covered in here, thus, any other gstreamer application could be used instead.

- CasparCG Client - It's the one access the ATEM trough udp and give commands to it,We need to set ATEM IPs in it (Edit > Settings > Mixer > Atem +). For the included configuration to work out of the box, you must name the ATEM TVS as "atem". A pre-compilled version is already included in this repo and it's called with the "mesa-de-corte.sh" script.  After running this script, we should load the conf file (called rundown by the app and it has a .xml extension) 

- Pd-extended - used as interface for controlling and attaching midi controllers or setting keyboard shortcuts. Packages in  http://sourceforge.net/projects/pure-data/files/pd-extended/ . Download a  .deb and install it with:

> sudo dpkg -i pd-extended_xxxx.deb

> sudo apt-get -f install


**Action**

- First at all we need to connect the usb cable and give usb read permission for bmd-tools addinf your unix user to the root group (not the best and safe methos but it's quick to setup)

> sudo usermod -a -G root your_user

- Clone this repo and fire the scripts from different "gnome-terminal" tabs

> git clone https://github.com/jardimin/lssl

> cd lssl 

> ./bmd-tools-capture.sh (starts capturing)

> ./gravar-atem.sh (choose the folder and name of the file and record the  mpeg 2 transport stream .ts )

> ./mesa-de-corte.sh (Once it'sthe fisrt time you run casparcg-client you should add the ATEM hardware as explained above, after it, load the rundown : file > open rundowns > casparcg-rundown > atem.xml )

Voilá - You could cut and previews and DSK trough the puredata intreface.


