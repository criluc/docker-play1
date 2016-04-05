FROM java:openjdk-8-jre

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

RUN apt-get update && apt-get install -y sudo ant python && apt-get clean

ENV HOME /opt/play
RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /sbin/nologin -c "Play user" play

WORKDIR $HOME

USER play

RUN wget -q https://github.com/playframework/play1/releases/download/1.4.0/play-1.4.0.zip && \
    unzip -q play-1.4.0.zip && rm play-1.4.0.zip && cd play-1.4.0 && \
    tr -d '\r' <play>play-unix && chmod +x play-unix && mv play play-dos && ln -sf play-unix play

USER root
RUN ln -sf $HOME/play-1.4.0/play /usr/local/bin
COPY play-1.4.0.jar $HOME/play-1.4.0/framework/
RUN sed 's#www.playframework.com#'"playframework.com"'#' -i $HOME/play-${PLAY_VERSION}/framework/dependencies.yml
USER play

EXPOSE 9000