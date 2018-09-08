# copy from https://gist.github.com/xevz/280566
# From http://www.reddit.com/r/linux/comments/akt3j/a_functional_programming_style_map_function_for/
# Modified to work in zsh.
# example: mapdo ping -c1: yahoo.com reddit.com google.com wikipedia.org
function mapdo() {
	local command i rep
	if [ $# -lt 2 ] || [[ ! "$@" =~ :[[:space:]] ]];then
		echo "Invalid syntax." >&2; return 1
	fi
	until [[ $1 =~ : ]]; do
		command="$command $1"; shift
	done
	command="$command ${1%:}"; shift
	for i in "$@"; do
		if [[ $command =~ \\{\\} ]];then
			rep="${command//\{\}/\"$i\"}"
			eval "${rep//\\/\\\\}"
		else
			eval "${command//\\/\\\\} \"${i//\\/\\\\}\""
		fi
	done
}
