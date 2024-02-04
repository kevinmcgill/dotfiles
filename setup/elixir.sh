#!/bin/sh

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install elixir 1.14.0
asdf install erlang 26.1.2
asdf global elixir 1.14.0
asdf global erlang 26.1.2
