autoload -U compinit
autoload -U add-zsh-hook
compinit

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
if [ ! -d $ZPLUG_HOME ]; then
    export ZPLUG_HOME=$HOME/.zplug/init.zsh
fi
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "marzocchi/zsh-notify"
zplug "Tarrasch/zsh-autoenv"
zplug "rupa/z", use:z.sh
zplug "plugins/django", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# complement
fpath=($HOME/.zsh/functions $fpath)
autoload -U compinit promptinit
compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
setopt list_packed

# history ignore space
#
setopt HIST_IGNORE_SPACE

# disable nomatch
#
setopt nonomatch

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

# rbenv
if [[ $(type rbenv)  ]]; then
    eval "$(rbenv init -)"
fi

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# pip completion
if [[ $(type pip3) ]]; then
    eval "$(pip3 completion --zsh)"
fi

# pipenv completion
if [[ $(type pipenv) ]]; then
    eval "$(pipenv --completion)"
fi

# hub
if [[ $(type hub) ]]; then
  eval "$(hub alias -s)"
fi

# virtualenvwrapper
VIRTUALENVWRAPPER_PATH=`which virtualenvwrapper.sh`
if [[ -s $VIRTUALENVWRAPPER_PATH ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source $VIRTUALENVWRAPPER_PATH
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

# historical backward search with linehead string binded to ^R
#
bindkey '^R' history-incremental-search-backward

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



#
# Show branch name in Zsh's right prompt
#

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=%F{green}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=%F{yellow}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                 color=%F{red}
         fi

        echo "$color$name$action%f%b "
}

setopt prompt_subst

RPROMPT='[`rprompt-git-current-branch`%~]'

REPORTTIME=3

# direnv
if [[ $(type direnv) ]]; then
    eval "$(direnv hook zsh)"
fi

# Rust
CARGO_ENV_PATH=${HOME}/.cargo/env
if [[ -s $CARGO_ENV_PATH ]]; then
    source $CARGO_ENV_PATH
fi
if [[ $(type rustc) ]]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
