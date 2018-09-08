# monitor
alias myprocs="ps -fu $LOGNAME"

# MEMORY
alias freemem="sudo bash -c 'echo 1 > /proc/sys/vm/drop_caches'"

function status() {
    ps aux | grep "$1" | grep -v grep
}

function checkos() {
    OS=unknown
    if [ -f /etc/redhat-release ];then
        OS=CentOS
    elif grep -q bian < /etc/issue;then
        OS=Debian
    elif grep -q Ubuntu < /etc/issue;then
        OS=Ubuntu
    elif grep -q Mint < /etc/issue;then
        OS=LinuxMint
    else
        echo "Unknow system!"
        return 1
    fi
    echo "The System is $OS"
}

