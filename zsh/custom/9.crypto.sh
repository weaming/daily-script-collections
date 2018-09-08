cryptorate() {
    echo "$0 [cny|usd]"
    cur=${1:=cny}
    curl "$cur.rate.sx/?n=20"
}

cryptorate-coin() {
    time=${2:=1M}
    if [ ! "$1" = "btc" ]; then
        curl btc.rate.sx/$1@$2
    fi
    curl rate.sx/$1@$2
}

eth() {
    echo "$0 [30m|1d|2w|3M|4y]"
    cryptorate-coin eth $1
}

btc() {
    echo "$0 [30m|1d|2w|3M|4y]"
    cryptorate-coin btc $1
}

eos() {
    echo "$0 [30m|1d|2w|3M|4y]"
    cryptorate-coin eos $1
}

