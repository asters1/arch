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
# author:   Asters
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
#设置pacman源
function_Set_pacman(){
	echo "# China
Server = http://mirrors.163.com/archlinux/\$repo/os/\$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch
Server = https://mirrors.zju.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.cpu.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.dgut.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.neusoft.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirror.lzu.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirror.redrock.team/archlinux/\$repo/os/\$arch
" > /etc/pacman.d/mirrorlist

echo "
[archlinuxcn]
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
" >> /etc/pacman.conf
pacman -Syy
}
function_Init_Arch(){
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG = en_US.UTF-8" >> /etc/locale.conf
}

function_Init_User(){
	echo -e -n "${Msg_Info}Please Input ${Font_Blue}root${Font_Suffix}${Font_White} Password:${Font_suffix}:\n"
passwd

	echo -e -n "${Msg_Info}Please Input ${Font_Blue}Add Username${Font_Suffix}${Font_White} (default:asters):${Font_suffix}";read Username
	if [ "${Username}" = "" ];then
		Username=asters
	fi
	echo -e -n "${Msg_Info}Please Input ${Font_Blue}${Username}${Font_Suffix}${Font_White} Password:${Font_suffix}\n"
useradd -m -g users -G wheel -s /bin/bash ${Username}
	passwd ${Username}
echo "export LANG = en_US.UTF-8" >> /home/${Username}/.xprofile
echo "export LANG=zh_CN.UTF-8" >> /home/${Username}/.xprofile
echo "export LC_ALL=zh_CN.UTF-8" >> /home/${Username}/.xprofile
echo "export GTK_IM_MODULE=fcitx" >> /home/${Username}/.xprofile
echo "export QT_IM_MODULE=fcitx" >> /home/${Username}/.xprofile
echo 'export XMODIFIERS="@im=fcitx"' >> /home/${Username}/.xprofile
chmod +w /etc/sudoers
}
function_Init_Grub(){
pacman -S --needed --noconfirm grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
}
function_Install_Software(){
pacman -S --needed --noconfirm networkmanager dhcpcd net-tools zsh openssh neovim yay alacritty ranger xorg xorg-xinit noto-fonts-cjk adobe-source-code-pro-fonts fcitx-configtool nitrogen
if [ -f "/bin/vim" ];then
	rm /bin/vim
fi
ln -s /bin/nvim /bin/vim
}
function_System_emable(){
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable sshd
systemctl enable sddm 
}
function_Install_KDE(){
pacman -S --needed --noconfirm xorg ttf-dejavu wqy-microhei plasma kde-applications sddm sddm-kcm alsa-utils pulseaudio pulseaudio-alsa fcitx-rime fcitx-im kcm-fcitx net-tools dhcpcd
}


echo -e "
${Font_White}############${Font_suffix}${Font_Blue}INSTALL ARCH MENU${Font_suffix}${Font_White}####################${Font_suffix}"
echo -e "${Msg_Info}Select the function to use: "
echo -e " 1. Check Network  \n 2. init arch \n 3. Set Mirrorlist \n 4. set adduser passwd \n 5. Init Grub \n 6. Install Software \n 7. Install KDE \n 8. Systemcti emable \n 9. One Click Install Arch \n 0. Exit \n";read -p "Input Number:" Function

if [ "${Function}" = "1" ];then
	function_Check_Network
elif [ "${Function}" = "2" ];then
	function_Init_Arch
elif [ "${Function}" = "3" ];then
	function_Set_pacman
elif [ "${Function}" = "4" ];then
	function_Init_User
elif [ "${Function}" = "5" ];then
	function_Init_Grub
elif [ "${Function}" = "6" ];then
	function_Install_Software
elif [ "${Function}" = "7" ];then
	function_Install_KDE
elif [ "${Function}" = "8" ];then
	function_System_emable
elif [ "${Function}" = "9" ];then
	function_Check_Network
	function_Set_pacman
	function_Init_User
	function_Init_Arch
	function_Init_Grub
	function_Install_Software
	function_Install_KDE
	function_System_emable
else
	exit 0
fi





