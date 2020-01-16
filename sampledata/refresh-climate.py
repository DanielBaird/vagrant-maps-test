
import os
import sys

os.system('rm -rf ./Climate/*')
os.system('scp -r wallace:/rdsi/wallace2/W2/climate_summaries/* Climate/')


for dir, subdirs, files in os.walk('./Climate'):
	for file in files:
		if file[-7:].lower() == '.asc.gz':
			print('unzipping %s/%s..' % (dir, file))
			os.system('gunzip -q "%s/%s"' % (dir, file))

prevdir = ''
for dir, subdirs, files in os.walk('./Climate'):

	if dir != prevdir:
		print('')
		sys.stdout.write('converting %s.. ' % dir)
		sys.stdout.flush()

	for file in files:

		ext = file[-4:]
		noext = file[:-4]

		if ext.lower() == '.asc':
			gdal_cmd = ' '.join([
				'gdal_translate -q ',
				"%s/%s" % (dir, file),
				"%s/%s.tif" % (dir, noext),
				'-a_srs "EPSG:4326"',
				'-co "COMPRESS=DEFLATE"',
				'-co "PREDICTOR=1"',
				'-of GTiff'
			])
			os.system(gdal_cmd)
			sys.stdout.write('.')
			sys.stdout.flush()

print('Now run something like:')
print('scp -r Climate/* wallace-maps:/usr/share/tomcat/webapps/geoserver/data/data/wallace/Climate')

