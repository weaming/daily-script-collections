# 安装macOS Sierra后，会发现系统偏好设置的“安全与隐私”中默认已经去除了允许“任何来源”App的选项，无法运行一些第三方应用。
# 如果需要恢复允许“任何来源”的选项，即关闭Gatekeeper，请在终端中使用spctl命令：
# sudo spctl --master-disable

# Homebrew bintray
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# Finder show all files
alias showdot='defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder'
alias hidedot='defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder'

# PostgreSQL
# http://postgresapp.com/documentation/cli-tools.html
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Java
#export JAVA_HOME=$(/usr/libexec/java_home)
#export PATH=$JAVA_HOME/bin:$PATH

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Ocaml
#eval `opam config env`

# Haskell
export PATH=$HOME/Library/Haskell/bin:$PATH

# Functions
function tt() {
    twitter "$2" "$1"
}

function sw2miniconda(){
    # added by Miniconda3 4.3.21 installer
    PATH_OLD=$PATH
    export PATH="$HOME/miniconda3/bin:$PATH"

    PS1_OLD=$PS1
    PS1="(miniconda3) $PS1"

    quit(){
        export PATH=$PATH_OLD
        PS1=$PS1_OLD
        unset -f quit
    }
}

function download_twitter_pic() {
    SRC="$HOME/src/Crawler/twitter-image-downloader"
    nickname=$1
    targetdir=$2
    python3 $SRC/twt_img.py "$nickname" "$targetdir" -c $SRC/confidentials.json
}

