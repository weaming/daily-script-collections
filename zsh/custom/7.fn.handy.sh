# Go
alias cdwm='cd ~/go/src/github.com/weaming'
alias musl-go-build='docker run --rm -v "$PWD":"/go${$(pwd)#$GOPATH}" -w "/go${$(pwd)#$GOPATH}" blang/golang-alpine go build -v'

# conda
workon() {
    source activate $1
    export VIRTUAL_ENV="$(dirname $(dirname $(which python)))"
    which python

    function workoff() {
        source deactivate
        unset -f workoff
        unset VIRTUAL_ENV
    }
}

py-echo-import() {
    grep -hE '^(from .+ )?import' **/*.py | sort -r | uniq -c | sort -r | less
}

mk-python-module() {
    mkdir -p $1
    touch $1/__init__.py
}

alias pipf='python -m pip freeze'
alias pipfg='python -m pip freeze | grep'
alias pipi='pip install'
alias pipir='pip install -r requirements.txt'
alias py='python'
rm-extension() {
    find . -name "*.$1" | xargs rm
}
alias rm-pyc='rm-extension pyc'

# Go
generate-and-view-gograph() {
    set -o pipefail
    out=/tmp/godepgraph.png
    godepgraph $1 | dot -Tpng -o $out && open $out
}

# show command status
cmd() {
    if which "$1" > /dev/null && [ -e "$(which $1)" ]; then
        echo -e $(OK "ls -l \$(which $1):")
        ls -l `which $1`
    else
        echo -e $(OK 'which:')
        which $1
    fi
    echo

    echo -e $(OK 'where:')
    where $1
    echo

    echo -e $(OK 'type:')
    type $1
}

# Flutter
alias flutter_get_gitignore='wget https://raw.githubusercontent.com/flutter/flutter/master/.gitignore -O .gitignore'

# Pypi
alias get-example-setup.py='wget https://raw.githubusercontent.com/pypa/sampleproject/master/setup.py -O setup.py'

# photo
# smms-upload in script/python, paster_to_tmp_png in script/shell
alias upload-image-in-clipboard-to-smms="clipboard-to-tmp-png | smms-upload -"

# linux
alias tv='tmux attach'
alias dpkg-reconfigure-timezone='sudo dpkg-reconfigure tzdata'

