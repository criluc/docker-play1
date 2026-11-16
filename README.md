[![](https://badge.imagelayers.io/criluc/play1:latest.svg)](https://imagelayers.io/?images=criluc/play1:latest 'Get your own badge on imagelayers.io')

docker-play1
============

Docker for Play 1

  - play 1.5.3 patched version with SameSite cookie support, based on eclipse-temurin:11-jre-noble (Ubuntu 24.04).
  - play 1.5.3 patched version based on eclipse-temurin:11-jre-noble (Ubuntu 24.04).
  - play 1.5.{2,3} version based on official openjdk:11-jre.  
  - play 1.5.{0,1,2,3} version based on official openjdk:8-jre.
  - play 1.4.{3,4} version based on official openjdk:8-jre.
  - play 1.4.{0,1,2} version based on official openjdk-8.
  - play 1.{2.7,3.0,3.1,3.2} version based on official openjdk-7.

Play 1.5.3 ready to go
-----------------------

$ docker run -it --rm criluc/play1:1.5.3 bash

Play 1.5.3 using openjdk 11
---------------------------

$ docker run -it --rm criluc/play1:1.5.3-openjdk-11 bash

Play 1.5.3 patched (2) using eclipse-temurin 11 on Ubuntu 24.04
---------------------------------------------------------------

$ docker run -it --rm ghcr.io/criluc/play1:1.5.3-temurin-11-patched-2 bash

Rispetto a 1.5.3-temurin-11-patched aggiunge al play-1.5.3.jar il supporto
all'attributo SameSite dei cookie, che play 1.5.3 non prevede. Si attiva in
application.conf:

    application.session.sameSite=Lax

I valori ammessi sono Lax, Strict e None (None richiede anche
application.session.secure=true). Il valore vale per tutti i cookie emessi da
play: sessione, flash, errori e quelli impostati con response.setCookie; un
singolo cookie puo' indicarne uno diverso nel campo sameSite di Http.Cookie.
Senza la proprieta' l'attributo non viene inviato, come nelle immagini
precedenti. Un valore non valido impedisce l'avvio dell'applicazione.

Il play-1.5.3.jar del repository e' quello ufficiale con la correzione per
envers. Le modifiche successive sono nei file di patches/, come diff rispetto
ai sorgenti della release 1.5.3: il Dockerfile li applica, ricompila le sole
classi modificate e le sostituisce nel jar. Per usare lo stesso jar in una
installazione locale di play:

    docker run --rm ghcr.io/criluc/play1:1.5.3-temurin-11-patched-2 \
      cat /opt/play/play-1.5.3/framework/play-1.5.3.jar > play-1.5.3.jar

e copiarlo in framework/ al posto dell'originale.

L'immagine e' costruita e pubblicata su ghcr.io da GitHub Actions a ogni push
sul branch (.github/workflows/docker-publish.yml). Oltre al tag indicato sopra
viene pubblicato il tag 1.5.3-temurin-11-patched-2-<commit>, che non cambia.

Play 1.5.3 patched using eclipse-temurin 11 on Ubuntu 24.04
-----------------------------------------------------------

$ docker run -it --rm criluc/play1:1.5.3-temurin-11-patched bash

Il tag 1.5.3-temurin-11 e' un alias dello stesso digest. Come le altre
immagini con suffisso patched, contiene il play-1.5.3.jar corretto per il
problema di compatibilita' fra play ed envers.

Le immagini openjdk sono deprecate e non piu' disponibili su Docker Hub, da
qui il passaggio a eclipse-temurin. Gli script di play 1.5.x richiedono
python2, che non e' piu' incluso in nessuna distribuzione ancora supportata:
l'immagine lo copia da Ubuntu 22.04 con un build stage, cosi' la base resta
Ubuntu 24.04 (supportata fino ad aprile 2029).

Play 1.5.2 ready to go
-----------------------

$ docker run -it --rm criluc/play1:1.5.2 bash

Play 1.5.2 using openjdk 11
---------------------------

$ docker run -it --rm criluc/play1:1.5.2-openjdk-11 bash

Play 1.5.1 ready to go
-----------------------

$ docker run -it --rm criluc/play1:1.5.1 bash

Play 1.5.0 ready to go
-----------------------

$ docker run -it --rm criluc/play1:1.5.0 bash


Play 1.4.{1,2,3,4}
-----------------------

$ docker run -it --rm criluc/play1:1.4.0 bash # x to be replaced

Play 1.3.{1,2,3}
-----------------------

$ docker run -it --rm criluc/play1:1.3.x bash # x to be replaced  


Play 1.2.7
-----------------------

$ docker run -it --rm criluc/play1:1.2.7 bash