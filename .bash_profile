# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias la='ls -la'

# bash colors

export CLICOLOR=1
export LSCOLORS=ExGxxxxxbxxxxxxxxxxxxx

# prompt color

export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

# rvm stuff

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

# mysql stuff

export PATH=/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/"
export MYSQL_HISTFILE=/dev/null

# generic stuff
export EDITOR=mate
##
# Your previous /Users/thiagobrandam/.bash_profile file was backed up as /Users/thiagobrandam/.bash_profile.macports-saved_2011-07-11_at_15:11:22
##

# MacPorts Installer addition on 2011-07-11_at_15:11:22: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
