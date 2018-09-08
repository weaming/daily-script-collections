function gitlabrepos() {
    curl -s https://gitlab.com/api/v4/users/weaming/projects\?private_token\=apyfzBX_mZ4hxBVtKh5z | jq '.[] | {name: .name, desc: .description, ssh: .ssh_url_to_repo, web: .web_url, visibility: .visibility, import: .import_status}'
}

# get web screentshot
function webshot() {
    if [ -z "$1" ] || [ -z "$2" ]; then echo 'missing url and output file path'; return 1; fi
    curl "https://api.thumbnail.ws/api/ab31c1a5162c43d32a908fae6fa6f983b0a7563c9cde/thumbnail/get?url=$1&width=2560&fullpage=true" -o "$2"
}

# BTC
# sudo apt install jq
alias coinprice="curl 'https://api.coinmarketcap.com/v1/ticker/?convert=CNY&limit=10' 2>/dev/null | jq '.[] | {rank: .rank, id: .id, cny: .price_cny, usd: .price_usd, h24: .percent_change_24h, d7: .percent_change_7d, cap_cny: .market_cap_cny}'"
alias coinprice2telegram='curl -X POST -d "$(coinprice)" http://v.bitsflow.org:1234/api/new'

