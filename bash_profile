export PATH="~/bin:/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

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
