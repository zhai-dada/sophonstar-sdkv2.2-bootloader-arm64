#!/bin/bash
echo "=================board setup begin================="
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update
apt-get install -y ppp ppp-dev
apt-get install -y traceroute
apt-get install -y bluez bluez-tools
apt-get install -y gpsd
apt-get install -y iw
apt-get install -y lightdm
apt-get --no-install-recommends install -y ubuntu-gnome-desktop


echo "root:root" | chpasswd

cp -rf /rootfs/* /

rm -rf /rootfs
ls -lh

# apt-get install -y --no-install-recommends install ubuntu-gnome-desktop
# apt-get install -y lightdm
echo "=================board setup finished================="

