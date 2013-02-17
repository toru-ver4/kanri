# This is zshrc. 
# Oh my God! I can't write English!! 
# Introduction is end.

# Check Environment
if [ `uname` = "Linux" ]; then
   kankyo="Linux"
else
   kankyo="Unknown"
fi

# Language
if [ ${kankyo} = "Linux" ]; then
   export LANG=ja_JP.UTF-8
else
   export LANG=ja_JP.eucJP
   echo "set LANG ja_JP.eucJP"
fi

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
export LSCOLORS=GxDxFxBxCxegedabagacad
export LS_COLORS='di=36:ln=01;33:so=01:pi=33:ex=01;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36;01' 'ln=01;33' 'so=01' 'pi=01' 'ex=01;32' 'bd=46;34' 'cd=43;34'

# settings for history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 

# settings for history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
# ¤¦¤§¡Á¤ó¡¤Æ°¤¤¤Æ¤¯¤ì¤Ê¤¤¤è¤¥
bindkey "[Z" reverse-menu-complete

# basic alias
setopt complete_aliases # aliased ls needs if file/dir completions work
alias ls='ls --color=always'	# color
alias lh='ls -lh'	# size
alias ll='ls -AlF'	
alias lls='ls -AlF | less'
alias lll='ls -AlFt'
alias llls='ls -AlFt | less'
alias nn='emacs'
alias nnn='emacs -nw'
alias cp='cp -i'
alias mv='mv -i'
alias x='xgraph'
alias xm='xgraph -M'
alias g='gnuplot'
alias dl='dsp_launcher'
alias xxx='chmod +x'
alias screen='~/local/bin/screen -D -RR'	# 
alias ssp="screen -X eval split 'select 1' focus 'select 2'"

# °Ê²¼¤Ï ~kota/.cshrc ¤«¤é¥Ñ¥¯¤Ã¤Æ²þÂ¤¤ò²Ã¤¨¤¿¤ä¤Ä
alias h='history -r 30 | cut -f 3 | cat -n'	
alias pss='ps -ux'
alias ttt="top -U`whoami`"
alias moji='nkf --guess'

alias eee='env LS_COLORS="" XLIB_SKIP_ARGB_VISUALS=1'

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

# Add PATH ~/da/bin
export PATH=${PATH}:~/da/bin

# this is the extension file?
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
