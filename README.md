# `nspawn`

Opinionated helper to help me create `systemd-nspawn` containers.

This package assumes the following about the host system:

- The user `lthms` exists
- The system-wide ZSH configuration file (`/etc/zsh/zshrc`) exists
- The system-wide Neovim configuration file (`/etc/xdg/nvim/sysinit.vim`)
  exists
- The system Ed25519 SSH key (`/etc/ssh/ssh_host_ed25519_key` and
  `/etc/ssh/ssh_host_ed25519_key.pub`) exists
