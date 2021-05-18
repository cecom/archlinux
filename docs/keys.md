# Remote Desktop
- Connection Bar: strg - shift - home

- x - shift - enter --> dmenu
- x - enter --> terminal

# Shortcuts Shell
|  Command|Description|
| --------|-----------|
| ctrl-A            | go to the beginning of line     |
| ctrl-E            | go to the end of line           |
| alt + <- bzw. ->  | wort nach links oder rechts navigieren und bei / halt machen |
| alt + w           | Wort löschen, wenn ein / enthalten da aber halten |
| alt + backspace   | Wort löschen, nicht bei / halten |
| alt + delete      | Wort nach vorne löschen, bei / anhalten |
| alt + <- bzw. ->  | wort nach links oder rechts navigieren und bei / halt machen |
| strg + <- bzw. -> | wort nach links oder rechts, nicht bei / halt machen |
| strg + backspace  | undo letzten gelöschten zeichen |
| strg-U            | delete to the beginning of line |
| strg-K            | delete to the end of line       |
| alt-D             | delete to the end of word       |

# Shortcuts TMUX
**Sessions:**
|  Command |Description  |
|---|---|
|  tmux new -s `<sessionname>`|  New session|
| tmux a | Attach  to last session|                           |
|  tmux a -t `<sessionname>` | Attach  to session|
|  tmux kill-session -t `<sessionname>` | Kill session  |
|   Ctrl+Q $ | Rename Session |
|   Ctrl+Q D | Detach Session |
|   Ctrl+Q ) |  Next Sesion  |
|   Ctrl+Q ( |  Previous Session |
|   Ctrl+Y |  Send Ctrl+Q to inner TMUX Session |

 **Windows**
|  Command|Description|
| --------|-----------|
| Ctrl+Q C             | Create Window in current path                     |
| Ctrl+Q P             | Create new Window with predefined Layout          |
| Ctrl+Q Ctrl+&larr;            | Go to previous Window                             |
| Ctrl+Q Ctrl+&rarr;            | Go to next Window                                 |
| Ctrl+Q L             | Go to last Window                                 |
| Ctrl+Q f             | Search Window (Name eingeben oder einfach Enter)  |
| Ctrl+Q 1..9          | Got to window 1..9                                |
| Ctrl+Q Ctrl+Shift+&larr; | Move Window Left                                  |
| Ctrl+Q Ctrl+Shift+&rarr; | Move Window Right                                 |
| Ctrl+Q ,             | Rename Window                                     |
| Ctrl+Q &             | Kill Window                                       |
| Ctrl+Q W             | List Window                                       |

 **Panes**
|  Command|Description|
| --------|-----------|
| Ctrl+Q T        |   Set title on pane, works only with tmux >=2.6, darunter das shellScript setPaneTitle aufrufen|
| Ctrl+Q %       | Split Vertical         |
| Ctrl+Q "       | Split Horizontal       |
| Ctrl+Q &larr;      | move to left pane      |
| Ctrl+Q &rarr;      | move to right pane     |
| Ctrl+Q &uarr;       | move up to pane   |
| Ctrl+Q &darr;  | move down to pane    |
| Ctrl+Q ;       | go to last active pane |
| Ctrl+Q !       | convert pane to window |
| Ctrl+Q X       | Kill pane              |
|select-pane -P 'bg=blue' |                 Background   setzen    |

![TMUX Shortcuts](downloads/tmux-3-1024x640.png)

# Keys bug.n

https://github.com/fuhsjr00/bug.n/blob/v9.0.2/doc/Cheat_sheet/cheat_sheet.md

`#` --> Windows Taste
`^` --> Strg Taste
`+` --> Shift Taste
`!` --> Alt Taste

- #^b  --> toggle bug.n bar
- #b   --> toggleTaskbar
- #SPACE -> shuffleWindow (durch layouts schalten)
- 
- #q --> Reload bug.n
- #+q --> Exit bug.n
- #y --> GUI
- 
- #^Backspace --> Reset Tile Window Manager to Default layout
- 
- #t #m #f --> set layout to tiling / monocle / floating
- #+f --> toggle floating status of current window
- #Tab     --> last layout
- 
- #BackSpace --> previous active view
- 
- #+d --> show title
- 
- #+c --> Close Programm
- 
- #Up #Down   --> activate Window vor/zurück
- #+Up #+Down --> Move active Window to next/previous position in stack
- #^Up #^Down  --> Increase / Decrease Master Area Size
- #^Tab --> Rotate the master axis
- 
- #Left #Right --> Resize Master Area
- 
- #^t --> Rotate the layout axis
- #^Enter --> Mirror Layout axis
- #Enter --> Aktuelles Fenster zum master und wenn nochmal wieder zurück
- 
- #i --> Window Info
- 
- #1 #2 ... --> Activate View
- #^1   ... --> Toggle Tag 1
- 
- #. #, --> next previous monitor 