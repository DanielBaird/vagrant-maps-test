
# FINE we'll use postgres for now
# install it
yum install postgresql-server postgresql-contrib -y
sudo postgresql-setup initdb

# copy in config that lets the postgres user get in from localhost
rm -f /var/lib/pgsql/data/pg_hba.conf
cp /vagrant/deploy/config/pg_hba.conf /var/lib/pgsql/data/

# run it now and forever
sudo systemctl start postgresql
sudo systemctl enable postgresql

# get plugin and install
echo "downloading JDBCConfig plugin..."
wget --quiet http://ares.boundlessgeo.com/geoserver/2.11.x/community-latest/geoserver-2.11-SNAPSHOT-jdbcconfig-plugin.zip
unzip geoserver-2.11-SNAPSHOT-jdbcconfig-plugin.zip *.jar -d /var/lib/tomcat/webapps/geoserver/WEB-INF/lib/


# kick tomcat over to restart geoserver, which creates the [data]/jdbcconfig dir
# (by default the data dir is at /usr/share/tomcat/webapps/geoserver/data )
tomcat stop
tomcat start
echo "started tomcat, waiting 10 seconds for dir to be created"
sleep 10


# stop geoserver
tomcat stop

# copy in the config
rm -f /usr/share/tomcat/webapps/geoserver/data/jdbcconfig/jdbcconfig.properties
cp /vagrant/deploy/config/jdbcconfig.properties /usr/share/tomcat/webapps/geoserver/data/jdbcconfig/

# make the db
sudo -u postgres createdb gscatalog
sudo -u postgres psql -d gscatalog < /usr/share/tomcat/webapps/geoserver/data/jdbcconfig/scripts/initdb.postgres.sql

# restart geoserver
tomcat start
echo "Started tomcat; jdbcconfig plugin is now importing geoserver config."
echo "This might take a while if you already have layers; run top to monitor postgresql activity."
echo "the log is at /usr/share/tomcat/webapps/geoserver/data/logs/geoserver.log"
