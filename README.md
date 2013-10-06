# vagrant-skel #

Simple Vagrant environment to fast bootstrap a puppetmaster.

## About ##

This is a simple skel project that allows to get a fast Vagrant environment based
on a Ubuntu 12.04 up. Including a puppetmaster in the latest version of puppet
and one additional VM.

## How to use ##

Just run a simple:

    vagrant up

Feel free to modify everything inside of the `manifests/` folder and then
run the puppet-agent.

For example, modify the `manifests/nodes.pp` and add the `vim` package:

    node 'example.vbox.net' {
     # Make sure that the package 'vim' is installed.
     package { "vim":
       ensure => installed,
        }
    }

Getting the latest changes to the VM:

    vagrant ssh example -c 'sudo puppet agent -v -t'


## Caveats ##

I apply a small hack to save some bandwidth, the `/var/cache/apt/archives/` will
be mount in the local folder `tmp/`. Sometimes this causes issues with the installation
of packages. Delete them or even disable the `synced_folder` inside of the `Vagrantfile` 
may solve it.

## Thanks and ToDo's ##

Thanks for reviewing to Griffin Boyce.
ToDo: Introducing Travis

## License and Author ##

Author:: Alex Sla < 4k3nd0@gmail.com >

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
