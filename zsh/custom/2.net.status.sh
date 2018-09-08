alias myip="ifconfig | grep inet | grep -v inet6 | grep -v 127 | awk '{print \$2}'"

function lstcp() {
    netstat -nat | awk '/^tcp/ {++S[$NF]} END {for(a in S) print S[a] "\t" a}'
}
