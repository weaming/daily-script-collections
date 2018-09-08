# download all static files of one site
alias getsite="wget -r -k -p -np"

validate_proxies() {
    # go get github.com/weaming/golib/bin/is-valid-proxy
    # $1 give the proxy list line by line, 8.8.8.8:8888
    for x in $(cat $1); do
        # echo $x
        if is-valid-proxy -proxy http://$x; then
            echo $x >> valid_proxies.txt
            echo $(OK $x)
        else
            echo $(WARNING $x)
        fi
    done
}
