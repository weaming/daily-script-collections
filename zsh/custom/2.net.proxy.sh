# PROXY
function useproxy() {
    export http_proxy=${PROXY}
    export https_proxy=${PROXY}
}
alias noproxy="unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY"
alias up="useproxy"
alias np="noproxy"
#alias fuckgfw='sudo sslocal -c /etc/shadowsocks.json -d start'
