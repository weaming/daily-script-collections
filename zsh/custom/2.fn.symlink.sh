# print broken symlinks
print-all-broken-symlinks() {
    for x in $(ls-all-dirs-files ${1:-.}); do
        $(is-broken-symlink $x)
        if [ "$?" = 0 ]; then
            if [ -z "$VERBOSE" ]; then
                echo $x
            else
                echo $x '==>' "$(readlink $x)"
            fi
        fi
    done
}
