# Nextcloud einrichten

## FAQ
- Nextcloud Snap: https://github.com/nextcloud/nextcloud-snap

## Nextcloud commands
- sudo nextcloud.occ maintenance:mode --on
- sudo nextcloud.export

## Nextcloud via SNAP installieren
- `sudo -i`
- `apt install snapd`
- `snap help --all`
- Alte Spielinstanz löschen: `sudo snap remove nextcloud --purge #ohne snapshot vorher`
- `snap install nextcloud`
- `changes nextcloud`
- `nextcloud.manual-install admin '<PWFromBitwarden>'`
- `nextcloud.occ config:system:get trusted_domains`
- `nextcloud.occ config:system:set trusted_domains 1 --value=nextcloud.internal.gee-whiz.de`
- `nextcloud.occ config:system:set overwritehost --value="nextcloud.internal.gee-whiz.de"`
- `nextcloud.occ config:system:set overwriteprotocol --value="https"`
- `snap set nextcloud ports.http=8080`
- `snap set nextcloud php.memory-limit=512M`
- Firewall konfigurieren
```sh
apt install ufw
ufw allow ssh \
&& ufw allow http \
&& ufw allow https \
&& ufw enable
```

## Zertifikate hole bzw. einrichten

- Nun das root zertifkat holen, wird für caddy benötigt
- Oder es einrichten wi in docs/certs.md beschrieben

## caddy installieren
- Install Anleitung: https://caddyserver.com/docs/install#debian-ubuntu-raspbian
- Config:
```sh
vi /etc/caddy/Caddyfile
#####
{
        email letsencrypt@gee-whiz.de
        acme_ca https://acme-v02.api.letsencrypt.org/directory
}

nextcloud.internal.gee-whiz.de {
        tls {
                client_auth {
                        trusted_ca_cert_file /home/cecom/projects/xca/certificates/gee-whiz_root_CA.crt
                }
        }
        reverse_proxy 127.0.0.1:8080
}
#####
```
- Durchstarten: 
```sh
  systemctl restart caddy
  systemctl status caddy
```
- 'employee' Gruppe hinzufügen
- user sop,... hinzufügen und gruppe 'employee' zuweisen

## Backup Einrichten

- Dazu in docs\borg\readme.md lesen

## Backup einspielen

- Link: https://github.com/nextcloud/nextcloud-snap/wiki/How-to-backup-your-instance
- mit Borg einen Backup nach `/var/snap/nextcloud/common/backups` ablegen
- `nextcloud.import /var/snap/nextcloud/common/backups/XXX`
