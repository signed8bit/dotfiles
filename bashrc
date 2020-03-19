##
# General
##

# Set unlimited history
export HISTSIZE=-1 
export HISTFILESIZE=-1

# Prompt
if [ -f /usr/local/share/liquidprompt ]; then
	[[ $- = *i* ]] && source /usr/local/share/liquidprompt
fi

# Color
export CLICOLOR='true'

# Editor
export EDITOR="bbedit --wait --resume"

# Path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

# Reasonable file limit
ulimit -n 1024

# Load SSH identities
# ssh-add -K ~/.ssh/*_rsa 2>/dev/null;
ssh-add -K ~/.ssh/id_ed25519 2>/dev/null;
ssh-add -K ~/.ssh/id_rsa 2>/dev/null;

# Homebrew Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

##
# Exports
##

# GPG
export GPG_TTY=$(tty)

# Homebrew pyenv
export PYENV_ROOT=/usr/local/var/pyenv

export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Projects"

# Homebrew rbenv
export RBENV_VERSION=2.4.1
export RBENV_ROOT=/usr/local/var/rbenv

# Homebrew OpenSSL
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CPPFLAGS=-I/usr/local/opt/openssl/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.6.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Groovy
export GROOVY_HOME=/usr/local/opt/groovysdk/libexec

# Maven
export M2_HOME="/usr/local/Cellar/maven/current/libexec"
export MAVEN_OPTS="-Xmx512m"
export PATH="$M2_HOME/bin:$PATH"

# Ant
export ANT_HOME="/usr/local/Cellar/ant/current/libexec"
export PATH="$ANT_HOME/bin:$PATH"

# Node
# export NPM_HOME="/usr/local/share/npm"
# export NODE_PATH="$NPM_HOME/lib/node_modules"
# export PATH="$NPM_HOME/bin:$PATH"

# VMware Fusion
export VMWAREVM_HOME="$HOME/Documents/Virtual Machines/VMware"
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"

## Vagrant
export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="${VMWAREVM_HOME}"

## AWS CLI Scripting
export PATH="$HOME/Projects/scripting/aws-cli-scripting/bin:$PATH"
export EC2_SSH_USER="ubuntu"
export EC2_SSH_PROFILE="default"

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

run_kbash() {
	kubectl exec -it ${1} -- /bin/bash
}
alias kbash=run_kbash

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

##
# Other
##

# Homebrew pyenv init
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi

# Homebrew rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
