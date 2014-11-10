# vagrant-skel #

Simple Vagrant environment to bootstrap a puppetmaster quickly.

## About ##

This is a simple skel project that allows to set up a fast Vagrant environment, based
on Ubuntu 12.04 and up. This includes a puppetmaster in the latest version of puppet
and one additional VM.

## How to use ##

etherpad version:
To run this you need as well librarian-puppet in version 1.0.1. 

Just run a simple:

	librarian-puppet install
    vagrant up

### Getting the latest changes to the VM:

    vagrant ssh example -c 'sudo puppet agent -v -t'

## Caveats ##

I apply a small hack to save some bandwidth, the `/var/cache/apt/archives/` will
be mount in the local folder `tmp/`. Sometimes this causes issues with the installation
of packages. Emptying the `tmp/` folder or disabling the `synced_folder` inside of the `Vagrantfile` 
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

