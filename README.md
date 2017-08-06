# Shinit
Shinji, run the services!

![](https://pbs.twimg.com/media/DECgGTrWsAArEkm.jpg)

## What?
A init and service manager in [Rakudo Perl 6](https://perl6.org).

## Why?
I want to learn how init systems work and also want to be able to run a systemd
based distro without translating service files.

## What are the goals?

1. Run `shinit` on a runit based system with minimal amount of changes (default
   `runit` stages start runit service dirs)
2. `shinit` should be able to run systemd services files without any changes
3. `shinit` should be able to replace systemd with minimal amount of changes
   (stage scripts should be written)
4. Develop own service definition with great dependency management

## Where are we now?
* `shinit` can successfully replace `runit` as init system without changes, but
  since in the stage scripts `runit` is launched to manage services it's a bit
  of cheating, also `reboot`, `poweroff` and `halt` don't work without `-f`.

## What are some problems still unsolved?

* `shinit` and `perl6` should be on the root filesystem if we want to boot,
  possible solutions are
 * make little sqaushfs with needed libraries
 * force `MoarVM` somehow to compile to a static binary (iirc there is no
   functionality for that yet)

## How do you run or test this?
The easiest way currently is to install [VoidLinux](https://voidlinux.eu)
(headless) into a VM, and install Rakudo Perl 6, clone this repo and add a new
entry to grub with the kernel command line argument `init=[path to shinit
clone]/bin/init`

e.g. run the following in a VoidLinux VM (this is still untested, poke me if
you need help)

```
xbps-install -Syu # update installed packages
xbps-install -Sy perl gcc make git wget curl # install needed build things
git clone https://github.com/rakudo/rakudo.git # get Rakudo Perl 6
cd rakudo
git checkout tags/2017.07
perl Configure.pl --gen-moar --gen-nqp --backends=moar --prefix /usr
make
make install
cd /opt
git clone https://github.com/the-eater/shinit.git
chmod +x /opt/shinit/bin/init
```

Now you only need to edit `/etc/grub.d/10_linux` so it makes an extra entry
with the argument `init=/opt/shinit/bin/init`


I'm sorry
