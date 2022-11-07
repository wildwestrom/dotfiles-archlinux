#!/bin/sh

sudo unbound-control-setup
sudo resolvconf -u
sudo systemctl enable \
	NetworkManager \
	greetd unbound \
	roothints.timer \
	snap-sync-root.timer \
	snap-sync-home.timer \
	libvirtd

gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

echo "Testing to see if unbound works:"
echo "  OK case:"
unbound-host -C /etc/unbound/unbound.conf -v sigok.verteiltesysteme.net
echo "  Fail case:"
unbound-host -C /etc/unbound/unbound.conf -v sigfail.verteiltesysteme.net
