# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-env go-module

DESCRIPTION="Terminal-based typing practice and speed tester"
HOMEPAGE="https://github.com/bloznelis/typioca"
SRC_URI="https://github.com/bloznelis/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

# Fetch pinned module files through Portage, then expose them as a local Go
# proxy. This keeps builds offline without a separately hosted vendor archive.
GO_MODULES="
	dario.cat/mergo@v1.0.0
	github.com/!burnt!sushi/toml@v1.4.0
	github.com/!make!now!just/heredoc@v1.0.0
	github.com/!microsoft/go-winio@v0.6.1
	github.com/!proton!mail/go-crypto@v1.0.0
	github.com/anmitsu/go-shlex@v0.0.0-20200514113438-38f4b401e2be
	github.com/atotto/clipboard@v0.1.4
	github.com/aymanbagabas/go-osc52/v2@v2.0.1
	github.com/aymanbagabas/go-udiff@v0.2.0
	github.com/charmbracelet/bubbles@v0.20.0
	github.com/charmbracelet/bubbletea@v1.1.1
	github.com/charmbracelet/harmonica@v0.2.0
	github.com/charmbracelet/keygen@v0.5.1
	github.com/charmbracelet/lipgloss@v0.13.0
	github.com/charmbracelet/log@v0.4.0
	github.com/charmbracelet/ssh@v0.0.0-20240725163421-eb71b85b27aa
	github.com/charmbracelet/wish@v1.4.3
	github.com/charmbracelet/x/ansi@v0.2.3
	github.com/charmbracelet/x/conpty@v0.1.0
	github.com/charmbracelet/x/errors@v0.0.0-20240508181413-e8d8b6e2de86
	github.com/charmbracelet/x/exp/golden@v0.0.0-20240815200342-61de596daa2b
	github.com/charmbracelet/x/input@v0.2.0
	github.com/charmbracelet/x/term@v0.2.0
	github.com/charmbracelet/x/termios@v0.1.0
	github.com/cloudflare/circl@v1.3.7
	github.com/cpuguy83/go-md2man/v2@v2.0.4
	github.com/creack/pty@v1.1.21
	github.com/cyphar/filepath-securejoin@v0.2.4
	github.com/davecgh/go-spew@v1.1.1
	github.com/dustin/go-humanize@v1.0.1
	github.com/emirpasic/gods@v1.18.1
	github.com/erikgeiser/coninput@v0.0.0-20211004153227-1c3628e74d0f
	github.com/go-git/gcfg@v1.5.1-0.20230307220236-3a3c6141e376
	github.com/go-git/go-billy/v5@v5.5.0
	github.com/go-git/go-git/v5@v5.12.0
	github.com/go-logfmt/logfmt@v0.6.0
	github.com/golang/groupcache@v0.0.0-20210331224755-41bb18bfe9da
	github.com/google/go-cmp@v0.6.0
	github.com/guptarohit/asciigraph@v0.7.1
	github.com/hashicorp/golang-lru/v2@v2.0.7
	github.com/inconshreveable/mousetrap@v1.1.0
	github.com/jbenet/go-context@v0.0.0-20150711004518-d14ea06fba99
	github.com/kevinburke/ssh_config@v1.2.0
	github.com/kirsle/configdir@v0.0.0-20170128060238-e45d2f54772f
	github.com/kylelemons/godebug@v1.1.0
	github.com/lucasb-eyer/go-colorful@v1.2.0
	github.com/matryer/is@v1.4.1
	github.com/mattn/go-isatty@v0.0.20
	github.com/mattn/go-localereader@v0.0.1
	github.com/mattn/go-runewidth@v0.0.16
	github.com/muesli/ansi@v0.0.0-20230316100256-276c6243b2f6
	github.com/muesli/cancelreader@v0.2.2
	github.com/muesli/reflow@v0.3.0
	github.com/muesli/termenv@v0.15.3-0.20240509142007-81b8f94111d5
	github.com/pjbgf/sha1cd@v0.3.0
	github.com/pmezard/go-difflib@v1.0.0
	github.com/rivo/uniseg@v0.4.7
	github.com/russross/blackfriday/v2@v2.1.0
	github.com/sahilm/fuzzy@v0.1.1
	github.com/sergi/go-diff@v1.3.2-0.20230802210424-5b0b94c5c0d3
	github.com/skeema/knownhosts@v1.2.2
	github.com/spf13/cobra@v1.8.1
	github.com/spf13/pflag@v1.0.5
	github.com/stretchr/testify@v1.9.0
	github.com/xanzy/ssh-agent@v0.3.3
	github.com/xo/terminfo@v0.0.0-20220910002029-abceb7e1c41e
	golang.org/x/crypto@v0.26.0
	golang.org/x/exp@v0.0.0-20231006140011-7918f672742d
	golang.org/x/mod@v0.17.0
	golang.org/x/net@v0.25.0
	golang.org/x/sync@v0.8.0
	golang.org/x/sys@v0.24.0
	golang.org/x/term@v0.23.0
	golang.org/x/text@v0.17.0
	golang.org/x/time@v0.6.0
	golang.org/x/tools@v0.21.1-0.20240508182429-e35e4ccd0d2d
	gopkg.in/check.v1@v0.0.0-20161208181325-20d25e280405
	gopkg.in/warnings.v0@v0.1.2
	gopkg.in/yaml.v3@v3.0.1
"
for module in ${GO_MODULES}; do
	for ext in zip mod info; do
		SRC_URI+=" https://proxy.golang.org/${module%@*}/@v/${module##*@}.${ext} -> ${PN}-${module//\//_}.${ext}"
	done
done
unset module ext

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"
RDEPEND="gui-apps/foot"

src_unpack() {
	unpack "${P}.tar.gz"
	local module ext path version
	for module in ${GO_MODULES}; do
		path="${module%@*}"
		version="${module##*@}"
		mkdir -p "${T}/go-proxy/${path}/@v" || die
		for ext in zip mod info; do
			cp "${DISTDIR}/${PN}-${module//\//_}.${ext}" \
				"${T}/go-proxy/${path}/@v/${version}.${ext}" || die
		done
	done
	export GOPROXY="file://${T}/go-proxy"
	export GOSUMDB=off
	go-env_set_compile_environment
}

src_compile() {
	ego build -mod=readonly -trimpath \
		-ldflags "-X github.com/bloznelis/typioca/cmd.Version=${PV}" \
		-o typioca .
}

src_test() {
	ego test -mod=readonly ./...
}

src_install() {
	dobin typioca
	domenu "${FILESDIR}/typioca.desktop"
	einstalldocs
}
