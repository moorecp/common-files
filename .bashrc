# This file is sourced by all bash shells on startup, whether interactive
# or not.  This file *should generate no output* or it will break the
# scp and rcp commands.

[[ -f /etc/bash_completion ]] && source /etc/bash_completion
[[ -f $HOME/.bash_completions/git-completion ]] && source $HOME/.bash_completions/git-completion

export INPUTRC="$HOME/.inputrc"
export EDITOR="/usr/bin/emacsclient"
export GLOBIGNORE='.:..'
export HISTTIMEFORMAT='%c  '
export LC_COLLATE="POSIX"
export ACKRC="$HOME/.ackrc"

# remove the ':' from wordbreaks so we don't have to escape it on teh command line
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

alias ls='ls --color=auto -F -b -T 0'
alias ll='ls -lh --color=auto -F -b -T 0'
alias lobster="lobster.telaranrhiod.com"
#alias su='su -'
alias la='ls -alh'
alias es='eix'
alias eS='eix -S'
#alias sS='screen -S'
#alias sx='screen -x'
alias sls='screen -ls'
alias sw='screen -wipe'
alias bgup='(wget -O - http://cf.telaranrhiod.com/files/common/backgrounds.tbz2 | tar -xjov --no-same-permissions -C ~/.fluxbox/backgrounds/)'
alias pgrep='pgrep -iL'
which md5 &> /dev/null || alias md5='md5sum'
alias g='git'
alias g{='git stash'
alias g}='git stash apply'
alias glg='git lg'
complete -o default -o nospace -F _git_log glg
alias gdc='git diff --cached'
complete -o default -o nospace -F _git_diff gdc
alias gcm='git commit -m'
alias gc="git commit"
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gs='git status'
alias gst='git status'
alias gco="git checkout"
alias gpp="git pull && git push"
complete -o default -o nospace -F _git_checkout gco
alias gpul="git pull"
complete -o default -o nospace -F _git_pull gpull
alias gpsh="git push"
complete -o default -o nospace -F _git_push gpush
alias gd="git diff"
complete -o default -o nospace -F _git_diff gd
alias gbr="git branch"
complete -o default -o nospace -F _git_branch gbr
alias ga="git add"
complete -o default -o nospace -F _git_add ga

alias cuwork="cucumber ./features -t @shouldwork"
alias cuwip="cucumber ./features -t @wip"
alias cufail="cucumber ./features -t @shouldfail"
alias cuke="cucumber ./features"

alias sc='script/console'
alias sct='RAILS_ENV="test" sc'
alias ss='script/server'

alias ackp='ack --pager="less -r"'
alias acki='ack -i'
alias a='acki'

alias hn='hcl note'
alias be='bundle exec'

sS() {
    if [[ "$2" != "" ]]; then
	ssh -t $2 screen -S $1
    else
	screen -S $1
    fi
}

sx() {
    if [[ "$2" != "" ]]; then
	ssh -t $2 screen -x $1
    else
	screen -x $1
    fi
}

psg() {
    ps aux | grep "$*" | grep -v "grep .*$*"
}

known_hosts_temp_file=~/.ssh/temp_known_hosts_file
set_temp_known_host() {
    rm ${known_hosts_temp_file} &> /dev/null
    # we use xxx because we want this to fail to login, just set the known host
    ssh -o 'StrictHostKeyChecking=no' -o 'PreferredAuthentications="xxx"' -o "UserKnownHostsFile=${known_hosts_temp_file}" $* &> /dev/null
}
pssh() {
    set_temp_known_host $*
    cat ${known_hosts_temp_file} >> ~/.ssh/known_hosts
    ssh $*
}
tssh() {
    set_temp_known_host $*
    ssh -o "UserKnownHostsFile=${known_hosts_temp_file}" $*   
}

vncvia() {
    if [[ "$*" == "" ]]; then
	echo "usage:   vncvia [user@]remotehost [other vnc options...]"
    else
	echo "vncviewer -via $* localhost"
	vncviewer -via $* localhost
    fi
}

alias cd='pushd -n $PWD &> /dev/null; cd'

cf_prompt_command() {
    history -a
}


#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;
#35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;
#31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;
#31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;
#35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;
#35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;
#35:*.dl=01;35::'

#Keeps the terminal from doing funky wrapping stuff
shopt -s checkwinsize

#append to history file on exit instead of overwriting
shopt -s histappend

#don't try to tab complete an empty line
shopt -s no_empty_cmd_completion

#correct minor directory misspellings
shopt -s cdspell

#let * match files beginning with '.' but since GLOBIGNORE is set above it won't match '.' or '..'
shopt -s dotglob

FG_BLACK="\[\033[01;30m\]"
FG_WHITE="\[\033[01;37m\]"
FG_RED="\[\033[01;31m\]"
FG_GREEN="\[\033[01;32m\]"
FG_BLUE="\[\033[01;34m\]"
NO_COLOR="\[\e[0m\]"

WHOAMI="`/usr/bin/whoami`"

#make eterm into xterm for emacs/ssh purposes
if [[ "$TERM" = "eterm-color" ]]; then
    export CF_REAL_TERM=$TERM
    export TERM="xterm-color"
fi

#build PS1
#don't set PS1 for dumb terminals
if [[ "$TERM" != 'dumb' ]] && [[ -n "$BASH" ]]; then
    PS1=''
    #don't modify titlebar on console
    [[ "$TERM" != 'linux' && "$CF_REAL_TERM" != "eterm-color" ]] && PS1="${PS1}\[\e]2;\u@\H:\W\a"

    #use a red $ if you're root, white otherwise
    if [[ $WHOAMI = "root" ]]; then
    	  #red hostname
	      PS1="${PS1}${FG_RED}\u@"
    else
      	#green user@hostname
     	  PS1="${PS1}${FG_GREEN}\u@"
    fi
 
    GIT_PS1_SHOWDIRTYSTATE=1
    #working dir basename and prompt
    PS1="${PS1}\h ${FG_RED}\$(__git_ps1 "[%s]") ${FG_BLUE}\W ${FG_BLUE}\$ ${NO_COLOR}"
fi

#make eterm into xterm for emacs/ssh purposes
if [[ "$TERM" = "eterm-color" ]]; then
    export TERM="xterm-color"
fi

if [[ $WHOAMI = 'root' ]]; then
        export PATH="/bin:/sbin:/usr/bin:/usr/sbin:${ROOTPATH}"
else
        export PATH="/bin:/usr/bin:${PATH}"
fi

[[ "$HOME" == "" ]] && export HOME=`grep -e "^[^:]*\:[^:]*\:$UID\:" /etc/passwd | awk -F ':' '{print $6}'`

export BC_ENV_ARGS="$HOME/.bcrc"

#Extend command history
export HISTSIZE=5000000

#Repeated commands are only stored once
export HISTCONTROL=ignoreboth

#save history with each command
export PROMPT_COMMAND='[[ "`set | grep -E \"cf_prompt_command \(\)\"`" != "" ]] && cf_prompt_command'

if ! shopt -q login_shell; then
    if [ -f /usr/bin/keychain ]; then
	[ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --noask ~/.ssh/id_dsa &> /dev/null
	[ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --noask ~/.ssh/id_rsa &> /dev/null
    fi
    [ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null &> /dev/null
fi


# load any OS specific changes we've made
[ -f ~/.common_files/cf.`uname -s`.conf ] && . ~/.common_files/cf.`uname -s`.conf

#last, but not least, source a configuration file so there's an easy place for users to make configuration changes from the default
[ -f ~/.common_files/cf.conf ] && . ~/.common_files/cf.conf

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh
