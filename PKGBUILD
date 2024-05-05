# Maintainer: Thomas Letan <lthms@soap.coffee>

pkgname=nspawn
pkgver=1
pkgrel=1
pkgdesc='Helper to create systemd-nspawn containers'
url=https://github.com/lthms/nspawn
license=('MPL-2')
arch=('x86_64')
depends=(
  'systemd'
)
source=(
  'nspawn.zsh'
  'init.sh'
  'nspawn.template'
  'zshprofile.template'
)
sha512sums=(
  'c57a22088aaf0de1ab8cdfc302c80480811ec91661a605af23fbd0659ebe9d8f95e4c25a22022bdb07a78803f592d28bb9922c5804c687ce42c7984c7ec0ec09'
  'c999a72818b8516c773fce013e4904b22e6f303303c92a5a9df2fa6e27a27bda0b0ebb4a43253cb79387fd1a374139e8dcbb54787fc88022b444ff5e567cbc16'
  'd2f4f78d8508f5d0cf4e0de823c9c73fa65a8b409bce95ca48448f91ebc3cdcf68c9c47ff7c08a0c5fd365c59693110e334433059df296ad988e916fd9fb8e2f'
  'a08f48ddcf4623569a0642080643150c6d4e18d225baa65861735f4671f765a3a7c5f708938dbe4317749d8d98cd2f45d7d3b78541d1a11338e320d1cadcffa0'
)

package() {
  cd "$srcdir"
  install -Dm 755 "nspawn.zsh" "$pkgdir/usr/bin/nspawn"
  install -Dm 755 "init.sh" "$pkgdir/usr/share/nspawn/init.sh"
  install -Dm 644 "nspawn.template" "$pkgdir/usr/share/nspawn/nspawn.template"
  install -Dm 644 "zshprofile.template" "$pkgdir/usr/share/nspawn/zshprofile.template"
}
