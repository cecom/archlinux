# DEBIAN Install

1. via usb iso installieren, die hybrid variante.
2. sudo apt install networkmanager git
3. linux-firmware:
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
4. kernel 5.8 aus backport einspielen und rebooten
5. `nmtui` aufrufen und wlan einrichten

