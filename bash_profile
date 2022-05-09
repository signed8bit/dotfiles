if command -v pyenv > /dev/null; then
    export PYENV_ROOT="/usr/local/var/pyenv"
fi

source ~/.bashrc

# Homebrew pyenv init
if command -v pyenv > /dev/null; then
    eval "$(pyenv init --path)"	
    eval "$(pyenv init -)"
fi

# Homebrew rbenv init
if command -v rbenv > /dev/null; then 
    eval "$(rbenv init -)"; 
fi