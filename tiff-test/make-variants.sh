
# copy starter lion tif
cp lion.tif samples/
cp lion.prj samples/

# make variants

gdal_translate -q samples/lion.tif samples/lion-none.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=NONE"
cp samples/lion.prj samples/lion-none.prj


gdal_translate -q samples/lion.tif samples/lion-lzw-p1.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=LZW"   -co "PREDICTOR=1"
cp samples/lion.prj samples/lion-lzw-p1.prj

gdal_translate -q samples/lion.tif samples/lion-dfl-p1.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=DEFLATE"   -co "PREDICTOR=1"
cp samples/lion.prj samples/lion-dfl-p1.prj


gdal_translate -q samples/lion.tif samples/lion-lzw-p2.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=LZW"   -co "PREDICTOR=2"
cp samples/lion.prj samples/lion-lzw-p2.prj

gdal_translate -q samples/lion.tif samples/lion-dfl-p2.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=DEFLATE"   -co "PREDICTOR=2"
cp samples/lion.prj samples/lion-dfl-p2.prj


gdal_translate -q samples/lion.tif samples/lion-lzw-p3.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=LZW"   -co "PREDICTOR=3"
cp samples/lion.prj samples/lion-lzw-p3.prj

gdal_translate -q samples/lion.tif samples/lion-dfl-p3.tif -a_srs "EPSG:4326" -of GTiff \
			 -co "COMPRESS=DEFLATE"   -co "PREDICTOR=3"
cp samples/lion.prj samples/lion-dfl-p3.prj

# gdal_translate -q lion.tif lion-lzw-16.tif -of GTiff \
# 			-co "NBITS=16" -co "COMPRESS=LZW"   -co "PREDICTOR=2"

# gdal_translate -q lion.tif lion-dfl-16.tif -of GTiff \
# 			-co "NBITS=16" -co "COMPRESS=DEFLATE"   -co "PREDICTOR=2"

# gdal_translate -q lion.tif lion-jpg-16-75.tif -of GTiff \
# 			-co "NBITS=8"  -co "COMPRESS=JPEG"  -co "JPEG_QUALITY=75" 

# gdal_translate -q lion.tif lion-jpg-16-75.tif -of GTiff \
# 			-co "NBITS=8"  -co "COMPRESS=JPEG"  -co "JPEG_QUALITY=75" 







