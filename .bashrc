#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#local setting
LOC=de_DE.UTF-8
export LC_ALL= LANG=${LOC} LC_CTYPE=${LOC} LC_NUMERIC=${LOC} LC_TIME=${LOC} LC_COLLATE=${LOC} LC_MONETARY=${LOC} LC_PAPER=${LOC} LC_NAME=${LOC} LC_ADDRESS=${LOC} LC_TELEPHONE=${LOC} LC_MEASUREMENT=${LOC} LC_IDENTIFICATION=${LOC} LC_MESSAGES=C TZ=Europe/Berlin

#our config alias
alias config='/usr/bin/git --git-dir=/home/cecom/.cfg/ --work-tree=/home/cecom'
