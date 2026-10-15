# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

COMMIT="058bd7a2f33d6ad5ef1df985b3db403622016a8c"

DESCRIPTION="Variable sans-serif font family with upright and italic styles"
HOMEPAGE="https://fonts.google.com/specimen/Nunito+Sans https://github.com/googlefonts/NunitoSans"
SRC_URI="https://github.com/googlefonts/NunitoSans/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/NunitoSans-${COMMIT}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"

FONT_S="${S}/fonts/variable"
FONT_SUFFIX="ttf"
DOCS=( README.md )
