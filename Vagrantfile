# -*- mode: ruby -*-
# vi: set ft=ruby :

#################################################
$shell_provision = <<-SHELL

	# install tomcat
	yum install tomcat tomcat-webapps tomcat-admin-webapps -y

	# get geoserver and add it to tomcat
	echo "getting geoserver installer..."
	# wget --quiet https://downloads.sourceforge.net/project/geoserver/GeoServer/2.11.2/geoserver-2.11.2-war.zip
	cp /vagrant/deploy/downloads/geoserver-2.11.2-war.zip .

	yum install unzip -y
	unzip geoserver-2.11.2-war.zip geoserver.war -d /var/lib/tomcat/webapps

	# kick tomcat over to get it to deploy geoserver
	tomcat stop
	tomcat start

	# start tomcat after every reboot
	systemctl enable tomcat

	echo "giving tomcat and geoserver twenty seconds to start up.."
	sleep 20
	pushd /vagrant && ./upload-styles.sh && popd

SHELL
#################################################
Vagrant.configure("2") do |config|

	config.vm.box = "bento/centos-7.2"

	config.vm.provider "virtualbox" do |vb|
		vb.memory = "1024"
	end

	config.vm.provision "shell", inline: $shell_provision

	# ---------------------------------------------
	config.vm.define "test" do |test|
		config.vm.network "forwarded_port", guest: 8080, host: 8888
	end
	# ---------------------------------------------
	config.vm.define "postgis" do |perf|
		config.vm.network "forwarded_port", guest: 8080, host: 9999

		config.vm.provision "shell", inline: <<-PROVISIONEND
			yum install postgis -y
		PROVISIONEND
	end
	# ---------------------------------------------
	config.vm.define "perf" do |perf|
		config.vm.network "forwarded_port", guest: 8080, host: 9999

		config.vm.provision "shell", inline: <<-PERF
			/vagrant/perf-test/add-lions.sh 10000
		PERF
	end
	# ---------------------------------------------
	config.vm.define "perfdb" do |perf|
		config.vm.network "forwarded_port", guest: 8080, host: 7777

		config.vm.provision "shell", inline: <<-PERF
			sudo bash /vagrant/deploy/install-jdbcconfig.sh
			echo "only a few layers in this situation, so giving plugin 90 seconds to do its job..."
			sleep 80
			echo "10 seconds left..."
			sleep 10
			/vagrant/perf-test/add-lions.sh 100000
		PERF
	end
	# ---------------------------------------------
end
#################################################
