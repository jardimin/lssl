**LSSL - Linux Switch and Stream Laptop**
=============

O projeto busca reunir aplicativos, bibliotecas e informação para operação da mesa de corte Blackmagic ATEM TVS com o sistema operacional GNU/Linux. Especificamente, colocaremos em uso um Laptop (mínimo i5 e 4GB RAM) para capturar, gravar e re-estrimar o fluxo de vídeo gerado pela ATEM TVS, além de realizar operações simples e efetivas da placa e como dar "preview", cortar, aplicar Downstream key e controlar volume dos canais de áudio da mesma. A parte de "streaming" é realizada pelo framework *Gstreamer* e as funções de corte e controle são possibilitadas pela biblioteca  https://github.com/petersimonsson/libqatemcontrol recentemente incorporada pelo cliente oficial de CasparCG https://github.com/CasparCG/Client. Também utilizamos Puredata com os "externals" de osc (open sound control) de Mr Peach para interfaciar as operações e automações (se desejadas) com o cliente do CasparCG, além de extender o controle e comandos para hardwares externos e controladores midis por exemplo.


*The project aims to gather apps, libs and info for putting up a GNU/Linux based Laptop (minimum i5 and 4 GB RAM) for capturing, recording and Re-streaming the mpegts stream file from the modest Blackmagic ATEM TVS, as well as doing some simple and effective  operations (not all operations at the moment) like previewing, cutting, downstream keying and controlling audio channels. The streaming part of it is done by *Gstreamer* and the control functions of the hardware are based in  https://github.com/petersimonsson/libqatemcontrol  recently build into CasparCG client https://github.com/CasparCG/Client. We use also Puredata with Mr Peaches open sound control externals for interfacing with CasparCG client and extending the operation and automation (if desired) to it's almost limitless power (connecting midi controllers, external hardwares, creating macros and so forth).*


**Dependências**

- bmd-tools: Biblioteca para captura do stream gerado pela ATEM TVS - https://github.com/fabled/bmd-tools - No sistema de teste as últimas versões do Fabled quebraram compatibilidade com nossa versão funcional, então neste repositório se encontra uma versão funcional do código-fonte para Debian Testing/Sid: Dependências libusb-1.0-dev e o ".exe"  do driver para Windows, necessário para a extração do Firmware (deve ser a mesma versão do Firmware da sua ATEM TVS, testado com versão 4.2 que pode ser baixada aqui http://bit.ly/1nXVf5B . Primeiro passo é extrair o Firmware do executável (copie o BMDStreamingServer.exe, da pasta "program files/Blackmagic" de uma instalação de Windows para a pasta "bmd-tools"):

> $ cd bmd-tools 

> $ ./bmd-extractfw < BMDStreamingServer.exe


- Gstreamer (0.10). Manipula o fluxo em mpeg2 (h264 e aac) da ATEM TVS, já capturado pelo bmd-tools, o decodifica e o manipula. Chamamos as duas tarefas do gstreamer por dois scripts, um para pegar via pipe do bmd-tools e o deixar disponível  (bmd-tools-capture.sh )  e um segundo para gravar o fluxo original que já vem comprimido da ATEM (gravar-atem.sh). Precisamos do "gstreamer0.10-plugins-bad" para excutar os compoenetes necessários e o zenity para o auxilair a gravação e nomerar os arquivos:

> $ sudo apt-get install gstreamer0.10-plugins-bad zenity

- Flumotion - codifica o fluxo e transmite para servidores (não entrará no escopo deste projeto) Importante que qualquer outra aplicação de streaming via Gstreamer pode ser usada no lugar dele se desejado.

- CasparCG Client - ele dispara as ações de corte e afins na ATEM TVS e é necessário configurá-la na rede local, fornecendo o IP da mesma (Edit > Settings > Mixer > Atem +). Para a configuração incluída funcionar, você deverá dar o nome de sua placa de "atem". O binário do software ja está incluído no repositório e ele é chamado no script "mesa-de-corte.sh" que o executa e já carrega seu arquivo de configuração com os comandos pré-configurados (no caspar-cg client, estes arquivos de configurações são chamados de "rundown" e tem extensão .xml) 

- Pd-extended - atua como interface de operação. Pacotes em  http://sourceforge.net/projects/pure-data/files/pd-extended/ . Baixar o pacote .deb e instalá-lo com:

> sudo dpkg -i pd-extended_xxxx.deb

> sudo apt-get -f install


**Mão na Massa**

Baixar este repositório

> git clone https://github.com/jardimin/lssl

> cd lssl 

> ./bmd-tools-capture.sh

> ./gravar-atem.sh (em outra aba do terminal)

> ./mesa-de-corte.sh (em outra aba do terminal também e adicionar a Atem TVS no Casparcg-client como explicada acima )


