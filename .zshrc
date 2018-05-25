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
source /usr/local/Bluemix/bx/zsh_autocomplete


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
GOPATH=$HOME/dev
PATH=$GOPATH/bin:$PATH


##========================================================##
# anyenv
##========================================================##
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi


##========================================================##
# powerline
##========================================================##
# . ~/.pyenv/versions/2.7.13/envs/py2713todo/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# この設定の場合には pyenv global defuse して利用
# . ~/.anyenv/envs/pyenv/versions/2.7.13/envs/defuse/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# . ~/.anyenv/envs/pyenv/versions/3.4.5/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh


##========================================================##
# peco
##========================================================##
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

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
source "$GOPATH/src/github.com/sachaos/todoist/todoist_functions.sh"


##========================================================##
# SDKMAN
##========================================================##
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="${HOME}/.sdkman"
#[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
#source "${HOME}/.sdkman/bin/sdkman-init.sh"



##========================================================##
# iTerm2
##========================================================##
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


##========================================================##
# auto suggestion
##========================================================##
## source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


##========================================================##
# emoji suggestion
##========================================================##
source $HOME/bin/emoji-cli/emoji-cli.zsh

##========================================================##
# tabtab source for serverless package
##========================================================##
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f ${HOME}/.anyenv/envs/ndenv/versions/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . ${HOME}/.anyenv/envs/ndenv/versions/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f ${HOME}/.anyenv/envs/ndenv/versions/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . ${HOME}/.anyenv/envs/ndenv/versions/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh


##=========================================================##
# Google Cloud Platform SDK
##=========================================================##
# The next line updates PATH for the Google Cloud SDK.
if [ -f '${HOME}/bin/gcloud/path.zsh.inc' ]; then source '${HOME}/bin/gcloud/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '${HOME}/bin/gcloud/completion.zsh.inc' ]; then source '${HOME}/bin/gcloud/completion.zsh.inc'; fi

##=========================================================##
# istio
# export PATH="$PATH:${HOME}/Desktop/today_work/istio-0.5.1/bin"
export PATH="$PATH:${HOME}/Desktop/today_work/istio-0.7.1/bin"


