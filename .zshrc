# If not running interactively, don't do anything 
[[ $- != *i* ]] && return

### COLORS
~/bin/shellcolors

### LOCALS
LOC=de_DE.UTF-8
export LC_ALL= LANG=${LOC} LC_CTYPE=${LOC} LC_NUMERIC=${LOC} LC_TIME=${LOC} LC_COLLATE=${LOC} LC_MONETARY=${LOC} LC_PAPER=${LOC} LC_NAME=${LOC} LC_ADDRESS=${LOC} LC_TELEPHONE=${LOC} LC_MEASUREMENT=${LOC} LC_IDENTIFICATION=${LOC} LC_MESSAGES=C TZ=Europe/Berlin

### EXPORT
export TERM="xterm-256color"
export HISTCONTROL=ignoredups:erasedups   # no duplicate entries
export EDITOR='vim'

### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

### Automatic options added
setopt inc_append_history autocd nomatch autopushd pushdignoredups promptsubst hist_ignore_dups histignorespace
unsetopt beep

### keychain
LOOK_FOR_USER=`echo $USER | tr '[:upper:]' '[:lower:]' | sed -e 's#.*\\\##'`
PRIVATE_KEY=`find ~/.ssh/ -maxdepth 1 -regex ".*/\.ssh/${LOOK_FOR_USER}@[^\.]*"`
if [ -x ~/bin/keychain ] && [ -e "$PRIVATE_KEY" ]; then
    chmod 600 $PRIVATE_KEY
    eval $(~/bin/keychain --eval --agents ssh ${PRIVATE_KEY})
else
   echo "##########################################################################################" 
   echo "ERROR: You don't have a ssh-key with \"~/.ssh/${LOOK_FOR_USER}@...\" or ~/bin/keyhcain not executable."
   echo "##########################################################################################"
fi

### Update if necessary
[[ -x "$HOME/bin/updateCfg" ]] && $HOME/bin/updateCfg

### ALIASES 

#lazy stuff
alias mkdir='mkdir -p' 
alias vi='vim'

# Changing "ls" to "exa"
hash exa 2>/dev/null && LS_TO_USE=exa || LS_TO_USE=/bin/ls

alias ls="$LS_TO_USE -al --color=always --group-directories-first" # my preferred listing 
alias la="$LS_TO_USE -a --color=always --group-directories-first"  # all files and dirs 
alias ll="$LS_TO_USE -l --color=always --group-directories-first"  # long format 
#alias lt="$LS_TO_USE -aT --color=always --group-directories-first" # tree listing 
alias l.="$LS_TO_USE -a | egrep '^\.'"

# Colorize grep output (good for log files) alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias dl="wget -euse_proxy=on --no-check-certificate"
alias tm="tmux new -A -s default"

### Key Bindings
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Ctrl-Left]="${terminfo[kLFT5]}"
key[Ctrl-Right]="${terminfo[kRIT5]}"
#to get a binding press strg + v and now the keys you want eg alt + w
key[Alt-Left]="^[[1;3D"
key[Alt-Right]="^[[1;3C"
key[Alt-Delete]="^[[3;3~"
key[Alt-w]="^[w"

bindkey -e  # setup emacs-like key bindings.
bindkey '^R' history-incremental-search-backward

# delete char on delete key
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${key[Up]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${key[Up]}" up-line-or-beginning-search
fi

# start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key[Down]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${key[Down]}" down-line-or-beginning-search
fi

# Alt+Delete
forward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle kill-word
}
zle -N forward-kill-dir
bindkey "${key[Alt-Delete]}" forward-kill-dir

# Alt+w
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey "${key[Alt-w]}" backward-kill-dir

# Alt+Left
backward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-word
}
zle -N backward-word-dir
bindkey "${key[Alt-Left]}" backward-word-dir

# Alt+Right
forward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle forward-word
}
zle -N forward-word-dir
bindkey "${key[Alt-Right]}" forward-word-dir

### Others
# autocompletion on ssh/scp/...
#autoload -Uz compinit
#compinit

### ENVIRONMENT
#export no_proxy=""
#export http_proxy=""
#export https_proxy=""

### LOAD System dependent stuff
[[ -e "$HOME/.zshrc.${USE_OS_SETTINGS}" ]] && source ~/.zshrc.${USE_OS_SETTINGS}

### other stuff
[[ -d "${MAVEN_HOME}" ]] && PATH="${MAVEN_HOME}/bin:${PATH}"
[[ -d "${JAVA_HOME}" ]]  && PATH="${JAVA_HOME}/bin:${PATH}"
[[ -d "${GO_HOME}" ]]  && PATH="${GO_HOME}/bin:${PATH}"

### PROMPT
OH_MY_POSH_EXECUTABLE=oh-my-posh.${USE_OS_SETTINGS}

function omp_preexec() {
  omp_start_time=$(${OH_MY_POSH_EXECUTABLE} --millis)
}

function omp_precmd() {
  omp_elapsed=-1
  if [ $omp_start_time ]; then
    omp_now=$(${OH_MY_POSH_EXECUTABLE} --millis)
    omp_elapsed=$(($omp_now-$omp_start_time))
  fi
  eval "$(${OH_MY_POSH_EXECUTABLE} --config ~/.config/oh-my-posh/my.json --error $? --execution-time $omp_elapsed --eval)"
  unset omp_start_time
  unset omp_now
  unset omp_elapsed
}

function install_omp_hooks() {
  for s in "${preexec_functions[@]}"; do
    if [ "$s" = "omp_preexec" ]; then
      return
    fi
  done
  preexec_functions+=(omp_preexec)

  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "omp_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(omp_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_omp_hooks
fi
