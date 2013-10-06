# -*- mode: ruby -*-
# vi: set ft=ruby :
$hosts = {
  puppetmaster:   { fqdn: "puppetmaster.vbox.net",  ip: "192.168.56.200" },
  example:        { fqdn: "example.vbox.net",       ip: "192.168.56.201" },
}

def mk_etc_hosts_of name
<<-EOF
echo "
  127.0.0.1   localhost
  127.0.1.1   #{$hosts[name][:fqdn]}

  # The following lines are desirable for IPv6 capable hosts
  ::1     localhost ip6-localhost ip6-loopback
  fe00::0 ip6-localnet
  ff00::0 ip6-mcastprefix
  ff02::1 ip6-allnodes
  ff02::2 ip6-allrouters

  # all hosts:
  #{
    $hosts.map{|k,v| v[:ip]+" "+v[:fqdn]}.
      join("\n")
  }
" > /etc/hosts
EOF
end

Vagrant.configure("2") do |config|
  config.vm.define :puppetmaster do |vm_settings|
   vm_settings.vm.hostname = "puppetmaster.vbox.net"
   vm_settings.vm.box      = "precise64"
   vm_settings.vm.box_url  = "http://files.vagrantup.com/precise64.box"
   vm_settings.vm.provision :shell, inline: mk_etc_hosts_of(:puppetmaster)
   vm_settings.vm.provision :shell, path: "scripts/install.sh"

   # Small hack for development, mounting the apt cache to a local tmp folder
   # to accell the process of fetching mysql packges.
   vm_settings.vm.synced_folder "./tmp", "/var/cache/apt/archives/"
   vm_settings.vm.synced_folder "../.", "/etc/puppet/modules/exampleing"
   vm_settings.vm.synced_folder "./manifests", "/etc/puppet/manifests"
   vm_settings.vm.network "private_network", ip: "192.168.56.200"
 end
  config.vm.define :example do |vm_settings|
   vm_settings.vm.hostname = "example.vbox.net"
   vm_settings.vm.box      = "precise64"
   vm_settings.vm.box_url  = "http://files.vagrantup.com/precise64.box"
   vm_settings.vm.provision :shell, inline: mk_etc_hosts_of(:example)
   vm_settings.vm.provision :shell, path: "scripts/install.sh"
   vm_settings.vm.synced_folder "./tmp", "/var/cache/apt/archives/"
   vm_settings.vm.network "private_network", ip: "192.168.56.201"
 end
end
