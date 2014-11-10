node 'example.vbox.net' {

#    apt::
    class { 'nginx': }
    nginx::resource::upstream { 'etherpad_backend':
      members => [
        'localhost:8080',
      ],
    }
    nginx::resource::vhost { 'etherpad.vbox.net':
      proxy => 'http://etherpad_backend',
      # rewrite_to_https       => true,
      # listen_port            => 80,
      # ssl                    => true,
      # ssl_cert               => '/etc/nginx/ssl/server.crt',
      # ssl_key                => '/etc/nginx/ssl/server.key',
      # ssl_port               => 443,
    }

    class { '::mysql::server':
      root_password    => 'strongpassword',
      override_options => { 'mysqld' => { 'max_connections' => '1024' } }
    } ->
    mysql_user { 'etherpad@localhost':
      ensure                   => 'present',
      password_hash            => '*FF3A662B092BC4F19D21710766AFE7F3664F3FDD',
    } ->
    mysql_database { 'etherpad':
      ensure  => 'present',
      charset => 'utf8',
      collate => 'utf8_unicode_ci',
    } ->
    mysql_grant { 'etherpad@localhost/*.*':
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => '*.*',
      user       => 'etherpad@localhost',
    } ->
    class { 'etherpad':
      etherpad_title         => 'Welcome to DBU DevOps Etherpad',
      etherpad_port          =>  8080,
      etherpad_database_type => 'mysql',
      etherpad_database_name => 'etherpad',
      etherpad_database_user => 'etherpad',
      etherpad_database_password => 'etherpad',
      etherpad_users => {
        admin => {
            password => "test1234",
            is_admin => "true"
           }
          }
    }
}

node 'puppetmaster.vbox.net' {

}
