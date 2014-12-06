# Hands On Trove
Database as a Service in OpenStack

LinuxCon Europe, Düsseldorf, Oct 13, 2014

Florian Haas, hastexo

## Prerequisites

To run this tutorial, you'll need:

* a machine running VirtualBox (4.2 or better) and Vagrant (1.2 or better)
* at least 3G of RAM (more is better)
* an SSD (otherwise, random I/O is just going to kill your machine)

For initially setting up the virtual machine, you'll also need

* a working internet connection,
* time and patience.

## Getting started

Clone this repo:

    git clone git://github.com/fghaas/lceu2014-trove

Update the [submodule](http://git-scm.com/book/en/Git-Tools-Submodules):

    git submodule init
    git submodule update

Edit the `Vagrantfile` to increase the RAM allocation, if you can:

    # Set the amount of RAM you want to allocate to the VM. The default
    # (3G) is the minimum, set this to higher if you have RAM to spare
    ram = 4096

Then bring up your VM:

    vagrant up

After that, you can leave your machine alone for about an hour. Have
some coffee, prepare a meal, take your kids for a bike ride, whatever
works for you. There will be **a lot** of software to install, but at
the end you'll have an OpenStack cloud in a box, plus a working Trove
service.

## Checking the system

Once `vagrant up` completes (there's a **Done!** message at the very
end), you can log into your box:

    vagrant ssh

And you should see a single pre-configured datastore:

    vagrant@devstack:~$ trove datastore-list
    +--------------------------------------+-------+
    |                  id                  |  name |
    +--------------------------------------+-------+
    | 1a525112-18a0-4da0-9d24-838e26603a7a | mysql |
    +--------------------------------------+-------+

Note: your ID will be different, the name will not.

Also, while you're able to query the list of configured database
instances, that list will be empty:

    vagrant@devstack:~$ trove list
    +----+------+-----------+-------------------+--------+-----------+------+
    | id | name | datastore | datastore_version | status | flavor_id | size |
    +----+------+-----------+-------------------+--------+-----------+------+
    +----+------+-----------+-------------------+--------+-----------+------+

## Creating an instance

When you're that far, you're ready for experimenting with Trove.
You can now create a database using the provided script:

    vagrant@devstack:~$ ./trove-create.sh

This will take another 5-10 minutes and create a Trove instance for
you.

Creating databases, users, and configuration groups for your Trove
instance is left as an exercise for the reader. Have fun!

## Suspending and resuming the machine

You can subsequently save your machine state with

    vagrant suspend

And when needed, wake it up again with

    vagrant resume

## Questions?

Feel free to
[file an issue](https://github.com/fghaas/lceu2014-trove/issues)
in this repo if you need help.
