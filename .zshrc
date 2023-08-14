alias vim="nvim"
alias gs="git status"
alias dss="docker-sync-stack"
alias nrb="npm run build"

# Add directory and current branch to terminal name
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{#4387ed}%~%f %F{#aaf0d1}$(parse_git_branch)%f %F{normal}$%f '
