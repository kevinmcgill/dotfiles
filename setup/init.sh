#!/bin/sh

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

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
# Source the nodejs.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/nodejs.sh"

# Python
echo "Installing Python"
# Source the python.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/python.sh"

# Lua
echo "Installing Lua"
# Source the lua.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/lua.sh"

# Ruby
echo "Installing Ruby"
# Source the ruby.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/ruby.sh"

# Elixir
echo "Installing Elixir"
# Source the elixir.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/elixir.sh"

# Homebrew
if test ! $(which brew); then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew packages, Cask binaries and Mac App Store software
echo "Installing Homebrew packages, Cask binaries and Mac App Store software"
source ./setup/brew.sh
