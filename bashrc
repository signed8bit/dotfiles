## General Setup #########################################################################

## Prompt
if [ -f /usr/local/share/liquidprompt ]; then
	. /usr/local/share/liquidprompt
fi

## Color
export CLICOLOR='true'

## Editor
export EDITOR="bbedit --wait --resume"

## Path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

## Set a more reasonable file limit
ulimit -n 1024

## Load SSH identities
ssh-add -K ~/.ssh/id_rsa 2>/dev/null;


## Aliases ###############################################################################

alias os="openstack"
alias cls="clear"
alias rm="rm -i"
alias bb="bbedit"
alias recent="ls -lthr | tail"
alias md5="openssl md5"
alias vg="vagrant"
alias dpaste="curl -F 'content=<-' http://dpaste.cisco.com/api/"
alias start-work="sudo netloc work && sudo ifconfig en1 down && sudo ifconfig en1 up"
alias stop-work="sudo netloc home"
alias fix-work="sudo ifconfig en1 down && sudo ifconfig en1 up"
alias sha256sum="shasum -a 256"

alias grepjars="find ./ -name \"*.jar\" -exec echo {} \; -exec jar -tf {} \; | grep -e \".jar\" -e $1"

alias sync-music="rsync -avz --include '*/' --include '*.mp3' --include '*.m4a' --exclude '*' /Volumes/Media/Music/ /Volumes/MUSIC/"

## Quick way to rebuild the Launch Services database and get rid
## of duplicates in the "Open With" submenu.
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder"

#Tip: add 'alias cd="pushd &> /dev/null"' to your .bashrc; when you cd to a #directory you'll always be able to 'popd' back where you started.

# Remove all Docker containers that have exited
alias docker-purge="docker rm -v $(docker ps -a -q -f status=exited)"

## OpenStack
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

## Vagrant Setup
run_vgsetup() {
    cp -i ~/.vagrantfile-template.rb ./Vagrantfile && \
    cp -i ~/.vagrant-hosts.yaml ./vagrant-hosts.yaml
}

alias vgsetup=run_vgsetup


## Development ###########################################################################

## Homebrew Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

## Homebrew pyenv
export PYENV_VERSION=2.7.13
export PYENV_ROOT=/usr/local/var/pyenv

export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Projects"

## Homebrew rbenv
export RBENV_VERSION=2.4.1
export RBENV_ROOT=/usr/local/var/rbenv

## Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/1.8.0/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

## Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

## Maven
export M2_HOME="/usr/local/Cellar/maven/current/libexec"
export MAVEN_OPTS="-Xmx512m"
export PATH="$M2_HOME/bin:$PATH"

## Ant
export ANT_HOME="/usr/local/Cellar/ant/current/libexec"
export PATH="$ANT_HOME/bin:$PATH"

## Node
# export NPM_HOME="/usr/local/share/npm"
# export NODE_PATH="$NPM_HOME/lib/node_modules"
# export PATH="$NPM_HOME/bin:$PATH"

## VMware Fusion
export VMWAREVM_HOME="$HOME/Documents/Virtual Machines/VMware"
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"

## Vagrant
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
export VAGRANT_VMWARE_CLONE_DIRECTORY="${VMWAREVM_HOME}"

## Homebrew pyenv init
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi

## Homebrew rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
