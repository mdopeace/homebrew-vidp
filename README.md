# Homebrew tap for vidp

Homebrew tap for [vidp](https://github.com/mdopeace/vidp), a minimal
libmpv-based macOS video player.

## Install

```sh
brew tap mdopeace/vidp
brew install vidp
```

After install, launch the Homebrew-managed app with:

```sh
open "$(brew --prefix)/opt/vidp/libexec/vidp.app"
```

To copy the app into `/Applications`, replacing the existing `vidp.app` there:

```sh
cp -R "$(brew --prefix)/opt/vidp/libexec/vidp.app" /Applications/
```

The Homebrew formula cannot perform this copy itself because formula
installation runs in a sandbox. You can also use vidp's **Check for Updates**
command to install a release into `/Applications`.

Homebrew upgrades update the managed bundle under `libexec`.

> **Note:** this tap installs a **formula**, so the command is `brew install vidp`
> (no `--cask`). A pre-built, notarized cask is not currently provided.

## In a Brewfile

```ruby
tap "mdopeace/vidp"
brew "vidp"
```

## Updating

When a new [vidp release](https://github.com/mdopeace/vidp/releases) is tagged, bump
the `version`/`url`/`sha256` in `Formula/vidp.rb`.

## Contributing

`main` is branch-protected — open a pull request with any changes.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
