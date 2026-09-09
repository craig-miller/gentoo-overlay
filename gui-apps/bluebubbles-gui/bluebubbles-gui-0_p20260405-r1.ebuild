# Copyright 2026 Craig Miller
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module optfeature xdg

BLUEBUBBLES_GUI_COMMIT="340408bcc1408fb25ec8e6660b3cc0874b3c2a12"
DEPS_URI="https://github.com/craig-miller/zentoo-overlay/releases/download/${P}"

DESCRIPTION="Fyne desktop client for the BlueBubbles iMessage server"
HOMEPAGE="https://github.com/oovets/bluebubbles-gui"
SRC_URI="
	https://github.com/oovets/${PN}/archive/${BLUEBUBBLES_GUI_COMMIT}.tar.gz -> ${P}.tar.gz
	${DEPS_URI}/${P}-deps.tar.xz
"
S="${WORKDIR}/${PN}-${BLUEBUBBLES_GUI_COMMIT}"

LICENSE="Apache-2.0 BSD BSD-2 ISC LGPL-3 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~arm64"

PATCHES=(
	"${FILESDIR}"/${PN}-0_p20260405-chat-list-width.patch
)

DEPEND="
	dev-libs/wayland
	virtual/opengl
	x11-libs/libX11
	x11-libs/libxkbcommon
"
RDEPEND="
	${DEPEND}
	app-admin/pass
"
BDEPEND+="
	dev-libs/wayland-protocols
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_compile() {
	ego build -tags wayland -o bluebubbles-gui ./cmd/gui
	ego build -o bluebubbles-preview-proxy ./cmd/preview-proxy
}

src_install() {
	dobin bluebubbles-gui bluebubbles-preview-proxy
	newbin "${FILESDIR}"/bluebubbles-gui-launcher bluebubbles-gui-launcher
	newicon packaging/bluebubbles-gui.svg bluebubbles-gui.svg
	make_desktop_entry bluebubbles-gui-launcher "BlueBubbles GUI" bluebubbles-gui "Network;InstantMessaging;Chat;"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "Secret Service password storage" virtual/secret-service
	elog "The desktop launcher reads credentials from pass entries:"
	elog "  api/bluebubbles/server_url"
	elog "  api/bluebubbles/password"
	elog "The bare bluebubbles-gui binary can still read BB_SERVER_URL and BB_PASSWORD"
	elog "from the environment, or store credentials after the first-run setup wizard."
	elog "For high-DPI displays, launch with FYNE_SCALE=1.3 or similar if fonts look jagged."
	elog "The optional preview proxy is installed as /usr/bin/bluebubbles-preview-proxy."
}
