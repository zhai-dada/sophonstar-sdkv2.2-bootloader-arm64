#!/bin/bash
echo "=================board setup begin================="
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update
apt-get install -y ppp ppp-dev traceroute bluez bluez-tools
echo "root:root" | chpasswd

cp -rf /rootfs/* /

rm -rf /rootfs
ls -lh

# apt-get install -y --no-install-recommends install ubuntu-gnome-desktop
# apt-get install -y lightdm
echo "=================board setup finished================="

