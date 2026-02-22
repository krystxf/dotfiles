# dotfiles
It ain't much, but it's honest work

## Install

Requires [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

```sh
ansible-galaxy collection install community.general && \
  ansible-playbook -c local -i localhost, \
  "https://raw.githubusercontent.com/krystxf/dotfiles/main/install.yml"
```

This will clone the repo to `~/.dotfiles`, install tmux and zsh, set zsh as the default shell, install oh-my-zsh, and symlink all configs into `$HOME`.
