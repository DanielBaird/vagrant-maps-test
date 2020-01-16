
RESTHOSTURL="http://wallace-maps.hpc.jcu.edu.au/geoserver/rest"

curl -w " (result: %{http_code})" \
	-u "admin:geoserver" \
	-XDELETE \
	"$RESTHOSTURL/workspaces/wallace/coveragestores/species__Panthera_leo__TEMP_2_10.no.disp/coverages/TEMP_2_10.no.disp"

curl -w " (result: %{http_code})" \
	-u "admin:geoserver" \
	-XPOST \
	-H "Content-type: text/xml" \
	-d "<coverage><name>test-name-should-work</name><nativeName>TEMP_2_10.no.disp</nativeName></coverage>" \
	"$RESTHOSTURL/workspaces/wallace/coveragestores/species__Panthera_leo__TEMP_2_10.no.disp/coverages"
