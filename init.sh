#!/usr/bin/bash

chsh -s /bin/zsh
usermod -a -G wheel lthms
systemctl enable --now systemd-networkd
systemctl enable --now systemd-resolved
systemctl enable --now sshd
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chown root:root /etc/zsh/zshprofile
chmod o+r /etc/zsh/zshprofile
echo "HostKey /etc/ssh/ssh_host_ed25519_key" > /etc/ssh/sshd_config
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
