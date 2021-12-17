# Arch Install Notes

## Connect to the Internet

  `# pacman -S iwd`

  `# iwctl --passphrase sfPass station wlan0 connect Starfleet`
  `# dhcpcd`

## Update the system clock

  `# timedatectl set-ntp true`

## Format Drive Partitions
  ```
Create Efi partition
  # mkfs.fat -F 32 /dev/sdx1

Create Swap
  # mkswap /dev/sdx2  16G
  # swapon /dev/sdx2

Make root 500G
  # mkfs.ext4 /dev/sdx3 -L Arch

Create Data Partition
  # mkfs.ext4 /dev/sdx4 rest of disk space
  ```

## Mount File Systems

  ```
Mount root partition
  # mount /dev/sdx3 /mnt

Create mount point and mount efi partition
  # mkdir -p /mnt/boot
  # mount /dev/sdx1 /mnt/boot
  ```

## Install Essential Packages

  `# pacstrap /mnt base base-devel linux linux-firmware git nano man `


## Configure The System

  ### Fstab

    # genfstab -U /mnt >> /mnt/etc/fstab

  ### Chroot

    # arch-chroot /mnt
    # git clone https://github.com/GraeWolf/ArchInstallNotes.git

    # cd ArchInstallNotes
    # chmod +x base-efi.sh
    # ./base-efi.sh


  ### Misc
    # nano /etc/pacman.conf
    uncomment multilib section
    # pacman -Syu
    
  ### Systemd boot

  Will need to add the video driver to /etc/mkinitcpio.conf
    MODULES=(nvidia)

  Then run command:
  ```
    # mkinitcpio -p linux
  ```
  
  Then run command:
    ```
    # bootctl install
    # cd /boot/loader/
    ```
  Edit loader.conf
    timeout 5
    console-mode max
    default arch.conf
  
    `#cd /boot/loader/entries`

  Create arch.conf file
   ```
   # nano arch.conf

      title GraeArch
      linux /vmlinuz-linux
      initrd /intel-ucode.img
      initrd /initramfs-linux.img
      options root="LABEL=arch" rw
  ```
# Reboot
  ```
  # exit
  # umount -R /mnt
  # reboot
  ```

# Setup New System
  run setup.sh
  ```
  $ git clone https://aur.archlinux.org/yay.git
  $ cd yay
  $ makepkg -si
  $ sudo systemctl enable lightdm.service
  $ mkdir -p ~/.config/openbox
  $ cp -a /etc/xdg/openbox/. ~/.config/openbox/
