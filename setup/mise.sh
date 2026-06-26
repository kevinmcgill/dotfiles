#!/bin/sh
set -e # fail loudly: a failed tool build must abort, not silently skip gems

# Installs every tool pinned in the repo's mise config. Independent of ./install
# (dotbot): we point mise's global config at the repo file directly via
# MISE_GLOBAL_CONFIG_FILE, so this works whether or not the
# ~/.config/mise/config.toml symlink exists yet. We run from $HOME so the
# dotfiles repo's own .tool-versions isn't pulled into scope.
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
export MISE_GLOBAL_CONFIG_FILE="$REPO_ROOT/mise/config.toml"
cd "$HOME"

# rust must be installed before ruby because --enable-yjit needs rustc at build
# time. Ruby is built from source by mise (ruby-build), so its build deps and
# the YJIT flag come next. Mirrors the old setup/rust.sh + setup/ruby.sh.
mise install rust

export RUBY_CONFIGURE_OPTS=--enable-yjit

# Build dependencies for Ruby
brew install openssl readline libyaml gmp

# Install the remaining pinned tools (ruby, node, python, lua, erlang, elixir)
mise install

# Global Ruby gems (Language Server tooling). Standardrb/Rubocop are installed
# per-project via the Gemfile. Run THROUGH the mise-managed Ruby — this script
# isn't shell-activated, so a bare `gem` could resolve to system Ruby.
mise exec ruby -- gem install bundler tmuxinator ruby-lsp solargraph
