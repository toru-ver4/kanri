# This is zshrc. 
# Oh my God! I can't write English!! 
# Introduction is end.

# Check Environment
kankyo=`uname`

# Language
case "${kankyo}" in
Linux)
   export LANG=ja_JP.UTF-8
   ;;
FreeBSD)
   export LANG=ja_JP.UTF-8
   echo "FreeBSD!!!"
esac

# Emacs like keybind
bindkey -e

# settings for promp
case ${UID} in
# root 
0)
    PROMPT="%{[46m%}%m%# %{[00m%}"
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%B%{[33m%}${PROMPT}%{[00m%}%b"
    ;;
# normal user?
*)
    RPROMPT="[%/]"
    PROMPT="%m%% "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%B%{[33m%}${PROMPT}%{[00m%}%b"
    ;;
esac 

# hokan function
autoload -U compinit
compinit -d /tmp/$USER.zcompdump

# oomoji komoji mushi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_pushd # This is Excellent! 
setopt list_packed # compressd lists
setopt nolistbeep # beep off 

# color
case "${kankyo}" in
Linux)
   alias ls='ls --color=always'	# color
   ;;
FreeBSD)
   alias ls="ls -G"
   ;;
esac
   export LSCOLORS=GxDxFxBxCxegedabagacad
   export LS_COLORS='di=36:ln=01;33:so=01:pi=33:ex=01;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
   zstyle ':completion:*' list-colors 'di=36;01' 'ln=01;33' 'so=01' 'pi=01' 'ex=01;32' 'bd=46;34' 'cd=43;34'


# settings for history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 

# settings for history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

# basic alias
setopt complete_aliases # aliased ls needs if file/dir completions work
alias lh='ls -lh'	# size
alias ll='ls -AlF'	
alias lls='ls -AlF | less'
alias lll='ls -AlFt'
alias llls='ls -AlFt | less'
alias nn='emacs'
alias nnn='emacs -nw'
alias cp='cp -i'
alias mv='mv -i'
alias xxx='chmod +x'
alias screen='screen -D -RR'	# 
alias ssp="screen -X eval split 'select 1' focus 'select 2'"

# fron ~kota/.cshrc
alias h='history -r 30 | cut -f 3 | cat -n'	
alias pss='ps -ux'
alias ttt="top -U`whoami`"
alias moji='nkf --guess'

# Definition of Function

# ll dir | lv
lls(){
    ll "$@/" | lv
}

# lll dir | lv
llls(){
    lll "$@/" | lv
}

# make backup file
fback(){
    cp "$1" "$1".bak.`date +%y%m%d_%H%M`
}

# this is the extension file?
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
