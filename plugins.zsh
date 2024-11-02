#################################################################################
# Shell plugins currently in use:
# ===============================
# - fzf (fuzzy finder)
# - fd  (list path candidates)
# - eza (better ls)
# - bat (better cat)
# - zoxide (better cd)
#
# Self-Download:
# ===============================
# - zinit (package manager)

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in OMZ Plugins Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

# Replays all cached completions
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell Integrations (installed via brew) 
alias ls="eza -a --icons=always"    # Eza (better ls) 
export BAT_THEME=tokyonight_night   # Bat (better cat) 
eval "$(zoxide init --cmd cd zsh)"  # Zoxide (better cd)
eval "$(fzf --zsh)"                 # Fzf (fuzzyfinder)
# <Ctrl-r> to start reverse command history search
# <Ctrl-c> to close fzf
