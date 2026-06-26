#!/bin/sh

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# One-time prompt for password.
echo "Setting up the Mac"
sudo -v

# Xcode Developer Tools
echo "Installing Xcode Developer Tools"
xcode-select --install

# Oh My Zsh
echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

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

# mise
echo "Installing mise"
brew install mise

# Languages (node, python, lua, elixir/erlang, rust, ruby) via mise.
# Self-contained: reads the repo's mise config directly, so it does not depend
# on ./install having run. Executed (not sourced) to contain its set -e / cd.
echo "Installing languages via mise"
sh "$SCRIPT_DIR/mise.sh"

# Homebrew packages, Cask binaries and Mac App Store software
echo "Installing Homebrew packages, Cask binaries and Mac App Store software"
source "$SCRIPT_DIR/brew.sh"
