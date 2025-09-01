prepare_xdg_directories() {
  export XDG_CONFIG_HOME="$HOME/.config/"
  export XDG_STATE_HOME="$HOME/.local/state"
  export XDG_BIN_HOME="$HOME/.local/bin/"

  mkdir -p "$XDG_CONFIG_HOME"
  mkdir -p "$XDG_STATE_HOME"
  mkdir -p "$XDG_BIN_HOME"

  export PATH="$XDG_BIN_HOME:$PATH"
}

zsh_config() {
  mkdir -p "$XDG_STATE_HOME/zsh/"
  HISTFILE="$XDG_STATE_HOME/zsh/zsh_history"
  SAVEHIST=100000
  HISTSIZE=100000
  setopt SHARE_HISTORY
  setopt INC_APPEND_HISTORY
  setopt HIST_EXPIRE_DUPS_FIRST
}

default_envars() {
  # Fix man does not know PAGER
  export PAGER=less
  export EDITOR=vim
}

set_aliases() {
  alias ll='ls -hal'
}

start_starship() {
  eval "$(starship init zsh)"
}

start_tmux() {
  if tmux list-sessions >/dev/null 2>&1; then
    if [[ ! -v TMUX ]]; then
    tmux attach-session -t work
    fi  
  else
    tmux new-session -s work
  fi
}

start_ssh_agent() {
  if [[ ! -v SSH_AUTH_SOCK ]]; then
    eval "$(ssh-agent -s)"
  fi
}

main() {
  prepare_xdg_directories
  default_envars
  zsh_config
  set_aliases
  start_starship
  start_tmux
  start_ssh_agent
}

main "$@"

