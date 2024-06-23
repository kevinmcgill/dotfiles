#!/bin/sh

# One-time prompt for password.
echo "Setting up the Mac"
sudo -v

# Xcode Developer Tools
echo "Installing Xcode Developer Tools"
xcode-select --install

# TMUX Plugin Manager
echo "Installing TMUX Plugin Manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Oh My Zsh
echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# asdf
if [ ! -d "$HOME/.asdf" ]; then
  echo "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
fi

# Node.js
echo "Installing Node.js"
source ./setup/nodejs.sh

# Python
echo "Installing Python"
source ./setup/python.sh

# Lua
echo "Installing Lua"
source ./setup/lua.sh

# Ruby
echo "Installing Ruby"
source ./setup/ruby.sh

# Elixir
echo "Installing Elixir"
source ./setup/elixir.sh

# Homebrew
if test ! $(which brew); then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew packages, Cask binaries and Mac App Store software
echo "Installing Homebrew packages, Cask binaries and Mac App Store software"
source ./setup/brew.sh
