eval $(thefuck --alias)

alias Grep="grep" # common typo for me
alias ls="ls -G"
alias ll="ls -lG"
alias stat="stat -x"
alias apg="apg -a0 -m8 -x 31 -MSNCL -E 0O1l\'\\\"I"
alias grep="grep --color --exclude-dir='.git' --exclude-dir='.terraform'"
alias egrep="egrep --color --exclude-dir='.git' --exclude-dir='.terraform'"

alias docker_pull_all="docker images --format '{{.Repository}}:{{.Tag}}' | grep -v '<none>' | sort | uniq |  xargs -L1  docker pull"

alias git_grep_all="git branch -a | tr -d \* | sed '/->/d' | xargs git grep"

alias brewski='brew update && brew upgrade && brew cleanup && brew doctor'
