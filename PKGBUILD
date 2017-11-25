# Maintainer: Fawix <fawixfa@gmail.com>

pkgname=sddm-theme-nebula-git
pkgver=latest
pkgrel=1
pkgdesc="Nebula Theme for SDDM by Fawix"
arch=('any')
url="https://github.com/fawix/nebula-sddm-theme"
license=('CCPL:cc-by-sa')
depends=('sddm')
_theme_name='nebula'
_repo_name='nebula-sddm-theme'
source=("git+https://github.com/fawix/nebula-sddm-theme.git")
md5sums=('SKIP')

pkgver () {
	echo "$(git -C "${srcdir}/${_repo_name}" rev-list --count HEAD).0.0"
}

package() {
	install -d "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}"
	cp -r "${srcdir}/${_repo_name}"/* "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" /
	find "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" -type d -exec chmod 555 {} \;
	find "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" -type f -exec chmod 444 {} \;
}
