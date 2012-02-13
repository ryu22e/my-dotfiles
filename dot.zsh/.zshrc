autoload -U compinit
compinit

if [ -f $HOME/.env ]; then
   source $HOME/.env 
fi

if [ -f $HOME/.alias ]; then
    source $HOME/.alias
fi

# complement
fpath=($HOME/.zsh/functions $HOME/.zsh/zsh-completions $fpath)
autoload -U compinit promptinit
compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
setopt list_packed

# cd and other commands dereference symlinks
#
setopt chase_links

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list displayed
#
setopt nolistbeep

if [[ -s $HOME/perl5/perlbrew/etc/bashrc ]] ; then source $HOME/perl5/perlbrew/etc/bashrc ; fi
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# pythonbrew
if [[ -s $HOME/.pythonbrew/etc/bashrc ]]; then source $HOME/.pythonbrew/etc/bashrc ; fi

# virtualenv
if [[ -s $HOME/.py_version ]]; then
    source $HOME/.py_version ;
    if [[ -s $HOME/.python$PY_VERSION/bin/activate ]]; then 
        source $HOME/.python$PY_VERSION/bin/activate 
        ; 
    fi
fi

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Keybind configuration
#
# vim like keybind 
#
bindkey -v
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
  
  
## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command h

case "${TERM}" in
kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

case "${OSTYPE}" in
    freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

# For Ubuntu
case `uname -a` in
    Linux\ ubuntu-server*)
        case $TERM in   
            linux) LANG=C;; 
            *) LANG=ja_JP.UTF-8;;
        esac            
    ;;
esac

# Directory for completion.
fpath=(~/.zsh/functions ${fpath})
# Settings for cache.
if [ -d ~/.zsh/cache ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

autoload zed

# For git diff.
function git_diff() {
   git diff --no-ext-diff -w "$@" | vim -R -
}