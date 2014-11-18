FROM dockerfile/java:openjdk-7-jdk

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

RUN apt-get update && apt-get install -y unzip wget git ant python && apt-get clean

ENV HOME /opt/play
RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /sbin/nologin -c "Play user" play
    
WORKDIR $HOME

USER play

RUN git clone -b 1.3.x https://github.com/playframework/play1.git --depth 1 && cd play1 && \
    rm -rf {samples-and-tests,documentation,.git} && \
    cd framework && ant && rm -rf classes

USER root
RUN ln -sf /opt/play/play1/play /usr/local/bin
USER play

EXPOSE 9000