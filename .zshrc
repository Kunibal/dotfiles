alias vim="nvim"
alias gs="git status"
alias ls="exa"

export PATH=$PATH:$HOME/.composer/vendor/binexport PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add directory and current branch to terminal name
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{#4387ed}%~%f %F{#aaf0d1}$(parse_git_branch)%f %F{normal}$%f '

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
