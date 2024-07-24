#!/bin/sh

# Install dependencies for building Ruby
brew install openssl readline libyaml gmp

asdf plugin add ruby
asdf install ruby 3.3.4
asdf global ruby 3.3.4

# Re-source ASDF to ensure the installed Ruby version is available
. "$HOME/.asdf/asdf.sh"

gem install bundler
gem install tmuxinator
