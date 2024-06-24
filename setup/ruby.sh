#!/bin/sh

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Determine the absolute path to the Gemfile
GEMFILE_PATH=$(cd "$SCRIPT_DIR/../ruby" && pwd)/Gemfile

# Install dependencies for building Ruby
brew install openssl readline libyaml gmp

asdf plugin add ruby
asdf install ruby 3.3.3
asdf global ruby 3.3.3

# Install gems using the absolute path to the Gemfile
bundle install --gemfile="$GEMFILE_PATH"
