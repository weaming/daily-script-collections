# python3 venv
PY_VENV_BASE=$HOME/.pyvenv

function pyenv-activate() {
    echo . $1/bin/activate
    . $1/bin/activate && \
        python --version
}

function py2env-create() {
    one=$1
    name=${one:=$(basename $(pwd))}
    req='./requirements.txt'

    virtualenv -p python2 $PY_VENV_BASE/$name && \
        $PY_VENV_BASE/$name/bin/python -m pip install -U pip setuptools && \

        [ -f "$req" ] && \
        $PY_VENV_BASE/$name/bin/python -m pip install -r "$req"
}

function py3env-create() {
    one=$1
    name=${one:=$(basename $(pwd))}
    req='./requirements.txt'

    python3 -m venv $PY_VENV_BASE/$name && \
        $PY_VENV_BASE/$name/bin/python -m pip install -U pip setuptools && \

        [ -f "$req" ] && \
        $PY_VENV_BASE/$name/bin/python -m pip install -r "$req"
}

function pyenv-rm() {
    one=$1
    name=${one:=$(basename $(pwd))}
    echo rm -r $PY_VENV_BASE/$name
    rm -r $PY_VENV_BASE/$name
}

function pyenv() {
    one=$1
    name=${one:=$(basename $(pwd))}

    if [ -d './venv' ]; then
        pyenv-activate ./venv
    elif [ -d "$PY_VENV_BASE" ]; then
        pyhome=$PY_VENV_BASE/$name
        pyenv-activate $pyhome
    else
        echo "./venv and $PY_VENV_BASE not found"
        return 1
    fi
}
