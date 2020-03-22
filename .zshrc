##========================================================##
## zshrc
##========================================================##
# .zshrc をコンパイルして .zshrc.zwc を生成するコマンド
# zcompile .zshrc

##========================================================##
## リストの色つけの設定
##========================================================##
# ls, #dir, vdir の設定
alias s='screen -U'
alias ll='ls -l'
alias ls='ls -G'
#alias ls='ls --color'
alias grep='grep --color=auto'
export MAILCHECK=0
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# 補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#todolist duedate
alias tt='todoist list --filter "(overdue | today) & !p1"'
alias tts="todoist list --filter '(overdue | today) & !p1' | awk '{printf \"%s %s\n\",$5,$6}'"

#nvidia gpu
alias nvidia-ps='ps f -o user,pgrp,pid,pcpu,pmem,start,time,command -p `lsof -n -w -t /dev/nvidia*`'
alias chrome='optirun google-chrome --renderer-process-limit=1'
alias chat='optirun -vv Station-1.65.0-x86_64.AppImage'



##========================================================##
## addtional path
#=========================================================##
PATH=$HOME/dotfiles/bin:$PATH

##========================================================##
# Customize to your needs...
# Created by newuser for 5.3.1
# Lang
##========================================================##
export LANG=ja_JP.UTF-8


##========================================================##
# use Color
##========================================================##
autoload -Uz colors
colors

##========================================================##
# Complete
##========================================================##
autoload -Uz compinit
compinit -u
 
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# bluemix clis
if [ -f "/usr/local/Bluemix/bx/zsh_autocomplete" ]; then 
	source "/usr/local/Bluemix/bx/zsh_autocomplete"
fi


##========================================================##
# history
##========================================================##
setopt share_history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


##========================================================##
# alias
##========================================================##
alias todoist='todoist --color'
alias vi='nvim'
alias notebook='$HOME/.anyenv/envs/pyenv/versions/3.4.5/bin/jupyter notebook'

if [ "$(uname)" = 'Linux' ];then
	alias pbcopy='xclip -selection c'
	alias pbpaste='xclip -selection c -o'
fi



##========================================================##
# prompt
##========================================================##
#PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %# "
#PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[yellow]}%m${reset_color}(%~%) % > "


##========================================================##
# Prezto
##========================================================##
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


##========================================================##
# git
##========================================================##
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


##========================================================##
# Golang
##========================================================##
GOROOT=$HOME/.go
GOPATH=$HOME/go
PATH=$GOROOT/bin:$GOPATH/bin:$PATH


##========================================================##
# anyenv
##========================================================##
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi


##========================================================##
# peco
##========================================================##
case ${OSTYPE} in
  darwin*)
	function peco-history-selection() {
	    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
	    CURSOR=$#BUFFER
	    zle reset-prompt
	}
	;;
  linux*)
	# apt install peco
	function peco-history-selection() {
	    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
	    CURSOR=${#BUFFER}
	    zle reset-prompt
	}
	;;
esac

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# peco wsk actions
function peco-wsk-action-list() {
  local list="$(wsk action list | peco --prompt 'ACTION>' | awk '{print$1}')"
  [ -z "$list" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFER="$LBUFFER$list"
  fi
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-wsk-action-list
bindkey '^wa' peco-wsk-action-list

# peco: todoist
# source "$GOPATH/src/github.com/sachaos/todoist/todoist_functions.sh"
if [ -f "$HOME/dotfiles/bin/todoist_functions.sh" ];then
	source "$HOME/dotfiles/bin/todoist_functions.sh"
fi


##========================================================##
# auto suggestion
##========================================================##
## source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


##========================================================##
# emoji suggestion
##========================================================##
if [ -f "source $HOME/bin/emoji-cli/emoji-cli.zsh" ]; then
	source "$HOME/bin/emoji-cli/emoji-cli.zsh"
fi


# Google Cloud Platform SDK
##=========================================================##
# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/bin/gcloud/path.zsh.inc" ]; then
	source "${HOME}/bin/gcloud/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/bin/gcloud/completion.zsh.inc" ]; then
	source "${HOME}/bin/gcloud/completion.zsh.inc"
fi


##=========================================================##
# Python Env (pyenv)
##=========================================================##
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi


##=========================================================##
# Local environment 
##=========================================================##
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


##==========================================================##
## TMUX
##==========================================================##
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session

