#!/bin/bash

# Create elasticsearch index
if [ ! -d "/photon/photon_data/elasticsearch" ]; then
	echo "Creating search index"
	java -jar photon.jar -nominatim-import -host 34.85.57.105 -port 6432 -database nominatim -user nominatim -password password1234 -languages es,fr,en,ja,ja_kana,ja_rm
fi

# Start photon if elastic index exists
if [ -d "/photon/photon_data/elasticsearch" ]; then
	echo "Starting photon"
	java -jar photon.jar -host 34.85.57.105 -port 6432 -database nominatim -user nominatim -password password1234 -languages es,fr,en,ja,ja_kana,ja_rm
else
	echo "Could not start photon, the search index could not be found"
fi
