# Homebrew tap for vidp

Homebrew tap for [vidp](https://github.com/mdopeace/vidp), a minimal
libmpv-based macOS video player.

## Install

```sh
brew tap mdopeace/vidp
brew install --cask vidp
```

This installs `vidp.app` into `/Applications`. The `--cask` flag is optional —
plain `brew install vidp` finds it too.

There is no manual copy step: a cask writes to `/Applications` directly, which a
formula cannot (formula installs run in a sandbox under `opt/`). No compiler and
no `brew install mpv` are needed either — the app bundles its own libmpv and
FFmpeg, so it runs standalone.

Releases are **arm64 only** and about **25 MB**, since libmpv and FFmpeg ship
inside the bundle. Intel users should build from source instead.

## Updating

```sh
brew update && brew upgrade vidp
```

vidp also updates itself via **Check for Updates**. Both routes install the same
build. Homebrew keeps its own record of the installed version, so that record
can fall out of step with an in-app update. `brew reinstall --cask vidp`
re-points it at the tap's version — which rolls the app back if the tap hasn't
published that version yet, so check `brew info --cask vidp` first if you just
updated in-app.

macOS asks for permission the first time you open a video from **Desktop**,
**Documents** or **Downloads**. Choose **Allow**, or playback will silently sit
there doing nothing until you do.

## Migrating from the formula

Releases before 0.13.0 shipped a formula, which installed the app under `opt/`
and asked you to copy it into `/Applications` by hand. The tap now ships a cask.

On Homebrew 5.0.6+ `brew update` migrates the formula to the cask for you. It
fails if a copy is already sitting in `/Applications` — exactly what the old
manual step left behind — and the old formula keg keeps `mpv` pinned as a
dependency, so `brew uninstall mpv` refuses until it's gone. Remove both first:

```sh
rm -rf /Applications/vidp.app
brew uninstall --formula vidp
brew install --cask vidp
```

## In a Brewfile

```ruby
tap "mdopeace/vidp"
cask "vidp"
```

## Maintaining

`version`/`url`/`sha256` in `Casks/vidp.rb` are updated automatically by
`scripts/release.sh` in the [app repo](https://github.com/mdopeace/vidp) on
every tagged release, so they normally need no hand-editing. The same commit
deletes `Formula/` and rewrites `tap_migrations.json`; keep all three together,
or `brew upgrade` fails with "No available formula".

## Contributing

`main` is branch-protected — open a pull request with any changes.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
