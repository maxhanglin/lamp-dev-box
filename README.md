# A Virtual Machine for LAMP Development

## Introduction

This project automates the setup of a LAMP development environment for working on your projects. Use this virtual machine to work on a pull request with everything ready to hack and run. This project is based on the awesome [rails-dev-box](https://github.com/rails/rails-dev-box) vagrant box.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Vagrant::Hostsupdater Plugin](https://github.com/cogitatio/vagrant-hostsupdater)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/maxi-hanglin/lamp-dev-box.git
    host $ cd lamp-dev-box
    host $ vagrant plugin install vagrant-hostsupdater
    host $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-36-generic i686)
    ...
    vagrant@lamp-dev-box:~$

Port 8888 in the host computer is forwarded to port 80 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8888 in the host computer. A named host was also added on _www.local.dev_ to make it easy to access to the VM.

## What's In The Box

* Ubuntu Linux 14.04 LTS

* Development tools

* Git

* Apache2

* PHP5

* MySQL

## Recommended Workflow

The recommended workflow is

* Edit in the host computer (using the _/public_ folder included).

* Run tests within the virtual machine.

Just clone your project into the lamp-dev-box/public directory on the host computer:

    host $ ls
    bootstrap.sh public README.md Vagrantfile
    cd public
    host $ git clone git@github.com:<your username>/yourproject.git

Vagrant mounts that directory as _/vagrant/public_ within the virtual machine:

    vagrant@lamp-dev-box:~$ ls /vagrant/public
    yourproject

We are ready to go to edit in the host, and test in the virtual machine.

This workflow is convenient because in the host computer you normally have your editor of choice fine-tuned, Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `exit` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.

## Contact

For more information contact Maximiliano Hanglin at mhanglin@gmail.com
