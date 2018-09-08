function http() {
    if [ -z "$1" ]; then
        port=8000
    else
        port=$1
    fi
    if [ "$port" -lt 1024 ]; then
        type sudo &>/dev/null && sudo python -m SimpleHTTPServer ${port} || python -m SimpleHTTPServer "$port"
    else
        python -m SimpleHTTPServer "$port"
    fi
}

