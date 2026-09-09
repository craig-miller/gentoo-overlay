# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 pypi

DESCRIPTION="A simple icalendar-based todo manager"
HOMEPAGE="https://github.com/pimutils/todoman https://todoman.readthedocs.io/"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/click-7.1[${PYTHON_USEDEP}]
	<dev-python/click-9.0[${PYTHON_USEDEP}]
	>=dev-python/click-log-0.2.1[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
	>=dev-python/icalendar-4.0.3[${PYTHON_USEDEP}]
	dev-python/parsedatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
"

DOCS=( AUTHORS.rst CHANGELOG.rst CONTRIBUTING.rst README.rst )

src_prepare() {
	default

	# Upstream's pyproject.toml omits build-backend, but distutils-r1
	# requires it for PEP 517 builds. It must be set inside [build-system].
	python - <<-EOF || die
		from pathlib import Path
		path = Path("pyproject.toml")
		text = path.read_text()
		old = '[build-system]\nrequires = ["setuptools>=77", "wheel", "setuptools_scm>=6.2"]\n'
		new = old + 'build-backend = "setuptools.build_meta"\n'
		path.write_text(text.replace(old, new, 1))
	EOF
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
