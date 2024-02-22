# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby rails)

source $ZSH/oh-my-zsh.sh

# User configuration

# / oh-my-zsh CONFIG ----------------------------------------------------------

# Set Neovim as default editor
export EDITOR='/opt/homebrew/bin/nvim'

# General
alias cat="bat"
alias grep="grep --color=auto"
alias lg="lazygit"

# Ruby
alias rspec="bundle exec rspec"
alias pra="bundle exec parallel_rspec spec engines/hotdoc-rails-writebacks/spec engines/hotdoc-rails-reminders/spec engines/hotdoc-rails-recalls/spec" # whole suite in parallel
alias prf="bundle exec parallel_rspec -o '--only-failures'" # run only specs that failed in last run
alias prd="git diff --name-only master | xargs ls -1 2>/dev/null | grep '\_spec.rb$' | xargs bundle exec parallel_rspec" # run only specs that differ from master
alias prs="git diff --name-only --cached | xargs ls -1 2>/dev/null | grep '\_spec.rb$' | xargs bundle exec parallel_rspec" # run only specs that are staged to commit
alias routes="bin/rails routes | fzf -e"
alias bi="bundle install"

# Tmux
alias t="tmux"
alias ta="tmux a -t"
alias tls="tmux ls"
alias tn="tmux new -t"
alias tx="tmuxinator" # eg `tx s work`

# Add wezterm to the path so that we can use wezterm commands like `wezterm ls-fonts`
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# ASDF. https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
# / ASDF

# Stop spring from starting. https://github.com/rails/rails/issues/38560
export DISABLE_SPRING=true
