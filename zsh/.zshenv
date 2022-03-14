# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR=nvim

# PHP
# export PATH="$PATH:$HOME/.composer/vendor/bin"
# export PATH="$(brew --prefix php)/bin:$PATH"

# MySQL
export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Rust
source "$HOME/.cargo/env"

export LD_LIBRARY_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:"

# Python
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# OpenSSL
export LDFLAGS="-I/usr/local/opt/openssl@1.1/include -L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# Aditional PATHs
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="${HOME}/Library/emsdk-portable:$PATH"
export EMSDK="${HOME}/Library/emsdk-portable"
export EM_CONFIG="${HOME}/.emscripten"

export PATH="${HOME}/.emacs.d/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:${HOME}/.local/bin"

export PATH="/usr/local/sbin:$PATH"
if [ -e ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then . ${HOME}/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export HOMEBREW_BUNDLE_FILE="${HOME}/.Brewfile"
