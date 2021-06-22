# BORG Einrichten (Hier am Beispiel von Nextcloud)

1. als `root` folgende Schritte ausführen
1. borg installieren: 
```sh
  apt install borgbackup 
```
1. Key erzeugen (ohne passwort): `ssh-keygen -t ed25519 -a 100 -C borg_nextcloud_ed25519 -f ~/.ssh/borg_nextcloud_ed25519`
1. Authorized Keys von der Storagebox laden und eigenen public key hinterlegen:
```sh
  sftp u185827@u185827.your-backup.de
  cd .ssh
  get authorized_keys
  cd ..
  mkdir borg
  mkdir borg/nextcloud 
  exit
```
1. In der authorized_keys den neuen public key hinzufügen: `cat ~/.ssh/borg_nextcloud_ed25519.pub >> authorized_keys`
1. authorized_keys wieder hochladen und rechte anpassen:
```sh
echo -e "chmod 700 .ssh \n put authorized_keys .ssh/authorized_keys \n chmod 600 .ssh/authorized_keys" | sftp u185827@u185827.your-backup.de
rm authorized_keys
```
1. Beim ersten mal muss borg repo initialisiert werden:
```sh
borg init --encryption=repokey ssh://u185827@u185827.your-backup.de:23/./borg/nextcloud
```
1. Testen ob Verbindung geht:
```sh
source setBorgEnv.sh && borg list ${BORG_REPO}
```
1. die zwei Scripte `doNextcloudBackup.sh` und `setBorgEnv.sh` nach `bin` kopieren und anpassen

# Borg Commands

Export Variablen: `source ~/bin/setBorgEnv.sh`

List: borg list ${BORG_REPO}
Diff: borg diff ${BORG_REPO}::admin_20180821_01:15 admin_20180825_01:15

Backup holen: `borg extract ${BORG_REPO}::<backupaehlen>` z.B. `borg extract ${BORG_REPO}::admin_20180906_01:15`
