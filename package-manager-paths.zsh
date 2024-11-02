#################################################################################
# File to make sure these package managers haven't been goofed (as I once have...)

# Path to brew installation (had problems with brew being in path at one point...)
if [[ ":$PATH:" != *":/opt/homebrew/bin:/opt/homebrew/Caskroom/"* ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/Caskroom/:$PATH"
fi
if [[ ":$PATH:" != *":/opt/homebrew/anaconda3/bin/"* ]]; then
    export PATH="/opt/homebrew/anaconda3/bin/:$PATH"
fi

# Conda initialize 
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
