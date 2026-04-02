#!/bin/bash
set -e

DOTFILES_DIR="${_REMOTE_USER_HOME}/.dotfiles"

apt-get update && apt-get install -y --no-install-recommends vim tmux
rm -rf /var/lib/apt/lists/*

su "${_REMOTE_USER}" -c "git clone ${REPOSITORY} ${DOTFILES_DIR}"

su "${_REMOTE_USER}" -c "ln -sf ${DOTFILES_DIR}/.aliases ${_REMOTE_USER_HOME}/.aliases"
su "${_REMOTE_USER}" -c "ln -sf ${DOTFILES_DIR}/.tmux.conf ${_REMOTE_USER_HOME}/.tmux.conf"
su "${_REMOTE_USER}" -c "ln -sf ${DOTFILES_DIR}/.gitconfig ${_REMOTE_USER_HOME}/.gitconfig"
su "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.oh-my-zsh/custom/themes"
su "${_REMOTE_USER}" -c "ln -sf ${DOTFILES_DIR}/.oh-my-zsh/custom/themes/my-theme.zsh-theme ${_REMOTE_USER_HOME}/.oh-my-zsh/custom/themes/my-theme.zsh-theme"

cat > "${_REMOTE_USER_HOME}/.zshrc" <<'ZSHRC'
export ZSH="$HOME/.oh-my-zsh"
source "$HOME/.dotfiles/.zshrc"
plugins=(git)
source $ZSH/oh-my-zsh.sh
ZSHRC

chown "${_REMOTE_USER}:${_REMOTE_USER}" "${_REMOTE_USER_HOME}/.zshrc"
