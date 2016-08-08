FROM ubuntu:trusty

MAINTAINER comtihon <com.tihon@mail.ru>

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    wget \
    git \
    unzip

RUN cd /tmp; \
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb

RUN apt-get update \
    && apt-get -y install \
    erlang \
    erlang-base-hipe \
    build-essential

RUN mkdir /opt/app
RUN cd /opt/app; \
    wget https://github.com/SeaBattle/SeaUsers/archive/master.zip && \
    unzip master.zip

RUN cd /opt/app/SeaUsers-master; make

RUN wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip
RUN unzip consul_0.6.4_linux_amd64.zip \
    && cp consul /usr/bin

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
    
EXPOSE 8080

CMD ["/bin/bash", "/start.sh"]
