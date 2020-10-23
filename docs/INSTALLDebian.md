# DEBIAN Install

1. via usb iso installieren, die hybrid variante.
1. sudo apt install networkmanager git
1. linux-firmware:
   ```sh
   git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
   cd linux-firmware/
   # firmware-amd-graphics
   sudo cp -va amdgpu/ /lib/firmware/
   # firmware-iwlwifi
   sudo cp -va iwlwifi-* /lib/firmware/ && sudo cp -va intel/ibt-* /lib/firmware/intel/
   sudo update-initramfs -u
   cd /lib/firmware/
   sudo chown -R root:root amdgpu iwlwifi-* intel/ibt-* 
   ```
1. kernel 5.8 aus backport einspielen und rebooten
1. `nmtui` aufrufen und wlan einrichten



1. XStuff: `sudo apt install xorg xinit nitrogen xmonad dmenu`
1. other stuff: `sudp apt install exa neofetch wget firefox-esr chromium xpad xclip`
1. ssh key generieren
1. x starten mit xmonad in xinitrc
1. alt+p für firefox
1. sshkey vom terminal kopieren, public key vorher markieren: "xclip -o | xclip -selection clipboard -i"
