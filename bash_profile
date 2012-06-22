# aliases
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

# bash colors

export CLICOLOR=1
export LSCOLORS=ExGxxxxxbxxxxxxxxxxxxx

# prompt color

export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

# git stuff

if [[ -s "$HOME/.git-completion.bash" ]]; then
    source "$HOME/.git-completion.bash"
fi

# rvm stuff

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
export PATH=$HOME/.rvm/bin:$PATH

# mysql stuff

export PATH=/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/"
export MYSQL_HISTFILE=/dev/null

# history stuff
export HISTSIZE=1000
export HISTTIMEFORMAT="| %d/%m/%Y %T | " # 319  | 2010-06-02 09:02PM | reload
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND" # Save and reload the history after each command finishes
export HISTCONTROL=erasedups # ignore repeat commands
export HISTIGNORE="&:cl:x" # ignore specific commands


# generic stuff
export EDITOR=mate
export PERL_UNICODE=AS #This makes all Perl scripts decode @ARGV as UTF‑8 strings, and sets the encoding of all three of stdin, stdout, and stderr to UTF‑8. Both these are global effects, not lexical ones.
unset MAILCHECK #do not check for mails in bash

function reload {
  source "$HOME/.bash_profile"
}

function rails {
  if [ -e Gemfile ]; then
    bundle exec rails $@
  else
    rails_executable=$(which rails)
    if [ -n "$rails_executable" ]; then
      $rails_executable $@
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
    rake_executable=$(which rake)
    if [ -n "$rake_executable" ]; then
      $rake_executable $@
    else
      echo "-bash: rake: command not found"
      return 1
    fi
  fi
}

function deploy {
  if [ -e .git/config ]; then
    ey_executable=$(which ey)
    if [ -n "$ey_executable" ]; then
      current_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
      current_app=$(basename $(pwd))
      if [ "$1" == "-m" ]; then
        ey deploy --app="$current_app" --ref="$current_branch" --migrate
      else
        ey deploy --app="$current_app" --ref="$current_branch"
      fi
    else
      echo '-bash: deploy: Gem "engineyard" is not installed'
      return 1
    fi
  else
    echo '-bash: deploy: No repository available'
    return 1
  fi
}

function mate {
  mate_executable=$(which mate)
  if [ -n "$mate_executable" ]; then
    if [ $# -gt 0 ]; then
      $mate_executable $@
    else
      $mate_executable .
    fi
  else
    echo '-bash: mate: command not found'
    return 1
  fi
}

function utf8 {
  if [ $# -gt 0 ]; then
    iconv -f ISO-8859-1 -t UTF-8 "$@" > "new_$@"
  else
    echo 'Usage: utf8 [file]'
    return 1
  fi
}
