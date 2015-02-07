## aliases
alias ..='cd ..'
alias ...='cd ../..'
alias la='ls -la'
alias grep='grep --color=always'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias firefox='open -a Firefox'
alias safari='open -a Safari'
alias flushdns='dscacheutil -flushcache'

## bash colors
export CLICOLOR=1
export LSCOLORS=ExGxxxxxbxxxxxxxxxxxxx

## git stuff
# Shows git information on the prompt
if [[ -s '/usr/local/etc/bash_completion.d/git-prompt.sh' ]]; then
  source '/usr/local/etc/bash_completion.d/git-prompt.sh'
fi

# Adds completion for git functions
if [[ -s '/usr/local/etc/bash_completion.d/git-completion.bash' ]]; then
  source '/usr/local/etc/bash_completion.d/git-completion.bash'
fi

## prompt format
export PS1='\[\033[01;32m\]\u@\h$(__git_ps1 " (%s)")\[\033[01;34m\] \w \$\[\033[00m\] '

## mysql stuff
export PATH=/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/"
export MYSQL_HISTFILE=/dev/null
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH

## custom path
export PATH=~/bin:$PATH

## homebrew
export PATH=/usr/local/bin:$PATH

## go
export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin

# goroot based install
export PATH=$PATH:/usr/local/opt/go/libexec/bin

## rvm stuff
# This loads RVM into a shell session
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

export -a chpwd_functions                              # define hooks as an shell array
[[ " ${chpwd_functions[*]} " == *" _hook_name "* ]] || # prevent double addition
chpwd_functions+=(_hook_name)                          # finally add it to the list

## history stuff
export HISTSIZE=1000
export HISTTIMEFORMAT="| %d/%m/%Y %T | "
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
export HISTCONTROL=erasedups
export HISTIGNORE="&:cl:x"

## generic stuff
# Editor that opens when asked for input
export EDITOR=sublime

# This makes all Perl scripts decode @ARGV as UTF‑8 strings,
# and sets the encoding of all three of stdin, stdout, and
# stderr to UTF‑8. Both these are global effects, not lexical ones.
export PERL_UNICODE=AS

# do not check for mails in bash
unset MAILCHECK

function reload {
  source "$HOME/.bash_profile"
}

function sublime {
  if [ -n $(which sublime) ]; then
    if [ $# -gt 0 ]; then
      $(which sublime) --new-window $@
    else
      $(which sublime) --new-window .
    fi
  else
    echo '-bash: sublime: command not found'
    return 1
  fi
}

function gitchangelog {
  if [ $# -lt 1 ]; then
    echo 'Usage: gitchangelog [ref]'
    return 1
  else
    git log  $1..HEAD --oneline --decorate
  fi
}

function pg_restore_without_bullshit {
  if [ $# -lt 2 ]; then
    echo 'Usage: pg_restore_without_bullshit [db] [filename]'
    return 1
  else
    pg_restore --verbose --clean --no-acl --no-owner -d $1 $2 -U thiago -h localhost -W
  fi
}

function dirsize {
  find . -maxdepth 1 -type d -mindepth 0 -exec du -hs {} \; | gsort -hr
}
