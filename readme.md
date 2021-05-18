#todo:
- ssh agent auf maschine

# Keys Terminal
alt + w: Wort löschen, wenn ein / enthalten da aber halten
alt + backspace: Wort löschen, nicht bei / halten
alt + delete: Wort nach vorne löschen, bei / anhalten
alt + <- bzw. ->: wort nach links oder rechts navigieren und bei / halt machen
strg + <- bzw. ->: wort nach links oder rechts, nicht bei / halt machen
strg + backspace: undo letzten gelöschten zeichen

# Keys bug.n

https://github.com/fuhsjr00/bug.n/blob/v9.0.2/doc/Cheat_sheet/cheat_sheet.md

`#` --> Windows Taste
`^` --> Strg Taste
`+` --> Shift Taste
`!` --> Alt Taste

#^b  --> toggle bug.n bar
#b   --> toggleTaskbar

#SPACE -> shuffleWindow (durch layouts schalten)

#q --> Reload bug.n
#+q --> Exit bug.n
#y --> GUI

#^Backspace --> Reset Tile Window Manager to Default layout

#t #m #f --> set layout to tiling / monocle / floating
#+f --> toggle floating status of current window
#Tab     --> last layout

#BackSpace --> previous active view

#+d --> show title

#+c --> Close Programm

#Up #Down   --> activate Window vor/zurück
#+Up #+Down --> Move active Window to next/previous position in stack
#^Up #^Down  --> Increase / Decrease Master Area Size
#^Tab --> Rotate the master axis

#Left #Right --> Resize Master Area

#^t --> Rotate the layout axis
#^Enter --> Mirror Layout axis
#Enter --> Aktuelles Fenster zum master und wenn nochmal wieder zurück

#i --> Window Info

#1 #2 ... --> Activate View
#^1   ... --> Toggle Tag 1

#. #, --> next previous monitor


# Install Windows

1. msys installieren: Q:\SW-Depot aktuell\2 - Hilfswerkzeuge\msys2
1. msys readme im SW-Depot lesen
1. msys starten
1. pacman -Sy git vim curl tar unrar zsh socat
1. im cmd als admin C:\msys64\home\OppermanS002:
   - `mklink /D .ssh z:\.ssh`
   - `mklink /D .m2 z:\.m2`
   - `mklink /D projekte C:\OppermanS002\projekte`
1. *Initial Setup* ausführen
1. powershell prompt anpassen, powershell starten:
   ```sh
   Test-Path $profile #when true liefert, gibt es schon ein profil unter: Z:\Eigene Dateien\WindowsPowerShell
   #when false dann neu anlegen mit:
   New-Item -path $profile -type file –force
   #der path wird ausgegeben, dahin navigieren und öffnen
   #den inhalt von .config/powershell/Microsoft.PowerShell_profile.ps1 reinkopieren
   #prfile reloaden
   . $profile
   ```
1. Visual Studio Code auf msys2 termin umstellen:
   ```sh
   #visual studio code starten
   #File -> Preference -> Settings öffnen und nach terminal.integrated.shell.windows suchen
   #edit json und folgendes einfügen
   "terminal.integrated.shell.windows": "C:\\msys64\\msys2_shell.cmd",
   "terminal.integrated.shellArgs.windows": ["-defterm", "-mingw64", "-no-start", "-here"]
   "terminal.integrated.fontFamily": "mononoki NF"
   ```

# Install Linux
1. mkdir .ssh
1. ssh-keygen -t ed25519 -a 100 -C "$(whoami)@$(uname -n)-$(date -I)" -f .ssh/$(whoami)@$(uname -n)-$(date -I)
1. public key in bitbucket hinterlegen
1. .ssh/config anlegen und private key hinterlegen: 
   ```
   CanonicalizeHostname yes
   AddKeysToAgent yes
 
   IdentityFile ~/.ssh/<XXXsshKey>
   ```
1. *Initial Setup* ausführen

# Initial Setup (sowohl Windows als auch Linux)
1. Intial setup
   ```
   git clone --bare git@github.com:cecom/archlinux.git $HOME/.cfg
   git --git-dir=$HOME/.cfg/ show master:bin/setupPC.sh | /bin/bash
   ```
1. neu einlogen.

