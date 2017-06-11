# Dotfiles

## Installation:

    git clone git://github.com/kevinmcgill/dotfiles.git ~/Sites/Work/dotfiles

## Create symlinks:

    ln -s ~/Sites/Work/dotfiles/.vimrc ~/.vimrc
    ln -s ~/Sites/Work/dotfiles/vim ~/.vim
    ln -s ~/Sites/Work/dotfiles/.bash_profile ~/.bash_profile
    ln -s ~/Sites/Work/dotfiles/.gitconfig ~/.gitconfig

You may need to delete `~/.vim` if it already exists.

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update
