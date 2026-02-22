# dotfiles
It ain't much, but it's honest work

## Install

Requires [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

```sh
# Install community.general collection (needed for Homebrew module)
ansible-galaxy collection install community.general

# Run the playbook
ansible-playbook install.yml
```

This will install tmux, oh-my-zsh (if not already present), and symlink all configs into `$HOME`.
