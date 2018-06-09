FROM ubuntu:latest
MAINTAINER bbkim <bbkimdev@gmail.com>

### server setting ###
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y openssh-server aptitude net-tools curl vim
RUN apt-get install -y xinetd
RUN apt-get install -y socat screen

### create user ###
RUN useradd -d /home/guest guest -s /bin/bash
RUN mkdir /home/guest

### PROB SETUP ###
ADD ./start.sh                 /start.sh
## PROB1
ADD ./injectme     /injectme
ADD ./injectme.c   /injectme.c
ADD ./flag         /flag

RUN chmod 755 /start.sh

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config

RUN echo 'root:toor' | chpasswd
RUN echo 'guest:guest' | chpasswd

EXPOSE 22 6969

CMD /usr/sbin/sshd -D

ENTRYPOINT /start.sh
