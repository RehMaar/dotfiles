#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local BBlu='\[\e[0;34m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}:(${RCol}"      # Add red if exit code non 0
    else
        PS1+="${BBlu}:)${RCol}"
    fi

    PS1+="${BBlu} \h @ \w\n» ${RCol}"
}

# Aliases
alias tmux='tmux attach || tmux new'
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Environment
export EDITOR=kak

export GOPATH=$HOME/.go
export LOCAL_PATH=$HOME/.local
export PATH=$LOCAL_PATH/bin:$LOCAL_PATH/usr/local/bin:$PATH:$HOME/.cabal/bin:$GOPATH/bin

export WINEPREFIX=$HOME/wine_prefixes/32x

# SDCV
export SDCV_HISTSIZE=0
