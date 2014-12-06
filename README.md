# Hands On Trove
Database as a Service in OpenStack

## Prerequisites

To run this tutorial, you'll need:

* a machine running VirtualBox (4.2 or better) and Vagrant (1.2 or better)
* at least 8G of RAM (more is better)
* an SSD (otherwise, random I/O is just going to kill your machine)

For initially setting up the virtual machine, you'll also need

* a working internet connection,
* time and patience.

## Getting started

Edit the `Vagrantfile` to increase the RAM allocation, if you can:

    # Set the amount of RAM you want to allocate to the VM. The default
    # (3G) is the minimum, set this to higher if you have RAM to spare
    ram = 4096

Then bring up your VM:

    vagrant up

## Checking the system

Once `vagrant up` completes you can log into your box:

    vagrant ssh

## Suspending and resuming the machine

You can subsequently save your machine state with

    vagrant suspend

And when needed, wake it up again with

    vagrant resume
