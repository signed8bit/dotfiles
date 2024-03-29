##
# General
##

# Set unlimited history
export HISTSIZE=-1 
export HISTFILESIZE=-1

# Prompt
if [ -f /opt/homebrew/share/liquidprompt ]; then
	. /opt/homebrew/share/liquidprompt
fi    

# Color
export CLICOLOR='true'

# Editor
export EDITOR="bbedit --wait --resume"

# Path
export PATH="~/.go/bin/:/usr/local/opt/gnu-sed/libexec/gnubin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

# Reasonable file limit
ulimit -n 1024

# Load SSH identities
ssh-add -K ~/.ssh/id_ed25519 2>/dev/null;
ssh-add -K ~/.ssh/id_rsa 2>/dev/null;

# Homebrew Bash Completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh" 

##
# Exports
##

# GPG
export GPG_TTY=$(tty)

# Homebrew gnubin
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH" 

# Homebrew rbenv
export RBENV_VERSION=2.4.1
export RBENV_ROOT=/usr/local/var/rbenv

# Homebrew build changes
# export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/readline/include -I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:/usr/local/opt/readline/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/bzip2/lib/pkgconfig"

# Go
export GOPATH=/Users/$USER/go
export PATH=$GOPATH/bin:$PATH

# Java
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.9.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"

# Groovy
# export GROOVY_HOME=/usr/local/opt/groovysdk/libexec

# Maven
# export M2_HOME="/usr/local/Cellar/maven/current/libexec"
# export MAVEN_OPTS="-Xmx512m"
# export PATH="$M2_HOME/bin:$PATH"

# Ant
# export ANT_HOME="/usr/local/Cellar/ant/current/libexec"
# export PATH="$ANT_HOME/bin:$PATH"

# Node
# export NPM_HOME="/usr/local/share/npm"
# export NODE_PATH="$NPM_HOME/lib/node_modules"
# export PATH="$NPM_HOME/bin:$PATH"

# VMware Fusion
# export VMWAREVM_HOME="$HOME/Documents/Virtual Machines/VMware"
# export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"
# export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"

## Vagrant
# export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
# export VAGRANT_VMWARE_CLONE_DIRECTORY="${VMWAREVM_HOME}"

## AWS CLI Scripting
# export PATH="$HOME/Projects/scripting/aws-cli-scripting/bin:$PATH"
# export EC2_SSH_USER="ubuntu"
# export EC2_SSH_PROFILE="default"

##
# Aliases
##

alias os="openstack"
alias kc="kubectl"
alias bz="bazel"
alias cls="clear"
alias mvns="mvn -Dmaven.test.skip=true"
alias rm="rm -i"
alias bb="bbedit"
alias recent="ls -lthr | tail"
alias md5="openssl md5"
alias vg="vagrant"
alias dpaste="curl -F 'content=<-' http://dpaste.cisco.com/api/"
alias start-work="sudo netloc work && sudo ifconfig en1 down && sudo ifconfig en1 up"
alias stop-work="sudo netloc home"
alias fix-work="sudo ifconfig en12 down && sudo ifconfig en12 up"
alias sha256sum="shasum -a 256"
alias macerate-dev="macerate -c ~/.config/macerate/dev.yml"
alias dbash="docker run -it --entrypoint /bin/bash"
alias jump="ssh -A jump.ci.ciscolabs.com"

run_kcbash() {
    kubectl exec -it ${1} -- /bin/bash
}
alias kcbash=run_kcbash

run_kcsh() {
    kubectl exec -it ${1} -- /bin/sh
}
alias kcsh=run_kcsh

alias grepjars="find ./ -name \"*.jar\" -exec echo {} \; -exec jar -tf {} \; | grep -e \".jar\" -e $1"

alias sync-music="rsync -avz --include '*/' --include '*.mp3' --include '*.m4a' --exclude '*' /Volumes/Media/Music/ /Volumes/MUSIC/"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the "Open With" submenu.
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder"

#Tip: add 'alias cd="pushd &> /dev/null"' to your .bashrc; when you cd to a #directory you'll always be able to 'popd' back where you started.

# Remove all Docker containers that have exited
alias docker-purge="docker rm -v $(docker ps -a -q -f status=exited)"

# OpenStack API Setup
run_osapi() {
    local config_dir=${HOME}/.openstack
    local path_to_file=${config_dir}/${1}-openrc.sh

    if [[ -f "${path_to_file}" ]]; then
        workon osapi
        . ${path_to_file}
    else
       echo "Usage: osapi [project]"
       echo "Available Projects:"
       echo `cd ${config_dir} && for i in *.sh; do echo ${i%-openrc*} ; done`
    fi
}

alias osapi=run_osapi

## Gerrit Setup
run_gerritsetup() {
    git remote add gerrit `git remote -v | grep -m 1 -o 'ssh://.* '` &&
    git review -s
}

alias gerritsetup=run_gerritsetup

## Gerrit Development Install
run_gerritdev() {
    java -jar ${1} init --install-all-plugins --dev --batch -d ${1%.*}
}

alias gerritdev=run_gerritdev

## Vagrant Setup
run_vgsetup() {
    cp -i ~/.vagrantfile-template.rb ./Vagrantfile && \
    cp -i ~/.vagrant-hosts.yaml ./vagrant-hosts.yaml
}

alias vgsetup=run_vgsetup

## Extract a source RPM
run_esrpm() {
    if [ -f "${1}" ]; then
        echo "Extracting ${1}..."
        file_name=$(basename "${1}")
        dir_name="${file_name%.*}"

        if [ ! -d "${dir_name}" ]; then
            mkdir ${dir_name}
            cd ${dir_name} && rpm2cpio.pl ../${1} | cpio -i -d
            cd ../
        fi
    fi
}

alias esrpm=run_esrpm
