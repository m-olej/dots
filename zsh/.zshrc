# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh
eval "$(fnm env --use-on-cd --shell zsh)"

# Define your target config directory
local conf_dir="${ZDOTDIR:-$HOME}/.zshrc.d"

# Only proceed if the directory exists
if [[ -d "$conf_dir" ]]; then
  
  # Loop through all .sh and .zsh files.
  # (N)  = Null glob (don't error if empty)
  # (n)  = Numeric sort (ensures 2-file.zsh loads before 10-file.zsh)
  local conf_file
  for conf_file in "$conf_dir"/*.{sh,zsh}(Nn); do
    
    # Ignore hidden files (starts with .) and editor backups (ends with ~)
    if [[ "${conf_file:t}" != .* && "${conf_file:t}" != *~ ]]; then
      source "$conf_file"
    fi
    
  done
else
  echo >&2 "zshrc.d: Configuration directory not found at '$conf_dir'."
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

unsetopt correct_all

bindkey -v
export KEYTIMEOUT=1

# --- PATH Updates --- #

export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.asdf/shims:$PATH"


# --- Aliases --- #

alias ssh='TERM=xterm-256color EDITOR=vi /usr/bin/ssh'
alias via='via & disown'

