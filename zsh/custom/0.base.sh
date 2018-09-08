# By https://github.com/weaming
# This file will be source by bash or zsh

# timezone
export TZ='Asia/Shanghai'

# language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# redefine system commands
alias RM='rm -rf'
alias vim='nvim' # neovim

# cd....
alias dl="cd ~/Downloads"
alias src="cd ~/src"
alias cdgo='cd $GOPATH/src'

# cd with ls after it
cdls() {
    builtin cd "$@" && ls -F
    command -v git-setup-project-committer &>/dev/null && git-setup-project-committer
    return 0
}
alias cd=cdls
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ls
alias ll='ls -lFh'
alias la='ls -A'
alias l='ls -CF'
alias lsabs='ls | sed "s:^:`pwd`/:"'
# not work on Mac, but for linux:
alias lt='ls -clth --time-style=long-iso'

function try_source() {
    if [ -f $1 ]; then
        source $1
    fi
}

try_source ~/.fzf.zsh
try_source /usr/local/z/z.sh

