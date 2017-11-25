# Maintainer: Fawix <fawixfa@gmail.com>

_theme_name='nebula'
_repo_name='nebula-sddm-theme'

pkgname=$_repo_name-git
pkgver=1.0.r5.gf09b0a2
pkgrel=1
pkgdesc="Nebula Theme for SDDM by Fawix"
arch=('any')
url="https://github.com/fawix/nebula-sddm-theme"
license=('CCPL:cc-by-sa')
depends=('sddm')
optdepends=('ttf-droid'
			'python2-powerline') 
makedepends=('git')
source=("git+https://github.com/fawix/nebula-sddm-theme.git")
md5sums=('SKIP')

pkgver () {
	cd $_repo_name

	local _ver=$(awk -F '=' '/Version/ {print $2}' $_theme_name/metadata.desktop)
	printf '%s.r%s.g%s' "$_ver" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
	
}


package() {
	install -Dm644 -t "$pkgdir/user/share/sddm/themes/$_theme_name" $_repo_name/$_theme_name/*
#	install -d "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}"
#	cp  "${srcdir}/${_repo_name}"/* "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" /
#	find "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" -type d -exec chmod 555 {} \;
#	find "${pkgdir}"/usr/share/sddm/themes/"${_theme_name}" -type f -exec chmod 444 {} \;
}
