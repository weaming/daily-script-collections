alias getip="curl ip.sb 2>/dev/null | grep --color=never -Eo '([0-9]{1,3}\.){3}([0-9]{1,3})'"

geoip() {
    format='json'
    curl -s "https://freegeoip.net/${format}/$1" | jq
}

ipinfo() {
    curl http://click.bitsflow.org/ip/$1
}
