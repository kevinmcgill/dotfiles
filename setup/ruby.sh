#!/bin/sh

asdf plugin add ruby
asdf install ruby 3.3.1
asdf global ruby 3.3.1

bundle install --gemfile=./ruby/Gemfile
