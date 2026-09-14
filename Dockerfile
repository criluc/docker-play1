# Gli script di play 1.5.x sono python2-only e nessuna distribuzione ancora
# supportata fornisce piu' un pacchetto python2: Ubuntu 22.04 (jammy) e'
# l'ultima. Invece di restare fermi a jammy (fine supporto: aprile 2027) la
# base e' Ubuntu 24.04 (noble, aprile 2029) e python2.7 viene copiato da
# jammy con un build stage. Rispetto al download dei .deb dall'archivio
# Ubuntu questo non si rompe quando esce una nuova patch di python2.7 (il
# file pinnato sparisce) ne' quando jammy va in EOL (i pacchetti migrano su
# old-releases.ubuntu.com): le immagini Ubuntu restano invece pubblicate.
FROM ubuntu:22.04 AS python2

RUN apt-get update && apt-get install -y --no-install-recommends python2.7

FROM eclipse-temurin:11-jre-noble

LABEL maintainer="Cristian Lucchesi <cristian.lucchesi@gmail.com>"

# Il binario di python2.7-minimal non e' linkato a libpython2.7.so.1.0, quindi
# bastano l'eseguibile, la stdlib e la configurazione. I moduli di estensione
# (ssl, zlib, ...) usano le librerie di sistema di noble.
COPY --from=python2 /usr/bin/python2.7 /usr/bin/python2.7
COPY --from=python2 /usr/lib/python2.7 /usr/lib/python2.7
COPY --from=python2 /etc/python2.7 /etc/python2.7
RUN ln -sf /usr/bin/python2.7 /usr/bin/python

RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo ant wget unzip ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV HOME=/opt/play
ENV PLAY_VERSION=1.5.3
# L'utente play deve avere uid/gid 1000 come nelle immagini precedenti: i
# volumi montati dall'host in produzione appartengono a quell'uid numerico.
# noble include gia' un utente "ubuntu" con uid/gid 1000 che va quindi
# rimosso; e' un utente di comodo per non girare da root, senza servizi ne'
# configurazioni che dipendano da lui (possiede solo /home/ubuntu e i suoi
# tre dotfile). La rimozione e' condizionale e per uid, non per nome, cosi'
# il file non si rompe se la base cambia o smette di includerlo.
RUN set -eu; \
    if getent passwd 1000 >/dev/null; then \
        existing="$(getent passwd 1000 | cut -d: -f1)"; \
        userdel -r "$existing" || userdel "$existing"; \
    fi; \
    if getent group 1000 >/dev/null; then \
        groupdel "$(getent group 1000 | cut -d: -f1)"; \
    fi; \
    groupadd -r play -g 1000; \
    useradd -u 1000 -r -g play -m -d "$HOME" -s /sbin/nologin -c "Play user" play

WORKDIR $HOME

USER play

RUN wget -q https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip && \
    unzip -q play-${PLAY_VERSION}.zip && rm play-${PLAY_VERSION}.zip

USER root
RUN ln -sf $HOME/play-${PLAY_VERSION}/play /usr/local/bin
USER play
COPY play-${PLAY_VERSION}.jar $HOME/play-${PLAY_VERSION}/framework/

EXPOSE 9000
