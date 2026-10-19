# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	anyhow@1.0.97
	autocfg@1.4.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.9.0
	block@0.1.6
	byteorder@1.5.0
	cairo-rs@0.20.7
	cairo-sys-rs@0.20.7
	cc@1.2.17
	cfg-expr@0.17.2
	cfg-expr@0.8.1
	cfg-expr@0.9.1
	cfg-if@1.0.0
	colorchoice@1.0.3
	convert_case@0.4.0
	cssparser-macros@0.6.1
	cssparser@0.27.2
	ctor-proc-macro@0.0.5
	ctor@0.4.2
	derive_more@0.99.19
	dtoa-short@0.3.5
	dtoa@1.0.10
	dtor-proc-macro@0.0.5
	dtor@0.0.6
	either@1.15.0
	env_filter@0.1.3
	env_logger@0.11.8
	equivalent@1.0.2
	field-offset@0.3.6
	foldhash@0.1.5
	futf@0.1.5
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	fxhash@0.2.1
	gdk-pixbuf-sys@0.20.7
	gdk-pixbuf@0.20.9
	gdk4-sys@0.9.6
	gdk4@0.9.6
	getrandom@0.1.16
	getrandom@0.3.2
	gettext-rs@0.7.2
	gettext-sys@0.22.5
	gio-sys@0.14.0
	gio-sys@0.20.9
	gio@0.14.8
	gio@0.20.9
	glib-macros@0.14.1
	glib-macros@0.20.7
	glib-sys@0.14.0
	glib-sys@0.20.9
	glib@0.14.8
	glib@0.20.9
	gmime-sys@0.8.1
	gmime@0.8.1
	gobject-sys@0.14.0
	gobject-sys@0.20.9
	graphene-rs@0.20.9
	graphene-sys@0.20.7
	gsk4-sys@0.9.6
	gsk4@0.9.6
	gtk4-macros@0.9.5
	gtk4-sys@0.9.6
	gtk4@0.9.6
	hashbrown@0.15.3
	heck@0.3.3
	heck@0.5.0
	hex@0.4.3
	html5ever@0.25.2
	indexmap@2.8.0
	is-docker@0.2.0
	is-wsl@0.4.0
	is_terminal_polyfill@1.70.1
	itertools@0.10.5
	itoa@0.4.8
	itoa@1.0.15
	javascriptcore6-sys@0.4.0
	javascriptcore6@0.4.0
	jiff-static@0.2.5
	jiff@0.2.5
	lazy_static@1.5.0
	libadwaita-sys@0.7.2
	libadwaita@0.7.2
	libc@0.2.171
	locale_config@0.3.0
	lock_api@0.4.12
	log@0.4.27
	mac@0.1.1
	malloc_buf@0.0.6
	markup5ever@0.10.1
	matches@0.1.10
	memchr@2.7.4
	memoffset@0.9.1
	msg_parser@0.1.1
	new_debug_unreachable@1.0.6
	nipper@0.1.9
	nodrop@0.1.14
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.21.1
	open@5.3.2
	pango-sys@0.20.9
	pango@0.20.9
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pathdiff@0.2.3
	phf@0.8.0
	phf_codegen@0.8.0
	phf_generator@0.11.3
	phf_generator@0.8.0
	phf_macros@0.8.0
	phf_shared@0.11.3
	phf_shared@0.8.0
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	portable-atomic-util@0.2.4
	portable-atomic@1.11.0
	ppv-lite86@0.2.21
	precomputed-hash@0.1.1
	proc-macro-crate@1.3.1
	proc-macro-crate@3.3.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro-hack@0.5.20+deprecated
	proc-macro2@1.0.94
	quote@1.0.40
	r-efi@5.2.0
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	rand_pcg@0.2.1
	redox_syscall@0.5.10
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rustc_version@0.4.1
	ryu@1.0.20
	scopeguard@1.2.0
	selectors@0.22.0
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	serde_spanned@0.6.8
	servo_arc@0.1.1
	shlex@1.3.0
	siphasher@0.3.11
	siphasher@1.0.1
	slab@0.4.9
	smallvec@1.14.0
	soup3-sys@0.7.0
	soup3@0.7.0
	stable_deref_trait@1.2.0
	string_cache@0.8.8
	string_cache_codegen@0.5.4
	strum@0.21.0
	strum_macros@0.21.1
	syn@1.0.109
	syn@2.0.100
	system-deps@3.2.0
	system-deps@5.0.0
	system-deps@7.0.3
	target-lexicon@0.12.16
	temp-dir@0.1.14
	tendril@0.4.3
	thin-slice@0.1.1
	thiserror-impl@1.0.69
	thiserror@1.0.69
	toml@0.5.11
	toml@0.8.20
	toml_datetime@0.6.8
	toml_edit@0.19.15
	toml_edit@0.22.24
	unicode-ident@1.0.18
	unicode-segmentation@1.12.0
	utf-8@0.7.6
	utf8parse@0.2.2
	uuid@1.16.0
	version-compare@0.0.11
	version-compare@0.2.0
	version_check@0.9.5
	wasi@0.14.2+wasi-0.2.4
	wasi@0.9.0+wasi-snapshot-preview1
	webkit6-sys@0.4.0
	webkit6@0.4.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.7.4
	wit-bindgen-rt@0.39.0
	zerocopy-derive@0.8.24
	zerocopy@0.8.24
"

RUST_MIN_VER="1.83.0"

inherit cargo gnome2-utils meson xdg

MAILVIEWER_COMMIT="c43abf691b270705288e62fd723048d41f590cfe"

DESCRIPTION="GTK4 viewer for EML and Outlook MSG email files"
HOMEPAGE="https://github.com/alescdb/mailviewer"
SRC_URI="
	https://github.com/alescdb/${PN}/archive/${MAILVIEWER_COMMIT}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${MAILVIEWER_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~arm64"
RESTRICT="mirror"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gmime:3.0
	gui-libs/gtk:4
	>=gui-libs/libadwaita-1.7:1
	>=net-libs/webkit-gtk-2.40:6
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/glib-utils
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-portage-cargo.patch" )

src_configure() {
	cargo_src_configure
	meson_src_configure
}

src_compile() {
	meson_src_compile
	MESON_BUILD=1 cargo_src_compile
}

src_test() {
	# Attachment tests need a writable runtime directory in Portage's sandbox.
	local -x XDG_RUNTIME_DIR="${T}/runtime"
	mkdir -p "${XDG_RUNTIME_DIR}" || die
	chmod 700 "${XDG_RUNTIME_DIR}" || die
	MESON_BUILD=1 cargo_src_test
}

src_install() {
	meson_src_install
	dobin "$(cargo_target_dir)/${PN}"
	insinto /usr/share/mime/packages
	doins "${FILESDIR}/io.github.alescdb.mailviewer.xml"
	einstalldocs
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
