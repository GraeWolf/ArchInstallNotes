# Arch Install Notes

This is a kind of a install cheat sheet for me to install an Arch system.  The scripts are borrowed from EF Linux and Arco Linux.  These work for me and my work flow, I sometimes try to update them or make them better, but the edits are few and far between.  Anyone is happy to use them if they find them useful, but I am not a guru so use them at your own risk.


## Connect to the Internet

  `# pacman -S iwd`

  `# iwctl --passphrase password station wlan0 connect SSID`
  
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
    # chmod +x *.sh
	# nvim /etc/pacman.conf
		uncomment multilib section
	# pacman -Syu
    # ./10-base-efi.sh

# Reboot
  ```
  # exit
  # umount -R /mnt
  # reboot
  ```

# Setup New System
Once rebooted and in the new system and logged in as normal user. You will then need to clone the ArchInstallNotes into the use directory.

```
$ git clone https://github.com/GraeWolf/ArchInstallNotes.git
$ cd ArchInstallNotes
$ chmod +x *.sh
```

Now you can run the rest of the scripts if you so desire.  If you do run the rest of the scripts you will need to reboot once again for all changes made to take effect.
