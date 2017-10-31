#!/bin/bash

if [ -z "$1" ]; then
  echo "No target machine specified"
  exit 1
fi

cat ~/.ssh/id_rsa.pub | ssh $1 'cat - >>~/.ssh/authorized_keys'