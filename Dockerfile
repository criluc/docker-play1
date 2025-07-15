FROM eclipse-temurin:11.0.27_6-jre

LABEL org.opencontainers.image.authors="Cristian Lucchesi <cristian.lucchesi@iit.cnr.it>"

RUN apt update && apt dist-upgrade -y && apt install -y unzip

RUN curl --remote-name-all http://security.ubuntu.com/ubuntu/pool/universe/p/python2.7/{python2.7_2.7.18-13ubuntu1.5_amd64.deb,libpython2.7-stdlib_2.7.18-13ubuntu1.5_amd64.deb,python2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb,libpython2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb}
RUN apt install -y ./libpython2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb \
  ./libpython2.7-stdlib_2.7.18-13ubuntu1.5_amd64.deb \
  ./python2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb \
  ./python2.7_2.7.18-13ubuntu1.5_amd64.deb
RUN ln -sf /usr/bin/python2.7 /usr/bin/python && rm *.deb && apt-get clean

ENV HOME=/opt/play
ENV PLAY_VERSION=1.5.3
RUN groupadd -r play -g 1001 && \
    useradd -u 1001 -r -g play -m -d $HOME -s /sbin/nologin -c "Play user" play

WORKDIR $HOME

USER play

RUN curl -O -L https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip && \
    unzip -q play-${PLAY_VERSION}.zip && rm play-${PLAY_VERSION}.zip && cd play-${PLAY_VERSION}

USER root
RUN ln -sf $HOME/play-${PLAY_VERSION}/play /usr/local/bin
USER play
COPY play-${PLAY_VERSION}.jar $HOME/play-${PLAY_VERSION}/framework/

EXPOSE 9000
