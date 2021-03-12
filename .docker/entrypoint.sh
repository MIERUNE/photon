#!/bin/bash

DB_HOST=$NOMINATIM_HOST
DB_PORT=$NOMINATIM_PORT
DB_NAME=$NOMINATIM_NAME
DB_USER=$NOMINATIM_USER
DB_PASS=$NOMINATIM_PASSWORD
LANGUAGES=$NOMINATIM_LANGUAGES

# Create elasticsearch index
if [ ! -d "/photon/photon_data/elasticsearch" ]; then
	echo "Creating search index"
	if [ -n "$LANGUAGES" ]; then
      java -Xmx7168m　-jar photon.jar -nominatim-import -host $DB_HOST -port $DB_PORT -database $DB_NAME -user $DB_USER -password $DB_PASS -languages $LANGUAGES
    else
      java -Xmx7168m　-jar photon.jar -nominatim-import -host $DB_HOST -port $DB_PORT -database $DB_NAME -user $DB_USER -password $DB_PASS
    fi
fi

# Start photon if elastic index exists
if [ -d "/photon/photon_data/elasticsearch" ]; then
	echo "Starting photon"
	if [ -n "$LANGUAGES" ]; then
	  java -jar photon.jar -host $DB_HOST -port $DB_PORT -database $DB_NAME -user $DB_USER -password $DB_PASS -languages $LANGUAGES
	else
	  java -jar photon.jar -host $DB_HOST -port $DB_PORT -database $DB_NAME -user $DB_USER -password $DB_PASS
	fi
	### Start continuous update ###

	# while true; do
	# 	starttime=$(date +%s)
	#
	# 	curl http://localhost:2322/nominatim-update
	#
	# 	# sleep a bit if updates take less than 5 minutes
	# 	endtime=$(date +%s)
	# 	elapsed=$((endtime - starttime))
	# 	if [[ $elapsed -lt 300 ]]; then
	# 		sleepy=$((300 - $elapsed))
	# 		echo "Sleeping for ${sleepy}s..."
	# 		sleep $sleepy
	# 	fi
	# done

else
	echo "Could not start photon, the search index could not be found"
fi
