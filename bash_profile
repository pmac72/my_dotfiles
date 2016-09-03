PATH="~/bin:/usr/local/bin:$PATH"

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

if [ -f ${SRC_DIR}/private_vars ]; then
	source ${SRC_DIR}/private_vars
else
	echo "not there.  SRC_DIR: $SRC_DIR"
fi

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
