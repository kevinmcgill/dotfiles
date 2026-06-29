#!/bin/sh

brew bundle install --file homebrew/Brewfile
brew update
brew upgrade
brew upgrade --cask --greedy
brew cleanup
