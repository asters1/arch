#!/bin/bash
#ping baidu.com

setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen


echo "LANG = en_US.UTF-8" >> /etc/locale.conf


echo "asters" >> /etc/hostname

echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.0.1       asters.localdomain asters" >> /etc/hosts
echo "199.232.69.194 github.global.ssl.fastly.net" >> /etc/hosts

echo "140.82.114.4 github.com" >> /etc/hosts

echo "199.232.68.133 raw.githubusercontent.com" >> /etc/hosts

echo "199.232.68.133 raw.github.com" >> /etc/hosts

clear
echo "更改root密码"
passwd



pacman -S vim grub efibootmgr intel-ucode os-prober amd-ucode 

mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg


uname -m


grub-install --target=x86_64-efi --efi-directory=/boot


pacman -S wpa_supplicant dhcpcd


pacman -Syy
pacman -S xrog
#中文字体
pacman -S ttf-dejavu wqy-microhei
#添加普通用户
useradd -m -g users -G wheel -s /bin/bash asters

clear
echo "更改asters密码"
passwd asters   
提权
pacman -S sudo
ln -s /usr/bin/vim /usr/bin/vi



#安装KDE

pacman -S plasma kde-applications

#安装图形登陆界面
pacman -S sddm sddm-kcm
#开机自启sddm
systemctl enable sddm
#安装网络管理和相关工具
pacman -S networkmanager net-tools
#开机自启
systemctl enable NeteorkManager
systemctl enable dhcpcd
#安装声音
pacman -S alsa-utils pulseaudio pulseaudio-alsa
#安装中文输入法
pacman -S fcitx-rime fcitx-im kcm-fcitx
编辑
vim /home/asters/.xprofile
echo "export LANG=zh_CN.UTF-8" >> /home/asters/.xprofile    

echo "export LC_ALL=zh_CN.UTF-8" >> /home/asters/.xprofile    

echo "export GTK_IM_MODULE=fcitx " >> /home/asters/.xprofile    

echo "export QT_IM_MODULE=fcitx" >> /home/asters/.xprofile    

echo "export XMODIFIERS="@im=fcitx"" >> /home/asters/.xprofile    

echo "将#%wheel ALL=(ALL) 的#删除掉"

visudo 
