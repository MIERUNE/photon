# Run on Docker

## Usage

```zsh
$ cp .env.example .env
$ vi .env # edit environmental variable for nominatim
NOMINATIM_HOST=your host
NOMINATIM_PORT=your port
NOMINATIM_DB_NAME=your database
NOMINATIM_USER=your user
NOMINATIM_PASSWORD=your password
PHOTON_LANGUAGES=es,fr,en,ja,ja_kana

$ docker-compose build
$ docker-compose up -d
```

## Build package without docker

```zsh
# install icu
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-icu/analysis-icu-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-icu -Dversion=5.6.16 -Dpackaging=jar

# kuromoji
mvn install:install-file -Dfile=$(pwd)/es/modules/analysis-kuromoji/analysis-kuromoji-5.6.16.jar -DgroupId=org.elasticsearch.plugin -DartifactId=analysis-kuromoji -Dversion=5.6.16 -Dpackaging=jar

mvn package
```