# -*- mode: ruby -*-
# vi: set ft=ruby :

#################################################
$shell_provision = <<-SHELL

	# install tomcat
	yum install tomcat tomcat-webapps tomcat-admin-webapps -y

	# get geoserver and add it to tomcat
	wget --quiet https://downloads.sourceforge.net/project/geoserver/GeoServer/2.11.2/geoserver-2.11.2-war.zip
	yum install unzip -y
	unzip geoserver-2.11.2-war.zip geoserver.war -d /var/lib/tomcat/webapps

	# kick tomcat over to get it to deploy geoserver
	tomcat stop
	tomcat start

	# start tomcat after every reboot
	systemctl enable tomcat

	echo "giving tomcat and geoserver ten seconds to start up.."
	sleep 10
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
	config.vm.define "perf" do |perf|
		config.vm.network "forwarded_port", guest: 8080, host: 9999

		config.vm.provision "shell", inline: <<-PERF
			/vagrant/perf-test/add-lions.sh
		PERF

	end
	# ---------------------------------------------
end
#################################################
