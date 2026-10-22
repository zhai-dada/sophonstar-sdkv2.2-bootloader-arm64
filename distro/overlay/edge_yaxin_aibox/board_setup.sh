#!/bin/bash

echo "=================board setup begin================="

# 1. 配置 DNS 与更新源
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update

# 2. 安装基础依赖与工具
apt-get install -y ppp ppp-dev
apt-get install -y traceroute
apt-get install -y bluez bluez-tools
apt-get install -y gpsd
apt-get install -y iw
apt-get install -y lightdm
apt-get --no-install-recommends install -y ubuntu-gnome-desktop

# 3. 设置 root 密码
echo "root:root" | chpasswd

# 4. 配置 LightDM 免密自动登录
echo "Configuring LightDM Autologin..."
mkdir -p /etc/lightdm/lightdm.conf.d/
cat > /etc/lightdm/lightdm.conf.d/50-autologin.conf << 'EOF'
[Seat:*]
autologin-user=linaro
autologin-user-timeout=0
autologin-session=ubuntu
EOF

# 5. 关闭 GNOME 休眠与待机 (底层 systemd 层面)
echo "Disabling systemd sleep targets..."
# 彻底屏蔽休眠目标（最有效防止系统自动休眠）
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

systemctl disable sophliteos.service SophonHDMI.service nginx.service

# 6. 关闭 GNOME 桌面黑屏与休眠 (桌面层面 dconf 配置)
echo "Disabling GNOME power saving and screensaver..."
mkdir -p /etc/dconf/db/local.d/
cat > /etc/dconf/db/local.d/00-disable-sleep-and-screensaver << 'EOF'
[org/gnome/settings-daemon/plugins/power]
sleep-inactive-ac-type='nothing'
sleep-inactive-battery-type='nothing'

[org/gnome/desktop/session]
idle-delay=uint32 0

[org/gnome/desktop/screensaver]
lock-enabled=false
EOF

# 更新 dconf 数据库
dconf update

# 7. 清理并拷贝 rootfs 文件
echo "Copying rootfs files..."
cp -rf /rootfs/* /

rm -rf /rootfs
ls -lh /etc

echo "=================board setup finished================="
