function is-broken-symlink() {
    [ -L "$1" ] && [ ! -e "$1" ]
}

function ls-all-dirs-files() {
    ls -d -1 $1/**/*
}

function col() {
    awk -v col="$1" '{print $col}'
}

function get_dir_name_of_file() {
    rv=$(basename $(dirname $1))
    echo $rv
}
