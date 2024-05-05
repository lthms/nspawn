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
sha256sums=('d42963dcfecee4c0f99addd8faf1204afbd490dee89cbae3844bba526f7b3b2a'
            'a82e3d3ad2c8f9865e993a52118b2365062d084ff5cd8d66a894ec18f51862fc'
            'be87f50e86d6b2ae9db8317b2c04b3086fa1694787edb13a68c4163d3d38f4c0'
            '9d33ade41b246cad8d03458f97e3f64694cd615cbf19b80340e06e483614766f')

package() {
  cd "$srcdir"
  install -Dm 755 "nspawn.zsh" "$pkgdir/usr/bin/nspawn"
  install -Dm 755 "init.sh" "$pkgdir/usr/share/nspawn/init.sh"
  install -Dm 644 "nspawn.template" "$pkgdir/usr/share/nspawn/nspawn.template"
  install -Dm 644 "zshprofile.template" "$pkgdir/usr/share/nspawn/zshprofile.template"
}
