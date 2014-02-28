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

## custom path
export PATH=~/bin:$PATH

## rvm stuff
# This loads RVM into a shell session
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

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

function rails {
  if [ -e Gemfile ]; then
    bundle exec rails $@
  else
    if [ -n $(which rails) ]; then
      $(which rails) $@
    else
      echo "-bash: rails: command not found"
      return 1
    fi
  fi
}

function rake {
  if [ -e Gemfile ]; then
    bundle exec rake $@
  else
    if [ -n $(which rake) ]; then
      $(which rake) $@
    else
      echo "-bash: rake: command not found"
      return 1
    fi
  fi
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
