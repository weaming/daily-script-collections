# OSX special
# copy text in file
cptext() {
    cat $1 | pbcopy
}
alias pc=pbcopy


# csv less
columnless() {
    column -s, -t < "$1" | less -N -S -\#10
}

addtohead() {
    sed -i "1s/^/$1\n/" "$2"
}

dash-to-asterisk() {
    # for OSX and linux compatibility
    # https://superuser.com/questions/112834/how-to-match-whitespace-in-sed
    cat $1 | sed -e 's/^\([[:space:]]*\)-/\1\*/g'
}

# extract link
grep-url() {
    regexp='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    egrep -o $regexp
}

get-urls-in-page() {
    curl -s "$1" | grep-url
}

jsonless() {
    # pip install pretty-json-print drawtable
    cat "$1" | csv_json | csvless /dev/stdin
}

snacky-clipboard() {
    # snacky in script/python
    pbpaste | snacky | tee /dev/tty | pbcopy
}
