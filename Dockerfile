FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip

RUN useradd -ms /bin/bash steam


#Steamcmd installation
RUN mkdir -p /server/steamcmd
RUN mkdir -p /server/css
WORKDIR /server/steamcmd
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz
# Install server
RUN cd /server/steamcmd && ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/css \
                 +app_update 232330 validate \
                 +quit 
#Server Start
WORKDIR /server/cs
ADD start.sh /server/css/start.sh
RUN chmod 755 /server/css/start.sh

CMD ["/server/css/start.sh"]