eval $(thefuck --alias)

alias Grep="grep" # common typo for me
alias ls="ls -G"
alias ll="ls -lG"
alias stat="stat -x"
alias apg="apg -a0 -m8 -x 31 -MSNCL -E 0O1l\'\\\"I"
alias grep="grep --color --exclude-dir='.git' --exclude-dir='.terraform' --exclude-dir='node_modules'"
alias egrep="egrep --color --exclude-dir='.git' --exclude-dir='.terraform'"

alias docker_pull_all="docker images --format '{{.Repository}}:{{.Tag}}' | grep -v '<none>' | sort | uniq |  xargs -L1  docker pull"


alias brewski='brew update && brew upgrade && brew cleanup && brew doctor'

alias tti="terraform init"
alias ttiu="terraform init -upgrade"
alias ttf="terraform fmt -diff"
alias ttv="terraform validate"
alias ttp="terraform plan"
alias tta="terraform apply"
alias tfd="terraform-docs markdown --output-file=README.md ."

alias git-default-branch="git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
alias git-grep-all="git branch -a | tr -d \* | sed '/->/d' | xargs git grep"
alias git-push-what-diff="git diff --cached origin/\$(git rev-parse --abbrev-ref HEAD)"
alias git-push-what="git diff --stat --cached origin/\$(git rev-parse --abbrev-ref HEAD)"
alias git-who="git shortlog -s -n --no-merges | tac"
alias git-stash-diff="git stash show -p" # always forget this

alias lsusb="system_profiler SPUSBDataType"

# get egress ip from dns
alias wanip='dig @resolver4.opendns.com myip.opendns.com +short' 
alias wanip4='dig @resolver4.opendns.com myip.opendns.com +short -4'
# not working anymore alias wanip6='dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6'
alias wanip6='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -6 | tr -d \"'
