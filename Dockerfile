FROM openjdk:8-jre

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

RUN apt-get update && apt-get install -y sudo ant python && apt-get clean

ENV HOME /opt/play
ENV PLAY_VERSION=1.4.0

RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /sbin/nologin -c "Play user" play

WORKDIR $HOME

USER play

RUN wget -q https://github.com/playframework/play1/releases/download/1.4.0/play-1.4.0.zip && \
    unzip -q play-${PLAY_VERSION}.zip && rm play-${PLAY_VERSION}.zip && cd play-${PLAY_VERSION} && \
    tr -d '\r' <play>play-unix && chmod +x play-unix && mv play play-dos && ln -sf play-unix play

USER root
RUN ln -sf $HOME/play-${PLAY_VERSION}/play /usr/local/bin
USER play

EXPOSE 9000