#!/bin/bash   
#Author:                                                                                    #Author:
#Created Time:

#黑色
black='\033[30m'
#红色
red='\033[31m'
#绿色
green='\033[32m'
#黄色
yellow='\033[33m'
#蓝色
blue='\033[34m'
#紫色
violet='\033[35m'
#天蓝色
sky_blue='\033[36m'
#白色
white='\033[37m'

#颜色结尾
colorend='\033[0m'



clear

echo -e "${violet}脚本将进行分区操作${colorend}"



#/dev/sda1 boot分区
#/dev/sda2 交换分区
#/dev/sda3 主分区
clear
echo -e "${violet}格式化各个分区${colorend}"


mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
swapon

echo -e "${violet}配置源${colorend}"
sed -i "1iServer = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist


echo -e "${violet}挂载${colorend}"
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

echo -e "${violet}安装arch${colorend}"

pacstrap /mnt base linux linux-firmware base-devel

echo -e "${violet}生成fstab文件${colorend}"
genfstab -U /mnt >> /mnt/etc/fstab
