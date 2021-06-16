# Iota Node einrichten

- ubuntu 20.04 installieren
- sonst nix auswählen bei der Bestellung

- mit root ssh einlogen: `ssh -l root iota`
- root pw setzen  -> pw aus bitwarden
- `adduser cecom` -> pw aus Bitwarden
- `usermod -aG sudo cecom`
- `su - cecom`
- `sudo apt update`
- `sudo apt install git`
- MyEnv aufsetzen: https://github.com/cecom/MyDevEnv
- Update durchführen: `sudo bin/myEnv/updateUbuntu`
- rebooten: `sudo shutdown -r now`

- Installieren wie hier beschrieben: https://github.com/nuriel77/hornet-playbook#Installation
- Nutzername z.B. myiota und dashboard pw aus bitwarden (iota.iosus.de)
- Security Stuff aus dem Security Kapitel: https://github.com/nuriel77/hornet-playbook#security
````sh
vi /etc/ssh/sshd_config

PermitRootLogin no
PasswordAuthentication no
```

- ausführen: `sudo horc`
- "configure files" -> "choose editor" -> "vi" -> "hornet main config"
   --> identityPrivateKey und das aus Bitwarden nehmen
- "enable https / certificate"
- Peer hinzufügen, Peers können hier gefunden werden: https://nodesharing.wisewolf.de/
```
  iota.iosus.de
  15600
  443
  Peering ID von iota.iosus.de holen
  nodesharing@iosus.de
```
- Dashboard: https://iota.iosus.de
- Grafana: https://iota.iosus.de/grafana/login
