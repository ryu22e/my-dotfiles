autoload -U compinit
autoload -U add-zsh-hook
compinit

# Set path
typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

# complement
fpath=($HOME/.zsh/functions $fpath)
autoload -U compinit promptinit
compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
setopt list_packed
if type brew > /dev/null 2>&1; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

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
if type rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# pip completion
# if type pip3 > /dev/null 2>&1; then
#     eval "$(pip3 completion --zsh)"
# fi

# 1Password CLI
OP_PLUGINS_SH_PATH=${HOME}/.config/op/plugins.sh
if [[ -s $OP_PLUGINS_SH_PATH ]]; then
    source $OP_PLUGINS_SH_PATH
fi

# ngrok
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

Z_PATH=/opt/homebrew/etc/profile.d/z.sh
if [[ -s $Z_PATH ]]; then
    source $Z_PATH
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

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# direnv
if type direnv > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# Rust
CARGO_ENV_PATH=${HOME}/.cargo/env
if [[ -s $CARGO_ENV_PATH ]]; then
    source $CARGO_ENV_PATH
fi
if type rustc > /dev/null 2>&1; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# nodenv
if type nodenv > /dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

# uv
if type uv > /dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
fi

if type devpod > /dev/null 2>&1; then
    eval "$(devpod completion zsh)"
fi

# 1Password CLI
function op-items-to-json() {
  op item get --format json $1 | jq -r '.fields[] | select(.value) | (.label) + "=\"" + (.reference) + "\""'
}

# .zshrc.local
LOCAL_ZRHRC=${HOME}/.zshrc.local
if [[ -s $LOCAL_ZRHRC ]]; then
  source $LOCAL_ZRHRC
fi
