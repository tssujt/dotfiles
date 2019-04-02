# Aditional PATHs
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PYSPARK_DRIVER_PYTHON=jupyter
# export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PATH="${HOME}/Library/emsdk-portable:$PATH"

export PATH="${HOME}/Sources/arcanist/bin:$PATH"

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="steeef"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
    arcanist
    autopep8
    aws
    brew
    celery
    common-aliases
    composer
    dotenv
    docker
    emacs
    emoji
    fabric
    git
    github
    gitignore
    go
    golang
    gulp
    httpie
    laravel5
    man
    mosh
    npm
    pep8
    pip
    pylint
    python
    redis-cli
    sudo
    supervisor
    tmux
    virtualenv
    xcode
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR=vim

if [ -f $HOME/bin/arcanist/resources/shell/bash-completion ]; then
    source $HOME/bin/arcanist/resources/shell/bash-completion
fi

# PHP
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$(brew --prefix php)/bin:$PATH"

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Rust
source "$HOME/.cargo/env"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export LD_LIBRARY_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:"

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Python
eval "`pip3 completion --zsh`"

# Ruby
eval "$(rbenv init -)"

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
    . ~/.config/exercism/exercism_completion.zsh
fi

# OpenSSL
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export EMSDK="${HOME}/Library/emsdk-portable"
export EM_CONFIG="${HOME}/.emscripten"

eval "$(thefuck --alias)"

alias jdqiandao="${HOME}/Sources/JD-Coin/venv/bin/python ${HOME}/Sources/JD-Coin/app/main.py"
