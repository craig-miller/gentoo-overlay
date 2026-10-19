# gentoo-overlay

My Gentoo Portage overlay, with additional packages, pinned versions, and local patches for a Wayland desktop on Apple Silicon running Asahi Linux.

This overlay supplements the main Gentoo repository and GURU. Package availability and architecture support vary; consult each ebuild's keywords and dependencies before installing.

## Selected packages

| Package | Purpose |
| --- | --- |
| `app-crypt/pinentry-config` | Automatic GUI or terminal GPG pinentry selection |
| `app-laptop/asahi-brightnessd` | Ambient-light display and keyboard brightness control for Apple Silicon |
| `app-misc/ndi-cast` | Broadcast the desktop as an NDI source; integrates with the [Noctalia plugins](https://github.com/craig-miller/noctalia-plugins) |
| `app-misc/vimb-blocklist` | Native ad, tracker, and cookie-banner filtering for vimb |
| `app-portage/pycargoebuild` | Backported Rust ebuild generation tooling |
| `app-text/research-tools` | Research and PKM integration for Sioyek, Typst, and paper notes |
| `dev-util/adblock-rust-cli` | Convert filter lists to WebKit content-blocking rules |
| `gui-apps/noctalia-greeter` | Noctalia-themed login interface for greetd |
| `gui-apps/noctalia-shell` | Wayland desktop shell |
| `gui-apps/soundthemed` | Freedesktop sound-theme daemon |
| `mail-client/mailviewer` | GTK4 viewer for EML and Outlook MSG files |
| `sys-boot/grub` | Patched GRUB for a quieter boot sequence |
| `sys-boot/u-boot` | Patched Asahi U-Boot with quiet console output and zero autoboot delay |
| `www-client/vimb` | Vim-like browser with GTK4, WebKitGTK 6, and native content filtering |

This is a selection, not a complete package index. Browse the category directories for the full contents.

## Enable the overlay

Create `/etc/portage/repos.conf/gentoo-overlay.conf` with:

```ini
[gentoo-overlay]
location = /var/db/repos/gentoo-overlay
sync-type = git
sync-uri = https://github.com/craig-miller/gentoo-overlay.git
auto-sync = yes
```

Synchronize:

```sh
sudo emaint -r gentoo-overlay sync
```

Some packages have testing keywords or require dependencies from another overlay. Accept keywords selectively for the packages you intend to use rather than enabling testing globally.

### Maintainer checkout

For a user-managed checkout, use `auto-sync = false` instead. Portage reads the working tree; Git operations and publication are managed manually.

## Documentation

- [Gentoo system documentation](https://github.com/craig-miller/gentoo-docs)
- [Companion Noctalia plugins](https://github.com/craig-miller/noctalia-plugins)

## License

The overlay is distributed under the [GNU General Public License v2](LICENSE). Individual packages retain their upstream licenses, declared in each ebuild's `LICENSE` field.
