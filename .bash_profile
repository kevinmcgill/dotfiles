[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Imported from existing bash_profile on office machine, disabled here...
# export PATH=/usr/local/bin:$PATH
# export PATH="/usr/local/opt/openssl/bin:$PATH"

# Prompt is scrappy. I’d love to know how to do this properly.
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
NO_COLOUR="\[\033[0m\]"

PS1="$GREEN\u$NO_COLOUR \e[3min $BLUE\w$NO_COLOUR \e[3mon$YELLOW\$(parse_git_branch)$NO_COLOUR\n» "


# Aliases
alias ll="ls -lhFG"