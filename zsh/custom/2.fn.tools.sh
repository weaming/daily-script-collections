pyeval() {
    # pyeval 2**10
    python -c "print(eval('$@'))"
}

sogoufy() {
    one=$1
    text=${one:=明月照大江，清风抚山岗}
    curl https://fanyi.sogou.com/reventondc/translate -X POST -d "from=auto&text=$1" 2>/dev/null | jq '.translate.dit'
}

vin() {
    one=$1
    n=${one:=1}
    sed "${n}q;d" | xargs -I{} nvim '{}'
}

is-python3-project() {
    # use VERBOSE envvar to print result of each file
    find ${1:=.} -type f -name '*.py' | xargs ispy3
}

is-python2-project() {
    # use VERBOSE envvar to print result of each file
    find ${1:=.} -type f -name '*.py' | xargs ispy2
}

vim-json() {
    cat "$1" | python -mjson.tool | vim -
}
