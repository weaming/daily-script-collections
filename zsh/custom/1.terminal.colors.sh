# example:
# echo $(colortext RED "it's red") dsdf $(colortext GREEN green)
colortext() {
    BLACK=30
    RED=31
    GREEN=32
    YELLOW=33
    BLUE=34
    MAGENTA=35
    CYAN=36

    WHITE=97
    RESET=0

    set -o nounset
    eval "code=\$$1"
    echo -n "\e[${code}m$2\e[0m"
    set +o nounset
}

WARNING() {
    echo $(colortext RED $1)
}

OK() {
    echo $(colortext GREEN $1)
}
