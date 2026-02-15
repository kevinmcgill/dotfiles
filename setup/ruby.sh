#!/bin/sh

# Requires `rustc`
export RUBY_CONFIGURE_OPTS=--enable-yjit

# Install dependencies for building Ruby
brew install openssl readline libyaml gmp

asdf plugin add ruby
asdf install ruby 3.4.8
asdf set --home ruby 3.4.8

# ensure the installed Ruby version is available
asdf reshim ruby

gem install bundler
gem install tmuxinator

# Install Ruby Language Server tools that we want globally available
# Standardrb and Rubocop are installed in the project's Gemfile
gem install ruby-lsp
gem install solargraph
