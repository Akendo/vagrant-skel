node 'example.vbox.net' {
    file {'/opt/teamspeak3':
      ensure => directory
    }
    ->
    class { 'docker':
      version => '1.3.1',
    }
    ->
    docker::image { 'devalx/docker-teamspeak3':
    }
    ->
    docker::run { 'ts3':
      image    => 'devalx/docker-teamspeak3',
      use_name => true,
      volumes  => '/opt/teamspeak3:/teamspeak3',
      ports    => ['9987:9987/udp',],
    }

}

node 'puppetmaster.vbox.net' {

}
