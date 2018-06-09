FROM ubuntu:latest
MAINTAINER bbkim <bbkimdev@gmail.com>

### server setting ###
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install build-essential autoconf libcap2-bin -y
RUN apt-get install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev -y
RUN apt-get install install-info -y
RUN apt-get install asciidoc xmlto docbook2x -y
RUN apt-get install -y openssh-server aptitude net-tools curl vim
RUN apt-get install -y xinetd
RUN apt-get install -y gdb
RUN apt-get install -y socat screen
RUN apt-get install -y strace ltrace

### create user ###
RUN useradd -d /home/guest guest -s /bin/bash
RUN mkdir /home/guest

### PROB SETUP ###
ADD ./start.sh     /start.sh

ADD ./injectme     /home/guest/injectme
ADD ./injectme.c   /home/guest/injectme.c
ADD ./flag         /home/guest/flag
ADD ./flag3        /flag3

RUN chown guest:guest /home/guest/flag

RUN chmod 755 /start.sh
RUN chmod 440 /home/guest/flag
RUN chmod 440 /flag3

## PROB2
COPY ./git_src.tar.gz /git_src.tar.gz
RUN tar -xzvf /git_src.tar.gz
RUN rm /git_src.tar.gz
RUN cd /git* && make configure && ./configure --prefix=/usr && make all doc info && make install install-doc install-html install-info
RUN rm -rf /git*
RUN setcap CAP_DAC_OVERRIDE=+eip /usr/bin/git

### ssh setting ###
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config

RUN echo 'root:toor' | chpasswd
RUN echo 'guest:guest' | chpasswd

EXPOSE 22 6969

CMD /usr/sbin/sshd -D

ENTRYPOINT /start.sh
