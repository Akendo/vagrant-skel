#!/usr/bin/env bash

HOSTNAME=$(hostname -f)

function run_puppet_agent (){
  puppet agent -v -t
}

function connect_to_puppetmaster () {
  cat << EOF > /etc/puppet/puppet.conf
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY

[agent]
certname = $HOSTNAME
server = puppetmaster.vbox.net
}

function puppetlabs_repo () {
  wget -q -c http://apt.puppetlabs.com/puppetlabs-release-precise.deb
  dpkg -i puppetlabs-release-precise.deb
}

function apt_update () {
  apt-get update
}

function apt_install_puppetmaster {
  apt-get install -y \
  puppetmaster=3.2.4-1puppetlabs1\
  puppetmaster-common=3.2.4-1puppetlabs1 \
  puppet-common=3.2.4-1puppetlabs1 \
  puppet=3.2.4-1puppetlabs1 \
  puppetdb=1.4.0-1puppetlabs1 \
  puppetdb-terminus=1.4.0-1puppetlabs1 \

  apt-get install -y git git-man liberror-perl patch
}

function apt_install_puppetagent {
  apt-get install -y puppet=3.2.4-1puppetlabs1 puppet-common=3.2.4-1puppetlabs1
}

function setup_puppetmaster {

  cat  << EOF > /etc/puppet/puppet.conf
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY
storeconfigs = true
storeconfigs_backend = puppetdb
autosign = true

[agent]
certname = $HOSTNAME
server = $HOSTNAME
EOF

  cat << EOF > /etc/puppet/puppetdb.conf
[main]
server = $HOSTNAME
port = 8081
EOF


  service puppetdb restart
  service puppetmaster restart
}

puppetlabs_repo
apt_update

if [ $HOSTNAME = 'puppetmaster.vbox.net' ]; then
  apt_install_puppetmaster
  setup_puppetmaster
else
  apt_install_puppetagent
  connect_to_puppetmaster
fi;
sleep 20
run_puppet_agent


exit 0
