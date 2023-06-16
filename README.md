# Arch-install
Arch installation and its periphery. Also the programs I use

Also use [Archlinux.org](https://wiki.archlinux.org/title/installation_guide_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))

# Before we start

- Write the Arch Linux ISO into a USB drive. There are several tools available for this, like dd, balenaEtcher, Rufus, or my personal favorite, Ventoy.
- Disable Secure Boot in the UEFI.

- Boot from the USB drive.

The default console layout is US. You can view the list of available layouts using the command:

`ls /usr/share/kbd/keymaps/**/*.map.gz`

Select a layout, pass the name of the appropriate loadkeys(1) file, without the full path and extension. For example, to select the Russian layout, run the command:

`loadkeys **`

where ** - insert your language

# Internet connection

Time to connect to the Internet:

Ethernet: Connect the cable.
    Wi-Fi: Connect to a wireless network using [iwctl](https://wiki.archlinux.org/title/Iwd_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#iwctl).
    Mobile Broadband Modem: Connect to a mobile network using the [mmcli](https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager) utility.

Set up network connections:

DHCP: Setting dynamic IP and DNS server address (using systemd-networkd and systemd-resolved) should work automatically for wired and wireless network interfaces.
Static IP: See Network Setup#Static IP Address.

The connection can be checked using the ping utility:

# ping archlinux.org
