#!/bin/bash
#set -e
###############################################################################
# Author	:	Kelly McCuddy
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
wine-staging
wine-gecko 
wine-mono
giflib 
lib32-giflib 
libpng 
lib32-libpng 
libldap 
lib32-libldap 
gnutls 
lib32-gnutls 
mpg123 
lib32-mpg123 
openal 
lib32-openal 
v4l-utils 
lib32-v4l-utils 
libpulse 
lib32-libpulse 
libgpg-error 
lib32-libgpg-error 
lib32-alsa-plugins 
alsa-lib 
lib32-alsa-lib 
libjpeg-turbo 
lib32-libjpeg-turbo 
sqlite 
lib32-sqlite 
libxcomposite 
lib32-libxcomposite 
libxinerama 
lib32-libgcrypt 
libgcrypt 
lib32-libxinerama 
ncurses 
lib32-ncurses 
opencl-icd-loader 
lib32-opencl-icd-loader 
libxslt lib32-libxslt 
libva lib32-libva gtk3 
lib32-gtk3 
gst-plugins-base-libs 
lib32-gst-plugins-base-libs 
vulkan-icd-loader 
lib32-vulkan-icd-loader
lib32-nvidia-utils
steam
lutris
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 7;echo "################################################################"
echo "You now have a very minimal functional desktop"
echo "################################################################"
echo;tput sgr0
