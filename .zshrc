export ZSH="/home/brighter/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions autojump)

source $ZSH/oh-my-zsh.sh

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export TERM='xterm-256color'
export MANPAGER="vim -c MANPAGER -"

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

# SET PATH FOR NODEJS
export NODE_HOME=/opt/software/node-v14.17.6-linux-x64
export PATH=$NODE_HOME/bin:$PATH

# SET PATH FOR GO
export PATH=$PATH:/usr/local/go/bin

alias 'ssh404_brighter'='ssh brighter@10.112.81.222 -p 2222'
alias 'ssh404_shark'='ssh shark@10.112.81.222 -p 2222'
alias 'ssh418'='ssh brighter@10.112.225.55 -p 2222'
alias 'ssh532'='ssh brighter@10.128.199.95 -p 2202'

alias 'cl'='clear'
alias 'lg'='ls -a | grep'
alias 'gnr'='grep -n -r'
alias 'nt=cat << EOF >> .notes'
# alias 'man'='bash /home/brighter/.config/nvim/.man'

alias 'ta'='tmux a -t'
alias 'tn'='tmux new -s'

alias 'gcc'='gcc -fsanitize=address -ggdb'
alias 'make'='make -j4'
# alias 'cmake'='cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES'

# PROXY
alias setproxy='export http_proxy=http://127.0.0.1:8889; export https_proxy=$http_proxy; echo "HTTP Proxy on";'
alias unsetproxy='unset http_proxy; unset https_proxy; echo "HTTP Proxy off";'
