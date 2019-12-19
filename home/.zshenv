# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR=nvim

# PHP
# export PATH="$PATH:$HOME/.composer/vendor/bin"
# export PATH="$(brew --prefix php)/bin:$PATH"

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Rust
source "$HOME/.cargo/env"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export LD_LIBRARY_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:"

# Python
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# OpenSSL
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Aditional PATHs
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

# Arcanist
export PATH="${HOME}/Sources/arcanist/bin:$PATH"

export PATH="${HOME}/Library/emsdk-portable:$PATH"
export EMSDK="${HOME}/Library/emsdk-portable"
export EM_CONFIG="${HOME}/.emscripten"

export PATH="${HOME}/.emacs.d/bin:$PATH"
