
echo "this needs to be run inside the VM. Supply the number of layers on the command line."

TIFFDIR=/var/tmp/perf-test-lions
SOURCE=/vagrant/perf-test
HOSTNAME=localhost
PORT=8080
WORKSPACE=perftest

STARTTIME=`date`

# create the workspace
curl -s -u admin:geoserver -XPOST -H "Content-type: text/xml" \
  -d "<workspace><name>$WORKSPACE</name></workspace>" \
  "http://$HOSTNAME:$PORT/geoserver/rest/workspaces"


# make the place the lions will go
mkdir --parents $TIFFDIR


# make and load the lions
for ((i=1; i<=$1; i++ )) ; do
	ln -s "$SOURCE/lion.tif" "$TIFFDIR/lion$i.tif"

	curl -s -w "\ngot %{http_code} for lion$i.tif" -o /dev/null \
		-u "admin:geoserver" \
		-XPUT \
		-H 'Content-type: image/tiff' \
		-d "file://$TIFFDIR/lion$i.tif" \
		"http://$HOSTNAME:$PORT/geoserver/rest/workspaces/$WORKSPACE/coveragestores/perflion$i/external.geotiff"
done


function finish {
	echo "started: $STARTTIME"
	echo "  ended: `date`"
}
trap finish EXIT