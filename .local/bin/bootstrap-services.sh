#!/bin/sh

sudo unbound-control-setup
sudo resolvconf -u
sudo systemctl enable NetworkManager greetd unbound roothints.timer

echo "Testing to see if unbound works:"
echo "  OK case:"
unbound-host -C /etc/unbound/unbound.conf -v sigok.verteiltesysteme.net
echo "  Fail case:"
unbound-host -C /etc/unbound/unbound.conf -v sigfail.verteiltesysteme.net
