alias g='git'
alias gpl='git pull'
alias gps='git push origin'
alias glog='git log --oneline | head'
alias gh='cd $(ghq list --exact --full-path | peco)'

alias la='ls -laG'
alias ll='ls -lG'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias crontab='crontab -i'
alias dig='dig @8.8.8.8'

export PATH=$PATH:~/.nodebrew/current/bin/
