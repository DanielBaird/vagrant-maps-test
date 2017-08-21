

HOSTNAME=localhost
PORT=8888

TIFFDIR=file:///vagrant/perf-test
# WORKSPACE=wallace
WORKSPACE=wtest


#for TIFFFILE in lion.tif lion-scaled.tif lion-scaled-nochange.tif ; do
for TIFFFILE in lion-none.tif lion-dfl-p1.tif lion-lzw-p1.tif lion-dfl-p2.tif lion-lzw-p2.tif lion-dfl-p3.tif lion-lzw-p3.tif lion.tif ; do

	STORE_NAME=${TIFFFILE%%.tif}
	
	curl -w "\n (result: %{http_code})" \
		-u "admin:geoserver" \
		-XPUT \
		-H 'Content-type: image/tiff' \
		-d "$TIFFDIR/$TIFFFILE" \
		"http://$HOSTNAME:$PORT/geoserver/rest/workspaces/$WORKSPACE/coveragestores/$STORE_NAME/external.geotiff"

done


