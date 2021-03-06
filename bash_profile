[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

export EDITOR="/usr/bin/vim"

export PS1="\@ [\W] \\$ \[$(tput sgr0)\]"

function get_src_dir() {
	local source="${BASH_SOURCE[0]}"
	while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
	  DIR="$( cd -P "$( dirname "$source" )" && pwd )"
	  source="$(readlink "$source")"
	  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	SRC_DIR="$( cd -P "$( dirname "$source" )" && pwd )"
}

get_src_dir

for x in ${SRC_DIR}/private_vars ${SRC_DIR}/bash_aliases; do
	if [ -f ${x} ]; then
		source ${x}
	fi
done


# bash completion
which aws_completer > /dev/null && complete -C aws_completer aws
complete -C '/usr/local/bin/aws2_completer' aws2
which terraform > /dev/null && complete -C terraform terraform
which kubectl > /dev/null && source <(kubectl completion bash)
# removed source `brew --repository`/Library/Contributions/brew_bash_completion.sh
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# history settings
shopt -s histappend  # append, not overwrite on session close
shopt -s cmdhist # multiline commands to one line
HISTFILESIZE=1000000 # file size
HISTSIZE=1000000 # session history size
HISTCONTROL=ignoreboth # duplicates and lines starting with whitespace
HISTIGNORE='bg:fg:history'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a' # store immediately, not when session ends

# NODE (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export FIGNORE=git:DS_Store:.terraform

# starship prompt
which starship > /dev/null && eval "$(starship init bash)"

# shell check default options
export SHELLCHECK_OPTS='--shell=bash --exclude=SC2155'

# stop creating stupid . files in tarballs
export COPYFILE_DISABLE=1

# ls colors
export CLICOLOR=1
# export LSCOLORS=Exfxcxdxbxegedabagacad
export LSCOLORS=ExFxBxDxCxegedabagacad

