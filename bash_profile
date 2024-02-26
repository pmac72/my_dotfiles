if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

if [ -d "${HOMEBREW_PREFIX}/bin" ]; then
	export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
fi

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"
if [ -d "${HOMEBREW_PREFIX}/opt/curl/bin" ]; then
	export PATH="${HOMEBREW_PREFIX}/opt/curl/bin:$PATH"
fi

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


# eval "$(brew shellenv)" # this is key so that HOMEBREW_REPOSITORY is set (now at top of this script)
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# Unless HOMEBREW_NO_INSTALL_CLEANUP is set, brew cleanup will be run for the installed formulae or, every 30 days, for all formulae
export HOMEBREW_NO_INSTALL_CLEANUP=1
# if formula is already installed "brew install" should do nothing (if this is not set it will upgrade)
export HOMEBREW_NO_INSTALL_UPGRADE=1

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
[ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && . "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && . "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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

# GPG Agent
export GPG_TTY=$(tty)
# may not be needed anymore:
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
# fi

# PYENV
# from https://github.com/pyenv/pyenv-virtualenv/issues/401#issuecomment-903664058
if [ -n "$(which pyenv)" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	
	# suppress annoying message about prompt change going away (starship takes care of it for me)
	export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# set this so colima acts more like docker
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# direnv
which direnv > /dev/null && eval "$(direnv hook bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
