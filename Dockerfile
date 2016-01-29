FROM anapsix/alpine-java:jdk8

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

ADD python2.7-static /bin/python

ENV HOME /opt/play

WORKDIR $HOME

RUN apk add --no-cache wget bash && \
	wget -q https://github.com/playframework/play1/releases/download/1.4.0/play-1.4.0.zip && \
    unzip -q play-1.4.0.zip && rm play-1.4.0.zip && cd play-1.4.0 && \
    tr -d '\r' <play>play-unix && chmod +x play-unix && mv play play-dos && ln -sf play-unix play && \
	ln -sf $HOME/play-1.4.0/play /usr/local/bin && \
	chmod +x /bin/python && \
	apk del wget

COPY play-1.4.0.jar $HOME/play-1.4.0/framework/

EXPOSE 9000