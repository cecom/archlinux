# Nextcloud VServer aufsetzen

## Server bestellen sofern notwendig
- Server Bestellen
  - CPX21
  - SSH Schlüssel hinzufügen
  - Ubuntu 64 Bit 20.04

## Schritt 1
- Server anklicken in der Weboberfläche: https://console.hetzner.cloud/projects/866457/servers
- Rescue -> Rescue Aktiviern und Reset  -> SSH Schlüssel wählen
- `ssh -l root <ip>`
- `vi myConfig` und folgendes hinzufügen:
```
DRIVE1 /dev/sda

HOSTNAME nextcloud
PART /boot ext3 512M
PART lvm vg0 all
LV vg0 root   /                 ext4     15G
LV vg0 swap   swap              swap     4G
LV vg0 snap   /var/snap         ext4     all
IMAGE /root/images/Ubuntu-2004-focal-64-minimal.tar.gz
```
- `installimage -c myConfig`
- `shutdown -r now`

## Schritt 2
- `ssh ... wie in FAQ`
- change your root password: `passwd` --> aus keypass das nehmen
- `apt update -y && apt upgrade -y && apt install -y dropbear-initramfs cryptsetup-initramfs lvm2 pciutils`
- public key für dropbear hinterlegen
```sh
   vi /etc/dropbear-initramfs/authorized_keys
   <paste the public key of dropbear_nextcloud_server>
```
- dropbear config
```sh
   vi /etc/dropbear-initramfs/config
   DROPBEAR_OPTIONS='-RFEsjk -p 2222 -c /bin/cryptroot-unlock'
```
- Rescue -> Rescue Aktiviern und Reset  -> SSH Schlüssel wählen

## Schritt 3
- Backup aktuelles System
```sh
   mkdir /oldroot \
   && mount /dev/mapper/vg0-root /mnt \
   && mount /dev/mapper/vg0-snap /mnt/var/snap \
   && rsync -a /mnt/ /oldroot/ \
   && umount /mnt/var/snap /mnt \
   && vgchange -a n vg0
``` 
- Platten vorbereiten für crypt
```sh
   parted /dev/sda
   print free
   rm 2
   mkpart primary 539MB -1s
   quit
```   

- `lsblk`
- `cryptsetup luksFormat /dev/sda2`
- `cryptsetup luksOpen /dev/sda2 cryptroot`
- create the physical volume, the volume group, and the partitions we want, create file systems
```sh
  pvcreate /dev/mapper/cryptroot \
  && vgcreate vg0 /dev/mapper/cryptroot \
  && lvcreate -L 4G -n swap vg0 \
  && lvcreate -L 6G -n root vg0 \
  && lvcreate -l 100%FREE -n snap vg0 \
  && mkfs.ext4 /dev/vg0/snap \
  && mkfs.ext4 /dev/vg0/root \
  && mkswap /dev/vg0/swap
```
- Zurückkopieren
```sh
   mount /dev/vg0/root /mnt \
   && mkdir -p /mnt/var/snap \
   && mount /dev/vg0/snap /mnt/var/snap \
   && rsync -a /oldroot/ /mnt/ 
```
- Ins System wechseln
```sh
  mount /dev/sda1 /mnt/boot  \
  && mount --bind /dev /mnt/dev \
  && mount --bind /sys /mnt/sys \
  && mount --bind /proc /mnt/proc \
  && mount --bind /run /mnt/run \
  && chroot /mnt
```
- Sachen setzen (interface findet man mit ifconfig raus entweder z.b. eth0 oder enp1s0)
```sh
      echo "cryptroot /dev/sda2 none luks,initramfs" >> /etc/crypttab \
   && echo "/sbin/ifdown --force enp1s0" >  /etc/rc.local \
   && echo "/sbin/ifup   --force enp1s0" >> /etc/rc.local
```
- Bei einer VM Von Hetzner funkioniert das Netzwerk in initramfs nicht(https://serverfault.com/questions/915118/ubuntu-full-disc-encryption-on-hetzner-cloud-adding-add-static-route-in-initramf), was wir machen müssen:
```sh
vi /etc/initramfs-tools/scripts/init-premount/hetznernetwork

###########################
#!/bin/sh
PREREQ=""
prereqs()
{
   echo "$PREREQ"
}

case $1 in
prereqs)
   prereqs
   exit 0
   ;;
esac

. /scripts/functions
# Begin real processing below this line
# /etc/initramfs-tools/scripts/init-premount/static-routes

configure_networking

ip route add 172.31.1.1/32 dev enp1s0
ip route add default via 172.31.1.1 dev enp1s0

exit 0
###########################

# anschließend
chmod +x /etc/initramfs-tools/scripts/init-premount/hetznernetwork
```
- Init
```sh
     update-initramfs -k all -u  \
  && update-grub \
  && grub-install /dev/sda \
  && exit
```
- unmounten and rebooten
```sh
     umount /mnt/boot /mnt/var/snap /mnt/proc /mnt/sys /mnt/dev /mnt/run \
  && umount /mnt \
  && sync \
  && shutdown -r now
```

## Schritt 4
- `ssh nextcloud-unlock`
- dropbear passphrase für private key eingeben
- crypsetup passphrase aus bitwarden eingeben
- `adduser cecom` -> pw aus Bitwarden
- `usermod -aG sudo cecom`
- `su - cecom`
- `sudo apt update`
- `sudo apt install git`
- ssh umkonfigurieren
```sh
vi /etc/ssh/sshd_config

PermitRootLogin no
PasswordAuthentication no
```
- `shutdown -r now`

# Mit Rescue System, Dateisystem anschauen

- Server anklicken in der Weboberfläche: https://console.hetzner.cloud/projects/866457/servers
- Rescue -> Rescue Aktiviern und Reset  -> SSH Schlüssel wählen
- `ssh ... wie in FAQ`
- `cryptsetup  luksOpen /dev/sda2 cryptroot`
- System mounten
```sh
  mount /dev/vg0/root /mnt \
  && mkdir -p /mnt/var/snap \
  && mount /dev/vg0/snap /mnt/var/snap \
  && mount /dev/sda1 /mnt/boot  \
  && mount --bind /dev /mnt/dev \
  && mount --bind /sys /mnt/sys \
  && mount --bind /proc /mnt/proc \
  && mount --bind /run /mnt/run \
  && chroot /mnt
```

- ... jetzt kann man rumschauen und änderungen vornehmen ...

- `exit`
- System unmounten
```sh
     umount /mnt/boot /mnt/var/snap /mnt/proc /mnt/sys /mnt/dev /mnt/run \
  && umount /mnt \
  && sync
  shutdown -r now
```



## FAQ
- Shift+Einfügen für paste
- nebenbei kann immer die Konsole von Hetzner aufgemacht werden, da sieht man was passiert
- connecten am besten mit: `ssh-keygen -R 159.69.145.135 && ssh -i ~/.ssh/hetzner-server_ed25519 -l root nextcloud` da sich der host key ständig ändert
- pw ändern vom lukx pw: cryptsetup luksChangeKey /dev/sda2
- standard key: `ssh-keygen -t ed25519 -a 100 -C "hetzner-server" -f ~/.ssh/hetzner-server_ed25519`
- key erstellen für dropbear: `ssh-keygen -t rsa -b 4096 -C "dropbear_nextcloud_server" -f .ssh/dropbear_nextcloud_server_rsa` bzw. das nehmen was in Bitwarden liegt
- wenn network nicht gefunden wird, wenn dropbear startet: https://unix.stackexchange.com/questions/597078/unlock-luks-device-remotely-ipconfig-no-devices-to-configure
