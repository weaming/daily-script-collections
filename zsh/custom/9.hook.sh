# iterm2 utils
try_source $HOME/.iterm2_shell_integration.zsh

# travis completion
try_source $HOME/.travis/travis.sh

# ruby RVM
try_source ~/.rvm/scripts/rvm
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# 增加动态性配置
try_source ~/.myconfig

