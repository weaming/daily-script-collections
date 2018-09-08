# tar safely with a password (http://www.ha97.com/5114.html)
# tarsafe target output password
tarsafe() {
    tar -zcvf - "$1" | openssl des3 -salt -k "$3" | dd of="$2"
}
# xtar target
xtar() {
    dd if="$1" | openssl des3 -d | tar zxf -
}
