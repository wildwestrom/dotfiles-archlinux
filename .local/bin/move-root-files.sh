#!/bin/sh

sudo rsync -vr ~/.root-configs/* /
sudo chown -vR greeter /etc/greetd
