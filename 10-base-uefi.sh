#!/bin/bash

create_pass () {
    echo $1
    while [ true ]
    do
        echo "Please enter a password for $1 :"
        read -sp 'Password: ' passvar1
        echo "Please re-enter the password for $1 :"
        read -sp 'Password: ' passvar2


        
        if [ -z $passvar1 ] || [ -z $passvar2 ]
        then
            echo "Password cannot be blank"
            echo ""
            echo ""
            echo ""
            
        elif [ $passvar1 == $passvar2 ]
        then
            echo $1:$rpassvar | chpasswd
            break
        
        else
            echo "passwords did not match."
            echo ""
            echo ""
            echo ""
        fi
    done
}

ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "beowolf" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 beowolf.localdomain beowolf" >> /etc/hosts

create_pass root

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

reflector -f 10 --country 'United States' --protocol https --sort rate --save /etc/pacman.d/mirrorlist 

pacman -S --noconfirm efibootmgr dialog iwd mtools dosfstools reflector base-devel linux-headers xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils bash-completion openssh rsync flatpak os-prober ntfs-3g udiskie terminus-font networkmanager

pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH --removable
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
#systemctl enable firewalld

useradd -m kmccuddy

create_pass kmccuddy

usermod -aG wheel -s /bin/bash kmccuddy

echo "kmccuddy ALL=(ALL) ALL" >> /etc/sudoers.d/kmccuddy

# placeholder for code to disable root


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
