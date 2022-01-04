
# Force Java processes to be headless
#export JAVA_TOOL_OPTIONS="-Djava.awt.headless=true"

# CLI Colour Output
export CLICOLOR=1

# Source main profile
source ~/.profile

# Alias sha1
alias sha1="/usr/bin/openssl sha1"

# Alias for refreshing DNS
alias refresh-dns="sudo killall -HUP mDNSResponder"

# Alias for directory sizing
alias dirsize="du -h -d 0"
alias dirsizes="du -h -d 1"

# Alias for downloading remote directories (assuming directory listing is available)
alias wgetdir="wget -r --no-parent -nd --reject \"index.html*\""

# Aliases for EC2
source ~/bin/ec2.sh
alias use-ec2key-personal="ec2key /Users/rvesse/Dropbox/Personal/Keys/dotNetRDF-EC2.pem"
alias use-ec2key-work="ec2key /Users/rvesse/Dropbox/Personal/Keys/Work-EC2.pem"

# Alias for switching Java versions

function switchJava() {
  JVM_VERSION=${1:-7}

  if [ "${JVM_VERSION}" -lt 9 ]; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.${JVM_VERSION}`
  else
    export JAVA_HOME=`/usr/libexec/java_home -v ${JVM_VERSION}`
  fi
  echo "Current JAVA_HOME is ${JAVA_HOME}"
}
alias usejava=switchJava
switchJava 11

# Enable rvm ignoring the crap it spits out every time complaining about incorrect PATH
rvm use 1>/dev/null 2>/dev/null

# Recursive grep
alias grepr="grep -r"

alias upload-ssh-key="~/bin/upload-ssh-key.sh"

function setTitle() {
  echo -n -e "\033];$1\007"
}

alias set-title=setTitle

function showIPs() {
  ifconfig | grep "inet" | grep -v 127.0.0.1
}

alias show-ips=showIPs

function enableSshLogin() {
  cat ~/.ssh/id_rsa.pub | ssh $1 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
}

alias enable-ssh-login=enableSshLogin

alias reset-dns="sudo killall -HUP mDNSResponder"

function bytesToHuman() {
	    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
	    while ((b >= 1024)); do
	       d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
	       b=$((b / 1024))
	       let s++
	    done
	    echo "$b$d ${S[$s]}"
}

alias bth=bytesToHuman

function gitLargeObjects() {
  local TOP=${1:-10}
  git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr($0,6)}' | sort --numeric-sort --key=2 | tail -n ${TOP} | cut -d ' ' -f 2,3 | awk '{ cmd = "bth " $1; cmd | getline b; close(cmd); print b,"\t",$2 }'
}

alias git-large=gitLargeObjects

# GPG Enablement
export GPG_TTY=$(tty)

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/rvesse/.gvm/bin/gvm-init.sh" ]] && source "/Users/rvesse/.gvm/bin/gvm-init.sh"

PATH="$PATH:/Users/rvesse/Documents/Apps/apache-maven/bin"

export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

