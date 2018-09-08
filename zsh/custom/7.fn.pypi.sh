PIP_PREFIX=/usr/local/bin

pypi-clean() {
    rm -rf build dist *.egg-info
}

pypi-build() {
    pypi-clean
    python setup.py bdist_wheel --universal
}

pypi-install() {
    pypi-build
    $PIP_PREFIX/pip install --force-reinstall ./dist/*.whl
}

pypi-uninstall() {
    for p in pip pip3; do
        $PIP_PREFIX/$p uninstall "$1" -y
    done
}

pypi-publish() {
    pypi-install
    twine upload dist/* && git push
}
