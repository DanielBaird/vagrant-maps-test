

TIFFDIR=file:///vagrant
# REMOTE_GEOTIFF=file:///vagrant/lion-scaled-nochange.tif
# REMOTE_GEOTIFF=file:///vagrant/lion.tif
HOSTNAME=localhost
PORT=8888
WORKSPACE=wallace
# STORE_NAME=lionDS


for TIFFFILE in lion.tif lion-scaled.tif lion-scaled-nochange.tif ; do

	STORE_NAME=${TIFFFILE%%.tif}
	
	curl -w "\n (result: %{http_code})" \
		-u "admin:geoserver" \
		-XPUT \
		-H 'Content-type: image/tiff' \
		-d "$TIFFDIR/$TIFFFILE" \
		"http://$HOSTNAME:$PORT/geoserver/rest/workspaces/$WORKSPACE/coveragestores/$STORE_NAME/external.geotiff"

done


