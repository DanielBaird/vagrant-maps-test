

HOSTNAME=localhost
PORT=8888

TIFFDIR="samples"
# WORKSPACE=wallace
WORKSPACE="wtest"


# create the workspace

curl -s -u admin:geoserver -XPOST -H "Content-type: text/xml" \
  -d "<workspace><name>$WORKSPACE</name></workspace>" \
  "http://$HOSTNAME:$PORT/geoserver/rest/workspaces"
echo 

# upload all the lions

pushd $TIFFDIR > /dev/null
for TIFFFILE in *.tif ; do

	STORE_NAME=${TIFFFILE%%.tif}

	# cp ../lion.prj "${TIFFFILE%%.tif}.prj"
	
	curl -s -w "\ngot %{http_code} for $TIFFFILE" -o /dev/null \
		-u "admin:geoserver" \
		-XPUT \
		-H 'Content-type: image/tiff' \
		-d "file:///vagrant/tiff-test/$TIFFDIR/$TIFFFILE" \
		"http://$HOSTNAME:$PORT/geoserver/rest/workspaces/$WORKSPACE/coveragestores/$STORE_NAME/external.geotiff"

done
echo
popd > /dev/null

