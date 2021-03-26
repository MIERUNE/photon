#!/bin/sh

# Create elasticsearch index
if [ ! -d "/photon/photon_data/elasticsearch" ]; then
	echo "Creating search index"
	if [ -n "$PHOTON_LANGUAGES" ]; then
    java -Xms7G -Xmx7G -jar photon.jar -nominatim-import -host $NOMINATIM_HOST -port $NOMINATIM_PORT -database $NOMINATIM_DB_NAME -user $NOMINATIM_USER -password $NOMINATIM_PASSWORD -languages $PHOTON_LANGUAGES
  else
    java -Xms7G -Xmx7G -jar photon.jar -nominatim-import -host $NOMINATIM_HOST -port $NOMINATIM_PORT -database $NOMINATIM_DB_NAME -user $NOMINATIM_USER -password $NOMINATIM_PASSWORD
  fi
fi

if [ ! -n "$MAX_LOCAL_STORAGE_NODES" ]; then
  MAX_LOCAL_STORAGE_NODES = 1
fi

# Start photon if elastic index exists
if [ -d "/photon/photon_data/elasticsearch" ]; then
	echo "Starting photon"
	if [ -n "$PHOTON_LANGUAGES" ]; then
	  java -Xms7G -Xmx7G -jar photon.jar -max-local-storage-nodes $MAX_LOCAL_STORAGE_NODES -languages $PHOTON_LANGUAGES
	else
	  java -Xms7G -Xmx7G -jar photon.jar -max-local-storage-nodes $MAX_LOCAL_STORAGE_NODES
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
