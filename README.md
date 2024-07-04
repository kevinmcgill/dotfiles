# Dotfiles

## Requirements

Run `./setup/init.sh` to install tools and applications on a new mac.

## Dotbot

I am using [dotbot](https://github.com/anishathalye/dotbot) to bootstrap & manage my dotfiles.

```shell
./install
```

### Homebrew

- **Taps** are additional repositories of formulae
- **Brews/Formulae** are the command-line tools we want to install
- **Casks** are GUI applications, fonts and non-command-line tools we want to install

To generate a `Brewfile` from the currently installed packages:

```shell
brew bundle dump --force --all --global --describe
```

This will update the existing linked **global** `Brewfile` in `~/`, it also adds a description for each package.
