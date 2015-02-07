# ------
# Prompt
# ------

export PS1="\u@\h [\W] % " 

# -----
# Color
# -----
export CLICOLOR='true'

# ------
# Editor
# ------
export EDITOR="bbedit --wait --resume"

# ----
# Path
# ----
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

# -----------------------
# Development Environment
# -----------------------

# Set a more reasonable file limit
ulimit -n 1024

# Python
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

export PYENV_ROOT="/usr/local/opt/pyenv"
export PATH="/usr/local/opt/ccache/libexec:$PATH"
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Projects"

source virtualenvwrapper.sh

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/1.7.0/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Maven
export M2_HOME="/usr/local/maven"
export MAVEN_OPTS="-Xmx512m"
export PATH="$M2_HOME/bin:$PATH"

# Ant
export ANT_HOME="/usr/local/ant"
export PATH="$ANT_HOME/bin:$PATH"

# Buck
export BUCK_HOME="$HOME/Projects/buck"
export PATH="$BUCK_HOME/bin:$PATH"

# Gerrit
export GERRIT_HOME="$HOME/Projects/gerrit/gerrit-testsite"

# Ruby
export RUBY_HOME="/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr"
export GEM_HOME="/Library/Ruby/Gems/2.0.0/gems"
export PATH="/Users/Mattmont/.gem/ruby/2.0.0/bin:$PATH"

# Node
export NPM_HOME="/usr/local/share/npm"
export NODE_PATH="$NPM_HOME/lib/node_modules"
export PATH="$NPM_HOME/bin:$PATH"

# VMware Fusion
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"

# Vagrant
export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="$HOME/Documents/Virtual Machines/VMware"

# AWS CLI Scripting
export PATH="$HOME/Projects/scripting/aws-cli-scripting/bin:$PATH"
export EC2_SSH_USER="ubuntu"
export EC2_SSH_PROFILE="default"

# Needed to work around errors with the newer clang that comes with Xcode 5.1
export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

# Aliases ----------------------------------------------------------------------

# -------
# General
# -------

# Utility
alias cls="clear"
alias rm="rm -i"
alias bb="bbedit"
alias recent="ls -lthr | tail"
alias md5="openssl md5"
alias vg="vagrant"
alias dpaste="curl -F 'content=<-' http://dpaste.cisco.com/api/"

alias grepjars="find ./ -name \"*.jar\" -exec echo {} \; -exec jar -tf {} \; | grep -e \".jar\" -e $1"

alias sync-music="rsync -avz --include '*/' --include '*.mp3' --include '*.m4a' --exclude '*' /Volumes/Media/Music/ /Volumes/MUSIC/"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the "Open With" submenu.
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder"

#Tip: add 'alias cd="pushd &> /dev/null"' to your .bashrc; when you cd to a #directory you'll always be able to 'popd' back where you started.

# -----------
# Development
# -----------

# MySQL
alias start-mysql="/usr/local/bin/mysql.server start"
alias stop-mysql="/usr/local/bin/mysql.server stop"

# Redis
alias start-redis="redis-server /usr/local/etc/redis.conf"

# OpenStack
run_osapi() {
    pathToFile=$HOME/.openstack/${1}.sh

    if [[ -f "${pathToFile}" ]]; then
        source ${pathToFile}   
    else
       echo "Usage: osapi [profile]"
    fi
}

alias osapi=run_osapi

# Gerrit Setup
run_gerritsetup() {
    git remote add gerrit `git remote -v | grep -m 1 -o 'ssh://.* '` &&
    git review -s
}

alias gerritsetup=run_gerritsetup

# Vagrant Setup
run_vgsetup() {
    cp -i ~/.vagrantfile-template.rb ./Vagrantfile && \
    cp -i ~/.vagrant-hosts.yml ./vagrant-hosts.yml
}

alias vgsetup=run_vgsetup
