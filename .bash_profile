
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

  export JAVA_HOME=`/usr/libexec/java_home -v 1.${JVM_VERSION}`
  echo "Current JAVA_HOME is ${JAVA_HOME}"
}
alias usejava=switchJava
switchJava 8

# Enable rvm ignoring the crap it spits out every time complaining about incorrect PATH
rvm use 1>/dev/null 2>/dev/null

# Recursive grep
alias grepr="grep -r"

alias upload-ssh-key="~/bin/upload-ssh-key.sh"

function setTitle() {
  echo -n -e "\033];$1\007"
}

alias set-title=setTitle

function useStardog() {
  export STARDOG_HOME=/Users/rvesse/Documents/Data/Stardog
  export PATH=/Users/rvesse/Documents/Apps/stardog-2.2.4/bin:$PATH
  source /Users/rvesse/Documents/Apps/stardog-2.2.4/bin/starman-completion.sh
}

alias use-stardog=useStardog

function showIPs() {
  ifconfig | grep "inet" | grep -v 127.0.0.1
}

alias show-ips=showIPs
# Maven auto-completion
# source ~/bin/maven-completion.bash

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
git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr($0,6)}' | sort --numeric-sort --key=2 | tail -n 10 | cut -d ' ' -f 2,3 | awk '{ cmd = "bth " $1; cmd | getline b; close(cmd); print b,"\t",$2 }'
}

alias git-large=gitLargeObjects

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/rvesse/.gvm/bin/gvm-init.sh" ]] && source "/Users/rvesse/.gvm/bin/gvm-init.sh"

# New environment setting added by Protex on Wed Feb 18 15:24:32 GMT 2015 1.
# The unmodified version of this file is saved in /Users/rvesse/.bash_profile2087906606.
# Do NOT modify these lines; they are used to uninstall.
PATH="/Applications/protexIP/bin:${PATH}"
export PATH
# End comments by InstallAnywhere on Wed Feb 18 15:24:32 GMT 2015 1.

##
# Your previous /Users/rvesse/.bash_profile file was backed up as /Users/rvesse/.bash_profile.macports-saved_2015-12-10_at_17:06:26
##

# MacPorts Installer addition on 2015-12-10_at_17:06:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
