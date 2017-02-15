# Zsh commands
autoload -U promptinit

autoload -Uz compinit
compinit

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search


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
export LOCAL_PATH=$HOME/.local
export PATH=$LOCAL_PATH/bin:$LOCAL_PATH/usr/local/bin:$PATH

# Prompt
export PROMPT='%F{blue}»%f '
export RPROMPT='%F{blue}%~@%m[%?]%f'
