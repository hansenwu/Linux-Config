# Colors
NORMAL="\[\033[0m\]"
WHITE="\[\033[37m\]"
RED="\[\033[31m\]"
YELLOW="\[\033[33m\]"
NEONGREEN="\[\033[38;5;10m\]"
GREEN="\[\033[38;5;28m\]"
BLUE="\[\033[38;5;39m\]"
GRAY="\[\033[38;5;246m\]"

BOLD="\[\033[1m\]"

# Modules
STARTBRACKET=$BOLD$NEONGREEN'[ '
ENDBRACKET=$BOLD$NEONGREEN' ]'
DIVIDER=$NORMAL' '
USR=$BOLD$BLUE'\u@\H'
TIME=$NORMAL$GRAY'\t'
DIR=$NORMAL$GREEN'\w'
END=$NORMAL'\$ '

# Git stuff
GIT=$NORMAL$RED'$(__git_ps1)'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
# GIT_PS1_SHOWCOLORHINTS=
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1=$STARTBRACKET$TIME$DIVIDER$USR$DIVIDER$DIR$GIT$ENDBRACKET'\n'$END

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
# export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set PATH so it includes user's private bin if it exists
if [[ -e "$HOME/bin" && -e "$HOME/py" ]]; then
    PATH="$HOME/bin:$PATH"
    PATH="$HOME/py:$PATH"
fi

# Alias definitions.
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Welcome Text and MOTD
if [[ -f ~/.bash_motd ]]; then
    . ~/.bash_motd
fi
