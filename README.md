# Homebrew tap for vidp

Homebrew tap for [vidp](https://github.com/mdopeace/vidp), a minimal
libmpv-based macOS video player.

## Install

```sh
brew tap mdopeace/vidp
brew install vidp
```

After install, the formula also copies `vidp.app` into `/Applications`:

```sh
open /Applications/vidp.app
```

The Homebrew-managed bundle remains available here:

```sh
open "$(brew --prefix)/opt/vidp/libexec/vidp.app"
```

Install and upgrade copy only the vidp bundle. If `/Applications` is not
writable, Homebrew keeps the formula installation intact and prints a warning.

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
