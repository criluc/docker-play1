[![](https://badge.imagelayers.io/criluc/play1:latest.svg)](https://imagelayers.io/?images=criluc/play1:latest 'Get your own badge on imagelayers.io')

docker-play1
============

Docker for Play 1

  - play 1.5.3 version based on eclipse-temurin:11-jre-noble (Ubuntu 24.04).
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

Play 1.5.3 using eclipse-temurin 11 on Ubuntu 24.04
---------------------------------------------------

$ docker run -it --rm criluc/play1:1.5.3-temurin-11 bash

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