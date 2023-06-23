# Arch-install(Installing Arch Linux)
Arch installation and its periphery. Also the programs I use

When installing, also refer to [Archlinux.org](https://wiki.archlinux.org/title/installation_guide_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))

## Before start

- Write the Arch Linux ISO into a USB drive. There are several tools available for this, like dd, balenaEtcher, Rufus, or my personal favorite, Rufus.
- Disable Secure Boot in the UEFI.

- Boot from the USB drive.

The default console layout is US. You can view the list of available layouts using the command:

```
ls /usr/share/kbd/keymaps/**/*.map.gz
```

Select a layout, pass the name of the appropriate loadkeys(1) file, without the full path and extension. For example, to select the Russian layout, run the command:

`loadkeys **`

where ** - insert your language

## Internet connection

Time to connect to the Internet:

Ethernet: Connect the cable.
    Wi-Fi: Connect to a wireless network using [iwctl](https://wiki.archlinux.org/title/Iwd_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#iwctl).
    Mobile Broadband Modem: Connect to a mobile network using the [mmcli](https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager) utility.

Set up network connections:

[DHCP](https://wiki.archlinux.org/title/Network_configuration_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#DHCP): Setting dynamic IP and DNS server address (using [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)) and [systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))) should work automatically for wired and wireless network interfaces.
Static IP: [See Network Setup#Static IP Address](https://wiki.archlinux.org/title/%D0%9D%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B0_%D1%81%D0%B5%D1%82%D0%B8#%D0%A1%D1%82%D0%B0%D1%82%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_IP-%D0%B0%D0%B4%D1%80%D0%B5%D1%81).

The connection can be checked using the [ping](https://wiki.archlinux.org/title/Network_configuration_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#Ping) utility:

```
ping archlinux.org
```

## Time-date


- Now that we have an Internet connection, do `timedatectl set-ntp true` to update the live system clock.
- You can then do `timedatectl status` to check the time (in the UTC timezone).

## Disk partition

Onto partitioning the disk. This part is quite subjective, and can vary wildely depending on your needs. Consider reading more about this process instead of blindly following my instructions [here](https://wiki.archlinux.org/title/Arch_boot_process).

I'll be using a single disk, creating the necessary partitions (ESP and root) and a SWAP partition. You can choose to simply not have a SWAP partition, or instead have a SWAP file. If you want a SWAP file, check the [Arch Wiki](https://wiki.archlinux.org/title/Swap#Swap_file). You'll need a SWAP if you want hibernation.

- Do `lsblk` and identify your disk. Most of the time your disk will be identified as `sda`. If you're using NVMe, it'll most likely look something like `nvme0n1`. I'll use `nvme0n1` for the example.
- Do `gdisk /dev/nvme0n1`, and then the commands `o` and `w`. They will "erase" everything in the disk and create a new partition table.
- Do cgdisk /dev/nvme0n1:
  - create the ESP partition (NECESSARY):
    - First sector is the default one.
    - Size is `1G`.
    - Type is `ef00`.
    - Name is `ESP`.
  - Create the SWAP partition (OPTIONAL):
    - First sector is the default one.
    - Size is complicated. If unsure, use the amount of RAM (e.g. if you have 4GB of RAM, size is 4G).
    - Type is `8200`.
    - Name is `SWAP`.
  - Create the / (root) partition (NECESSARY):
    - First sector is the default one.
    - Size is the default one.
    - Type is the default one.
    - Name is `ROOT`.
    - Hit `[Write]`, and then `[Quit]`.

- Now to format the partitions:
  - Do `mkfs.fat -F 32 -n ESP /dev/disk/by-partlabel/ESP` to format the **ESP**.
  - Do `mkswap -L SWAP /dev/disk/by-partlabel/SWAP` to format the **SWAP** partition.
  - Do `mkfs.btrfs -L ROOT /dev/disk/by-partlabel/ROOT` to format the **/ (root)** partition.

- Activate the **SWAP** partition with 
```
swapon /dev/disk/by-partlabel/SWAP.
```
- Mount the / (root) partition with
```
mount /dev/disk/by-partlabel/ROOT /mnt.
```
Mount the ESP with 
```
mount --mkdir /dev/disk/by-partlabel/ESP /mnt/boot.
```
- Do `lsblk /dev/nvme0n1` to verify everything is correct. If you did exactly what I did, you should have something like this:
- ESP (nvme0n1p1 @ /mnt/boot)
- SWAP (nvme0n1p2 @ [SWAP])
- / (root) (nvme0n1p3 @ /mnt)

## Installation

- Do `pacman-key --refresh-keys` to ensure the keyring is up to date.
- Do
```
pacstrap -i /mnt base{,-devel} btrfs-progs dkms linux{{,-lts}{,-headers},-firmware}
```

- Create the fstab file with 
```
genfstab -U /mnt >> /mnt/etc/fstab.
```

## Basic system configuration


- Do `arch-chroot /mnt` to go into your system.
- Install some important packages with
```
pacman -S dhclient dhcpcd git man-{db,pages} networkmanager openssh polkit vi neovim zsh{,-autosuggestions,completions,history-substring-search,syntax-highlighting}}.

```
I use neovim to edit/write files, you can install yours like nano, vim and etc

- Edit the file `/etc/NetworkManager/conf.d/dhcp.conf` to contain the following:
```
[main]
dhcp=dhclient
```
- Edit the file `/etc/NetworkManager/conf.d/dns.conf` to contain the following:
```
[main]
dns=systemd-resolved
```
## Time

Do `ln -svf /usr/share/zoneinfo/$(tzselect | tail -1) /etc/localtime` to set your timezone.

Then, do `hwclock -w` to update the hardware clock.

You can do `hwclock -r` to see the current time stored by the hardware clock. You'll notice that it takes the timezone into account.

If you use a dual boot like me, then in order to not lose time when switching systems from linux to windows, use:
```
 sudo timedatectl set-local-rtc 1 --adjust-system-clock
```

## Locale, font

- Open the file `/etc/locale.gen.` Uncomment the `en_US.UTF-8` and any other locales you want to use.
- Do `locale-gen` to generate the uncommented locales.
- Do `echo LANG=LOCALE > /etc/locale.conf`, **LOCALE** being your preferred locale from the ones you just generated.
- Do `echo KEYMAP=KEYMAP > /etc/vconsole.conf`, **KEYMAP** being the name of the keymap you're using (set when you used the loadkeys command earlier).
- Do `echo FONT=YOURFONT >> /etc/vconsole.conf`. **YORUFONT** being the name of the  font. You can find all fonts available in /usr/share/kbd/consolefonts.


## Host

- Do `echo HOSTNAME > /etc/hostname`, **HOSTNAME** being the name you want your system to have.
- The hostname must be compatible with the following regex expression: `^(:?[0-9a-zA-Z][0-9a-zA-Z-]{0,61}[0-9a-zA-Z]|[0-9a-zA-Z]{1,63})$`.
- You can click [here](https://regexr.com/7fuv3) and put the hostname you want your computer to have in the text field to see if you can actually use it.
- Edit the file `/etc/hosts` to contain the following:
```
# Static table lookup for hostnames.
# See hosts(5) for details.

127.0.0.1 localhost.localdomain localhost localhost-ipv4
::1       localhost.localdomain localhost localhost-ipv6
127.0.0.1 HOSTNAME.localdomain  HOSTNAME  HOSTNAME-ipv4
::1       HOSTNAME.localdomain  HOSTNAME  HOSTNAME-ipv6
```

**HOSTNAME** being the hostname you chose in the previous command.

______

- Enable some services with `systemctl enable sshd NetworkManager systemd-resolved`.
- If you have an SSD, do `systemctl enable fstrim.timer`.
- Edit the file `/etc/mkinitcpio.conf` and change `udev` to `systemd` in the `HOOKS` list.
- Update the initramfs by doing `mkinitcpio -P`.
- Do `passwd` to give the `root` user a password

## Microcode updater

Install the microcode updater:
- If you're using an Intel CPU, do
```
pacman -S intel-ucode.
```
- If you're using an AMD CPU, do
```
pacman -S amd-ucode.
```


## Bootloader

I use rEFInd as the bootloader, you can choose another one. You can view them [here](https://wiki.archlinux.org/title/Arch_boot_process#Boot_loader). And here I will show you how to install rEFInd. Let's start.



- Do
```
pacman -S refind.
```
- Then do 
```
refind-install.
```
Do `mkdir /etc/pacman.d/hooks` and edit the file `/etc/pacman.d/hooks/refind.hook` to contain the following:
```
[Trigger]
Operation=Upgrade
Type=Package
Target=refind

[Action]
Description=Updating rEFInd in the ESP...
When=PostTransaction
Exec=/usr/bin/refind-install
```
- Verify the hook is working by doing
``` 
pacman -Syu refind | grep upgrading.
```
- You should see evidence that the hook detects an already existing installation of rEFInd and upgrades it.
- Edit the file `/boot/EFI/refind/refind.conf`:
- Change `timeout 20` to `timeout 5`.
- Uncomment the line `#fold_linux_kernels false`.
- Uncomment the line `#extra_kernel_version_strings linux-lts,linux`.
- Do
```
echo root=UUID=$(blkid -s UUID -o value /dev/disk/by-partlabel/ROOT) > /boot/refind_linux.conf.
```
- If you make **SWAP**, do
```
echo resume=UUID=$(blkid -s UUID -o value /dev/disk/by-partlabel/SWAP) >> /boot/refind_linux.conf.
```
- The only differences between these two commands is the beginning (root and resume), the partition (ROOT and SWAP), and the output redirection operator (> and >>).
- Finally, edit the file `/boot/refind_linux.conf` to contain the following:
```
"Arch Linux"       "root=UUID=XXXX resume=UUID=YYYY rw initrd=UCODE.img initrd=initramfs-%v.img EXTRA"
"Arch Linux (CLI)" "root=UUID=XXXX resume=UUID=YYYY rw initrd=UCODE.img initrd=initramfs-%v.img systemd.unit=multi-user.target EXTRA"
```
**XXXX** and **YYYY** being the UUIDs that were already on the file (don't change them!). **UCODE** being the package you installed for the microcode updater(you can check them, do `ls /boot`). **EXTRA** being the extra kernel parameters you used to boot the live system.

_____

- Do `exit` and then `umount -R /mnt`.
You can now do `poweroff` or `reboot`.

## Congratulations! You've installed Arch Linux!


# Post-installation system setup
## At the end of this section, I will give a complete command with all packages so that you do not need to install individually










