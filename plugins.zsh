#################################################################################
# Plugins currently in use:
# ==========================
# - fzf (fuzzy finder)
# - fd  (list path candidates)
# - eza (better ls, used by fzf/fd)
# - bat (better cat, used by fzf/fd)
# - zoxide (better cd)
# 
# Additional Scripts:
# ===================
# - fzf-git (git support?)

#################################################################################
# Setup FZF and FD using BAT and EZA
# <Ctrl-t> to start fuzzyfinder, <Ctrl-c> to close it
eval "$(fzf --zsh)"
# --- setup fzf theme ---
fg="#E0E0E0"
bg="#181818"
bg_highlight="#303030"
blue="#4486d4"
cyan="#97d7ef"
green="#88FF88"
darkgreen="#55A055"
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${darkgreen},fg+:${fg},bg+:${bg_highlight},hl+:${green},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# Source script for additional git stuff
source ~/fzf-git/fzf-git.sh
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

#################################################################################
# Bat (better cat) 
export BAT_THEME=tokyonight_night

#################################################################################
# Eza (better ls) 
alias ls="eza -a --icons=always"

#################################################################################
# Zoxide (better cd) 
eval "$(zoxide init zsh)"
alias cd="z"
