### PATH
if [ -d "$HOME/bin" ] ;
  then PATH="$HOME/bin:$PATH"
fi

### our config command for git
function cfg() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}

### check setup
[[ $(cfg config --local --get core.eol) == "lf" ]] || cfg config --local core.eol lf
[[ $(cfg config --local --get core.autocrlf) == "false" ]] || cfg config --local core.autocrlf false
[[ $(cfg config --local --get status.showUntrackedFiles) == "no" ]] || cfg config --local status.showUntrackedFiles no

### System dependent stuff
case "$(uname -s)" in
   Linux)
     USE_OS_SETTINGS=linux
     ;;

   CYGWIN*|MINGW*|MSYS*)
     USE_OS_SETTINGS=windows
     ;;

   *)
     echo 'Dont know what for system you are using...'
     ;;
esac

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex ()
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
