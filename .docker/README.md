# Run on Docker

## Usage

```zsh
$ cp .env.example .env
$ vi .env # edit environmental variable for nominatim
NOMINATIM_HOST=your host
NOMINATIM_PORT=your port
NOMINATIM_NAME=your database
NOMINATIM_USER=your user
NOMINATIM_PASSWORD=your password
NOMINATIM_LANGUAGES=es,fr,en,ja,ja_kana,ja_rm

$ docker-compose build
$ docker-compose up -d
```

## Build package without docker

```zsh
# install icu
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-icu/analysis-icu-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-icu -Dversion=5.6.16 -Dpackaging=jar
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-icu/lucene-analyzers-icu-6.6.1.jar -DgroupId=org.elasticsearch.plugin -DartifactId=lucene-analyzers-icu -Dversion=5.6.16 -Dpackaging=jar
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-icu/icu4j-54.1.jar -DgroupId=org.elasticsearch.plugin -DartifactId=icu4j-54.1 -Dversion=5.6.16 -Dpackaging=jar

# kuromoji
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-kuromoji/analysis-kuromoji-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-kuromoji -Dversion=5.6.16 -Dpackaging=jar
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-kuromoji/lucene-analyzers-kuromoji-6.6.1.jar -DgroupId=org.elasticsearch.plugin -DartifactId=lucene-analyzers-kuromoji -Dversion=5.6.16 -Dpackaging=jar

mvn package
```