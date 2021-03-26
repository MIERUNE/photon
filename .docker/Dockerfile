FROM maven:3.6.3-openjdk-8-slim as build

COPY . /usr/src/

WORKDIR /usr/src/

# install analysis-icu, analysis-kuromoji, then make jar package.
RUN mvn install:install-file -Dfile=/usr/src/es/modules/analysis-icu/analysis-icu-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-icu -Dversion=5.6.16 -Dpackaging=jar \
    && mvn install:install-file -Dfile=/usr/src/es/modules/analysis-kuromoji/analysis-kuromoji-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-kuromoji -Dversion=5.6.16 -Dpackaging=jar \
    && mvn package

FROM adoptopenjdk/openjdk8:alpine-jre

WORKDIR /photon
COPY --from=build /usr/src/target/photon-0.3.4.jar /photon/photon.jar
COPY ./.docker/entrypoint.sh /photon/entrypoint.sh

RUN rm -rf /usr/src

EXPOSE 2322

ENTRYPOINT /photon/entrypoint.sh