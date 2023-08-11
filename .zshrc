alias vim="nvim"
alias gs="git status"
alias mvdot="cp ~/pc-settings/.zshrc ~/.zshrc && cp -R ~/pc-settings/.config/nvim ~/.config && cp -R ~/pc-settings/.config/tmux ~/.config && cp -R ~/pc-settings/.config/alacritty ~/.config"

export PATH=$PATH:$HOME/.composer/vendor/binexport PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add directory and current branch to terminal name
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{#4387ed}%~%f %F{#aaf0d1}$(parse_git_branch)%f %F{normal}$%f '
