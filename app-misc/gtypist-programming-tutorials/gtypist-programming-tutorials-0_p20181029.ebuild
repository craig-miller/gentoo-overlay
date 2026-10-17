# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="1713d92b7c44f63dc1378ab2e9209a4a2ea69e72"

DESCRIPTION="GNU Typist lessons for programming symbols and code"
HOMEPAGE="https://github.com/codesections/gtypist_programming_characters"
SRC_URI="https://github.com/codesections/gtypist_programming_characters/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gtypist_programming_characters-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~arm64"
RESTRICT="mirror"

RDEPEND="app-misc/gtypist"

src_install() {
	insinto /usr/share/gtypist
	doins p.typ
	dodoc README.md
}

pkg_postinst() {
	elog "Programming symbols and code: gtypist p.typ"
	elog "Bundled numeric keypad course: gtypist n.typ"
}
