#!/bin/sh

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Determine the absolute path to the Gemfile
GEMFILE_PATH=$(cd "$SCRIPT_DIR/../ruby" && pwd)/Gemfile

asdf plugin add ruby
asdf install ruby 3.3.1
asdf global ruby 3.3.1

# Install gems using the absolute path to the Gemfile
bundle install --gemfile="$GEMFILE_PATH"
