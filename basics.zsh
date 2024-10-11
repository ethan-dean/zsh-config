#################################################################################
# Save command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=2000
SAVEHIST=1000
setopt hist_ignore_dups

#################################################################################
# Start terminal in downloads...
cd ~/Downloads
