install-docker-compose-linux-zsh() {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # zsh
    mkdir -p ~/.zsh/completion
    curl -L https://raw.githubusercontent.com/docker/compose/1.22.0/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
}

install-rustup() {
    curl https://sh.rustup.rs -sSf | sh
}
