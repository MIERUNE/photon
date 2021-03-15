FROM maven:3.6.3-openjdk-8 as builder

COPY . /usr/src/

WORKDIR /usr/src/

# install icu
RUN mvn install:install-file -Dfile=/usr/src/es/modules/analysis-icu/analysis-icu-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-icu -Dversion=5.6.16 -Dpackaging=jar
# kuromoji
RUN mvn install:install-file -Dfile=/usr/src/es/modules/analysis-kuromoji/analysis-kuromoji-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-kuromoji -Dversion=5.6.16 -Dpackaging=jar

RUN mvn package
# RUN ls target -ln
RUN mkdir /photon && cp /usr/src/target/photon-0.3.4.jar /photon/photon.jar

# FROM openjdk:8-jre

WORKDIR /photon
# # ADD https://github.com/komoot/photon/releases/download/0.3.4/photon-0.3.4.jar /photon/photon.jar
COPY ./.docker/entrypoint.sh /photon/entrypoint.sh

EXPOSE 2322

ENTRYPOINT /photon/entrypoint.sh