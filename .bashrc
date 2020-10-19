#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PATH
if [ -d "$HOME/bin" ] ;
  then PATH="$HOME/bin:$PATH"
fi

### LOCALS
LOC=de_DE.UTF-8
export LC_ALL= LANG=${LOC} LC_CTYPE=${LOC} LC_NUMERIC=${LOC} LC_TIME=${LOC} LC_COLLATE=${LOC} LC_MONETARY=${LOC} LC_PAPER=${LOC} LC_NAME=${LOC} LC_ADDRESS=${LOC} LC_TELEPHONE=${LOC} LC_MEASUREMENT=${LOC} LC_IDENTIFICATION=${LOC} LC_MESSAGES=C TZ=Europe/Berlin

### EXPORT
export TERM="xterm-256color"
export HISTCONTROL=ignoredups:erasedups   # no duplicate entries
export EDITOR='vim'

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### ALIASES 

#our config alias
alias config='/usr/bin/git --git-dir=/home/cecom/.cfg/ --work-tree=/home/cecom'

#lazy stuff
alias mkdir='mkdir -p' 

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

### PROMPT
function _update_ps1() {
  PS1="$(oh-my-posh -config ~/.config/oh-my-posh/my.json -error $?)"
}

if [ "$TERM" != "linux" ] && [ -x "$(command -v oh-my-posh)" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#neofetch system info
neofetch
