#!/usr/bin/zsh

# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2024 Thomas Letan <lthms@soap.coffee>

TASK=""

function start_task () {
  TASK="${1}"

  echo -n "[ ] ${TASK}"
}

function stop_task () {
  print -P "\r[%F{green}*%f] ${TASK}"
  TASK=""
}

function sanity_check () {
  local name="${1}"

  if [ -d "/var/lib/machines/${name}" ]; then
    echo "/var/lib/machines/${name} already exists"
    exit 2
  fi
  
  if [ -f "/etc/systemd/nspawn/${name}.nspawn" ]; then
    echo "/etc/systemd/nspawn/${name}.nspawn already exists" 
    exit 3
  fi

  if [ "$(whoami)" != "root" ]; then
    echo "not running as root"
    exit 4
  fi
}

COLOR=""
function pick_color () {
  local color=""
  local reply="n"

  while [ ${reply} = "n" ]; do
    color="$(shuf -i 1-255 -n 1)"
    color="${(l(3)(0))color}"
    print -nP "Picked %F{${color}}this color%f."
    read -q "reply? do you like it? (y/N) "
  done

  COLOR="${color}"
  echo ""
}

function install_nspawn_file () {
  local name="${1}"

  sed -e "s/%ZONE%/$(hostnamectl hostname)/" /usr/share/nspawn/nspawn.template \
    > "/etc/systemd/nspawn/${name}.nspawn"
}

function install_zshprofile_file () {
  local name="${1}"

  start_task "generate zshprofile"
  sed -e "s/%COLOR%/${COLOR}/" /usr/share/nspawn/zshprofile.template \
    > /var/lib/machines/${name}/etc/zsh/zshprofile
  stop_task
}

function mkdir_container () {
  local name="${1}"
  local fs="$(stat -f --format='%T' /var/lib/machines)"

  start_task "init container directory"
  
  case "${fs}" in
    "btrfs")
      btrfs -q subvolume create "/var/lib/machines/${name}"
      ;;
    *)
      mkdir -p "/var/lib/machines/${name}"
  esac

  stop_task
}

function install_container_system () {
  local name="${1}"
  local stdout="$(mktemp)"
  local stderr="$(mktemp)"

  start_task "install container system"
  pacstrap -K -c "/var/lib/machines/${name}/" \
    base sudo openssh neovim zsh kitty-terminfo \
    > "${stdout}" 2> "${stderr}"

  if [ "$?" != "0" ]; then
    echo "----[stdout]----\n$(cat ${stdout})"
    echo "----[stderr]----\n$(cat ${stderr})"
  fi

  rm "${stdout}" "${stderr}"
  stop_task
}

function install_init_script () {
  local name="${1}"

  start_task "install init script"
  cp "/usr/share/nspawn/init.sh" "/var/lib/machines/${name}/usr/local/bin/init.sh"
  stop_task
}

function start_container () {
  local name="${1}"

  start_task "start container"
  machinectl -q start ${name}
  stop_task
}

function init_container () {
  local name="${1}"
  local stdout="$(mktemp)"
  local stderr="$(mktemp)"

  start_task "configure container"
  machinectl shell "${name}" /usr/bin/bash -c "/usr/local/bin/init.sh && rm /usr/local/bin/init.sh" \
    > "${stdout}" 2> "${stderr}"

  if [ "$?" != "0" ]; then
    echo "----[stdout]----\n$(cat ${stdout})"
    echo "----[stderr]----\n$(cat ${stderr})"
  fi

  rm "${stdout}" "${stderr}"
  stop_task
}

function main () {
  local name="${1}"

  sanity_check "${name}"
  pick_color

  mkdir_container "${name}"

  install_container_system "${name}"
  install_zshprofile_file "${name}"
  install_nspawn_file "${name}"
  install_init_script "${name}"

  start_container "${name}"
  init_container "${name}"
}

if [ "$#" -ne 1 ]; then
	echo "usage: $0 MACHINE_NAME"
	exit 1
fi

main "${1}"
