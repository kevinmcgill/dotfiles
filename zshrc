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

# Force Ruby's default external encoding to UTF-8 regardless of locale. lazygit
# runs its git subprocesses (and therefore git hooks) with LC_ALL=C for stable
# output parsing, which would otherwise make Ruby's File.read default to
# US-ASCII and crash UTF-8-reading hooks (e.g. marketplacer's pre-push
# pattern_forbidder) with "invalid byte sequence in US-ASCII". lazygit passes
# this var through untouched, so it fixes such hooks across every repo at once.
export RUBYOPT='-EUTF-8'

# Set the default config directory
export XDG_CONFIG_HOME="$HOME/.config"

# Lazygit merges multiple config files in order via LG_CONFIG_FILE, so we
# split base settings from theme colors instead of generating a combined
# file. theme.yml is a local symlink (swapped by dark-notify/theme-switch.sh
# on macOS appearance change) pointing at theme-{dark,light}.yml.
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.base.yml,$HOME/.config/lazygit/theme.yml"

# General
alias cat="bat"
alias grep="grep --color=auto"
alias lg="lazygit"
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew upgrade --cask --greedy; brew cleanup"

# Ruby
alias rs="bundle exec rspec"
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

# mise — tool version manager (replaces asdf). Activation puts the right tool
# versions on PATH per-directory and registers completions. Partial versions
# in .nvmrc (e.g. `24`) resolve natively, so no NODEJS legacy-file workaround
# is needed.
eval "$(mise activate zsh)"

# initialise completions with ZSH's compinit (still needed by oh-my-zsh / fzf)
autoload -Uz compinit && compinit

# Stop spring from starting. https://github.com/rails/rails/issues/38560
export DISABLE_SPRING=true
# export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# Direnv setup
eval "$(direnv hook zsh)"

# Atuin setup
eval "$(atuin init zsh)"

# fzf setup
source <(fzf --zsh)
