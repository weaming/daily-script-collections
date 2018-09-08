## Usage

    mkdir -p ~/.dotfiles/ && ln -s $(pwd)/custom ~/.dotfiles/zsh
    ln -s $PWD/zsh.bootstrap ~/.zsh_aliases
    ln -s $PWD/zshrc ~/.zshrc

## Source order

    .zshrc --> .zsh_aliases --> (.aliases) --> ~/.dotfiles/zsh/*.zsh
