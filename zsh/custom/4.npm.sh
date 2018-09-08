alias npmtaobao="npm config set registry https://registry.npm.taobao.org"
alias npmofficial="npm config delete registry"
npmls()
{
    npm ls --depth 0 "$@"
}
npmproxy()
{
    if [ -z "$1" ]; then
        npm config get proxy
        npm config get https-proxy
        return 0
    fi
    npm config set proxy "$1"
    npm config set https-proxy "$1"
}
npmnoproxy()
{
    npm config delete proxy
    npm config delete https-proxy
}

