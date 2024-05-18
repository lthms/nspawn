# Maintainer: Thomas Letan <lthms@soap.coffee>

pkgname=nspawn
pkgver=5
pkgrel=1
pkgdesc='Helper to create systemd-nspawn containers'
url=https://github.com/lthms/nspawn
license=('MPL-2.0')
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
sha256sums=('0332165e6034f824617524866c27d839aa32810cb06123d499f702ede3c898d3'
            '0ef333429fc826bc47fc634902cd9495e2386b6976b2aa85a14b945cf0cb213c'
            'b092fc3300e6e85fa1be743701423b4c12b4f2d906850bfb3316b48cd414ff94'
            '9d33ade41b246cad8d03458f97e3f64694cd615cbf19b80340e06e483614766f')

package() {
  cd "$srcdir"
  install -Dm 755 "nspawn.zsh" "$pkgdir/usr/bin/nspawn"
  install -Dm 755 "init.sh" "$pkgdir/usr/share/nspawn/init.sh"
  install -Dm 644 "nspawn.template" "$pkgdir/usr/share/nspawn/nspawn.template"
  install -Dm 644 "zshprofile.template" "$pkgdir/usr/share/nspawn/zshprofile.template"
}
