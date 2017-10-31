#!/bin/sh

mkdir -p ~/.ec2 2>&1 >/dev/null

# Aliases for ssh-ing to ec2 systems
echo "Current EC2 Key file is ${EC2_KEY}"
unalias ec2ssh 1>&2 2>/dev/null
alias ec2ssh="ssh -i ${EC2_KEY}"
unalias ec2tunnel 1>&2 2>/dev/null
alias ec2tunnel="ssh -i ${EC2_KEY} -ND 8157"
unalias ec2rsync 1>&2 2>/dev/null
alias ec2rsync="rsync --progress -avz -e \"ssh -i ${EC2_KEY}\""
unalias ec2scp 1>&2 2>/dev/null
alias ec2scp="scp -i ${EC2_KEY}"

getOrSetInstance() {
  if [ -z "$1" ]; then
    cat ~/.ec2/instance
  else
    echo $1 > ~/.ec2/instance
    echo Set EC2 Instance to $1
  fi
}

unalias ec2instance 1>&2 2>/dev/null
alias ec2instance=getOrSetInstance
