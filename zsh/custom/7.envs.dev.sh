# Rust
# rust update mirror
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# backtrace
export RUST_BACKTRACE='full'

# racer
# rustup toolchain add nightly
# rustup component add rust-src
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# openssl dir for rust
# brew install openssl
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib

alias musl-rust-builder='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder'
