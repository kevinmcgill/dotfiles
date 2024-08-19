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
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

  # Add the line to .zshrc if it doesn't already exist
  grep -qxF '. "$HOME/.asdf/asdf.sh"' ~/.zshrc || echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for the current session
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
  # Add Homebrew to PATH in .zprofile if not already present
  if [ ! -f "$HOME/.zprofile" ]; then
    touch "$HOME/.zprofile"
  fi

  if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    echo "Added Homebrew to PATH in .zprofile"
  fi
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

# Elixir
echo "Installing Elixir"
# Source the elixir.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/elixir.sh"

# Rust
echo "Installing Rust"
# Source the rust.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/rust.sh"

# Ruby
echo "Installing Ruby"
# Source the ruby.sh script relative to the SCRIPT_DIR
source "$SCRIPT_DIR/ruby.sh"

# Homebrew packages, Cask binaries and Mac App Store software
echo "Installing Homebrew packages, Cask binaries and Mac App Store software"
source "$SCRIPT_DIR/brew.sh"
