alias vim="nvim"

# Add directory and current branch to terminal name
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{red}%~%f %F{green}$(parse_git_branch)%f %F{normal}$%f '
