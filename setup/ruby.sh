#!/bin/sh

asdf plugin add ruby
asdf install ruby 3.2.2
asdf global ruby 3.2.2

bundle install --gemfile=../ruby/Gemfile
