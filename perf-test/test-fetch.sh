

HOSTNAME=localhost
PORT=7777
WORKSPACE=perftest

TESTCOUNT=100

for TESTINDEX in 1 10 100 1000 10000 ; do

	# curl -s "http://$HOSTNAME:$PORT/geoserver/$WORKSPACE/wms?service=WMS&request=GetMap&layers=$WORKSPACE:lion$TESTINDEX&styles=spp-suitability-red&format=image/png&transparent=true&version=1.1.1&height=256&width=256&srs=EPSG:3857&bbox=0,-5009377.085697311,5009377.085697311,0" > sample$TEXTINDEX.tif
	TIMESTART=$(date +%s)
	for ((n = 1; n < $TESTCOUNT; n++)); do
		curl -s "http://$HOSTNAME:$PORT/geoserver/$WORKSPACE/wms?service=WMS&request=GetMap&layers=$WORKSPACE:lion$TESTINDEX&styles=spp-suitability-red&format=image/png&transparent=true&version=1.1.1&height=256&width=256&srs=EPSG:3857&bbox=0,-5009377.085697311,5009377.085697311,0" >> /dev/null
	done
	TIMEEND=$(date +%s)
	TIMEDIFF=$(echo "$TIMEEND - $TIMESTART" | bc)
	echo "$TESTCOUNT fetches of tile from item at index $TESTINDEX: $TIMEDIFF seconds"

done