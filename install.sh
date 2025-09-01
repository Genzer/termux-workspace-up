#!/usr/bin/env bash
set -e -u -o pipefail

install_pkgs() {
  # Install packages
  pkg install -y \
    zsh \
    vim \
    git \
    tmux \
    dnsutils \
    mandoc \
    tree
}

change_shell_zsh() {
  # Change shell to Zsh
  chsh -s zsh
}


bootstrap_zsh() {
  # Bootstrapp Zsh to use a different directory for .zshrc.
  touch ~/.zshenv
  echo 'export ZDOTDIR="$HOME/.config/zsh"' >~/.zshenv
}

configure_home() {
  echo '[info] - Install ~/.config'
  ln -s "$(pwd)/config" "$HOME/.config"

}

main() {
  install_pkgs
  change_shell_zsh
  bootstrap_zsh

  configure_home
}

main "$@"

