# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2024 Thomas Letan <lthms@soap.coffee>

.PHONY: pkg all update install

pkg:
	@makepkg -f
update:
	@updpkgsums
	@makepkg --printsrcinfo > .SRCINFO

install: pkg
	@makepkg -i

all: update pkg
