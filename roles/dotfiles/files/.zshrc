alias g='git'
alias gs='git switch'
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
export HISTSIZE=10000

function aws-switch-profile() {
  local profile=$(grep '\[' ~/.aws/config | grep -v default | sed -e 's/\[profile //' -e 's/\]//' | peco)
  export AWS_PROFILE="$profile"
  export AWS_EB_PROFILE="$profile"
}

function ssm-start-session() {
  local arg="$*"
  local instance

  instance=$(
    aws ec2 describe-instances \
    --instance-ids $(aws ssm describe-instance-information | jq -r '.InstanceInformationList[].InstanceId') \
    --filters "Name=instance-state-name,Values=running" |
    jq -r '
      .Reservations[].Instances[] |
        [
          .InstanceId,
          .NetworkInterfaces[0].PrivateIpAddress,
          (.Tags[] | select(.Key == "Env").Value),
          (.Tags[] | select(.Key == "Name").Value)
        ] | @tsv
     ' | sort -k 4 | column -t | peco --query "$arg"
  )

  test -z "$instance" && return
  echo "---> $instance"
  aws ssm start-session --target "$(echo $instance | awk '{print $1}')" --document-name AWS-StartInteractiveCommand --parameters command="cd ~; bash -l"
}
