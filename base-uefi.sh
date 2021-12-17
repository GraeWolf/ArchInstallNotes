#!/bin/bash

ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "beowolf" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 beowolf.localdomain beowolf" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S efibootmgr dialog iwd mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils cups alsa-utils bash-completion openssh rsync acpi acpi_call virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

#grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
#grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m kmccuddy
read -sp 'Password: ' passvar
echo kmccuddy:$passvar | chpasswd
usermod -aG wheel,libvirt -s /bin/bash kmccuddy

#echo "kmccuddy ALL=(ALL) ALL" >> /etc/sudoers.d/kmccuddy


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

