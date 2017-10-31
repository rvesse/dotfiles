#!/bin/sh

mkdir -p ~/.ec2 2>&1 >/dev/null

function ec2getOrSet() {
  local FILE=$1
  local VALUE=$2
  local DATA_FILE="${HOME}/.ec2/${FILE}"
  if [ -n "${EC2_ID}" ]; then
    DATA_FILE="${DATA_FILE}${EC2_ID}"
  fi

  if [ -z "${VALUE}" ]; then
    if [ -e ${DATA_FILE} ]; then
      cat ${DATA_FILE}
    else
      echo "No EC2 ${FILE} configured" >&2
      exit 1
    fi
  else
    echo ${VALUE} > ${DATA_FILE}
    echo "EC2 ${FILE} set to ${VALUE}" >&2
  fi
}

function ec2showSettings() {
  local USER=$(ec2getOrSet user)
  local HOST=$(ec2getOrSet host)
  local KEY=$(ec2getOrSet key)
  if [[ -z "${USER}" || -z "${HOST}" || -z "${KEY}" ]]; then
    echo "EC2 settings not fully defined"
  else
    echo "${USER}@${HOST} using Key ${KEY}"
  fi
}


function ec2id() {
  export EC2_ID=$1
}

function ec2ssh() {
  local USER=$(ec2getOrSet user)
  local HOST=$(ec2getOrSet host)
  local KEY=$(ec2getOrSet key)
  if [[ -z "${USER}" || -z "${HOST}" || -z "${KEY}" ]]; then
    echo "EC2 settings not fully defined"
  else
    set -x
    ssh -i ${KEY} ${USER}@${HOST} $*
    set +x
  fi
}

function ec2rsync() {
  local USER=$(ec2getOrSet user)
  local HOST=$(ec2getOrSet host)
  local KEY=$(ec2getOrSet key)
  if [[ -z "${USER}" || -z "${HOST}" || -z "${KEY}" ]]; then
    echo "EC2 settings not fully defined"
  else
    set -x
    rsync -e "ssh -i ${KEY} -l ${USER}" -avvz --progress $*
    set +x
  fi
}

function ec2scp() {
  local USER=$(ec2getOrSet user)
  local HOST=$(ec2getOrSet host)
  local KEY=$(ec2getOrSet key)
  if [[ -z "${USER}" || -z "${HOST}" || -z "${KEY}" ]]; then
    echo "EC2 settings not fully defined"
  else
    set -x
    scp -i ${KEY} $*
    set +x
  fi
}

alias ec2ssh="ec2ssh"
alias ec2tunnel="ec2ssh -ND 8157"
alias ec2rsync="ec2rsync"
alias ec2scp="ec2scp"

alias ec2id="ec2id"
alias ec2instance="ec2getOrSet host"
alias ec2host="ec2instance"
alias ec2user="ec2getOrSet user"
alias ec2key="ec2getOrSet key"
alias ec2info="ec2showSettings"
