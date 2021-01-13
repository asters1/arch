#!/bin/bash


# Shell环境初始化
# 字体颜色定义
Font_Black="\033[30m"  
Font_Red="\033[31m" 
Font_Green="\033[32m"  
Font_Yellow="\033[33m"  
Font_Blue="\033[34m"  
Font_Purple="\033[35m"  
Font_SkyBlue="\033[36m"  
Font_White="\033[37m" 
Font_Suffix="\033[0m"
# 消息提示定义
Msg_Info="${Font_Blue}[Info] ${Font_Suffix}"
Msg_Warning="${Font_Yellow}[Warning] ${Font_Suffix}"
Msg_Error="${Font_Red}[Error] ${Font_Suffix}"
Msg_Success="${Font_Green}[Success] ${Font_Suffix}"
Msg_Fail="${Font_Red}[Failed] ${Font_Suffix}"
#初始化
arch_disk_swap=""
arch_disk_main=""
arch_disk_boot=""
arch_disk=""

# Shell脚本信息显示
clear
setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz
echo -e "${Font_Green}
#=========================================================
# Install ARCH
# 
# author:     Asters
# github:   https://github.com/asters1/arch
#========================================================

${Font_suffix}"

# 检查网络连接
function_Check_Network(){
	ping -c 1 114.114.114.114 > /dev/null 2>&1
	if [ "$?" = "0" ]; then
	echo -e "${Msg_Info}Network connection successful!"
    else
	echo -e "${Msg_Error}Network connection failed"
	exit
	fi
}
#检查分区
function_Set_Disk(){
	
	echo -n "Please Input Disk(default:/dev/sda):";read arch_disk
	echo -n "Please Input boot(default:1):";read arch_read_boot
	echo -n "Please Input swap(default:2):";read arch_read_swap
	echo -n "Please Input main(default:3):";read arch_read_main
	arch_disk_boot=${arch_disk}${arch_read_boot}
	arch_disk_swap=${arch_disk}${arch_read_swap}
	arch_disk_main=${arch_disk}${arch_read_main}

echo -e ${Msg_Info}
echo "
Disk:${arch_disk}
Boot:${arch_disk_boot}
Swap:${arch_disk_swap}
Main:${arch_disk_main}
"
	echo -e -n ${Font_Blue}Please Enter\(y/n\)${Font_suffix}:;read disk_enter
	if [ "${disk_enter}" = "y"  ];then
		mkswap ${arch_disk_swap}
		swapon ${arch_disk_swap}
		
		mkfs.ext4 ${arch_read_main}
		mount ${arch_disk_main} /mnt
		echo -e "${Font_Yellow}Need to format boot?${Font_suffix}(y/n)";read Enter_boot
		if [ "Enter_boot" = "y" ];then
			mkfs.fat -F32 ${arch_disk_boot}
		fi
		mkdir /mnt/boot
		mount ${arch_disk_boot} /mnt/boot

		
	else
		echo "failed"
	fi
	}

function_Set_pacman(){
	echo "# China
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch
Server = https://mirrors.zju.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.cpu.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.163.com/archlinux/\$repo/os/\$arch
Server = http://mirrors.dgut.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.neusoft.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirror.lzu.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirror.redrock.team/archlinux/\$repo/os/\$arch
" > /etc/pacman.d/mirrorlist
	

}
function_Install_Linux_base(){
	function_Set_pacman
	pacstrap /mnt base linux linux-firmware base-devel neovim openssh
	genfstab -U /mnt >> /mnt/etc/fstab
}

function_Init_Network(){
	arch-chroot /mnt <<EOF
echo -n -e "${Msg_Info}Please Input Hostname:(default:arch)";read Hostname
if [ "\${Hostname}" = "" ];then
Hostname="arch"	
fi
echo "\${Hostname}" > /etc/hostname
echo "
127.0.0.1       localhost.
::1             localhost
127.0.0.1       \${Hostname}.localdomain \${Hostname}
   
199.232.69.194 github.global.ssl.fastly.net
140.82.114.4 github.com
   
199.232.68.133 raw.githubusercontent.com
199.232.68.133 raw.github.com
" > /etc/hosts
exit
EOF
}
function_Init_Arch(){
	arch-chroot /mnt <<EOF
curl -o 
exit
EOF
}



echo -e "
############${Font_Blue}INSTALL ARCH MENU${Font_suffix}####################"
echo -e "${Msg_Info}Select the function to use: "
echo -e " 1. Check Network  \n 2. Set Disk \n 3. Set Mirrorlist \n 4.  One Click Install Arch \n 5. Install linux base \n 6. Init Arch \n 0. Exit \n";read -p "Input Number:" Function

if [ "${Function}" = "1" ];then
	function_Check_Network
elif [ "${Function}" = "2" ];then
	function_Set_Disk
elif [ "${Function}" = "3" ];then
	function_Set_pacman
elif [ "${Function}" = "4" ];then
	function_Set_Disk
	function_Set_pacman
	function_Install_Linux_base
	function_Init_Network
elif [ "${Function}" = "5" ];then
	function_Install_Linux_base
elif [ "${Function}" = "6" ];then
	function_Init_Network
else
	exit 0
fi





