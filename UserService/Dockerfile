FROM ubuntu:trusty

MAINTAINER comtihon <com.tihon@mail.ru>

RUN apt-get update && apt-get -y upgrade && apt-get -y install wget && apt-get -y install unzip

RUN cd /tmp; wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb

RUN apt-get update && apt-get -y install erlang erlang-base-hipe build-essential

RUN cd /opt/app; wget https://github.com/SeaBattle/SeaUsers/archive/master.zip && unzip master.zip

RUN cd SeaUsers-master; make


CMD ["erl"]
