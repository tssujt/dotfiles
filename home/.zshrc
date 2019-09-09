# Aditional PATHs
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
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
    adb
    arcanist
    autojump
    autopep8
    aws
    battery
    brew
    cargo
    celery
    common-aliases
    composer
    dash
    django
    docker
    dotenv
    emoji
    extract
    fabric
    git
    git-extras
    github
    gitignore
    go
    golang
    gulp
    history
    httpie
    man
    mosh
    npm
    osx
    pep8
    pip
    pyenv
    pylint
    python
    redis-cli
    sudo
    supervisor
    tmux
    virtualenv
    vscode
    web-search
    xcode
    yarn
    zsh-256color
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR=nvim

alias vi='nvim'
alias vim='nvim'


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
eval "$(pyenv init -)"

# Ruby
eval "$(rbenv init -)"

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
    . ~/.config/exercism/exercism_completion.zsh
fi

# OpenSSL
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

export EMSDK="${HOME}/Library/emsdk-portable"
export EM_CONFIG="${HOME}/.emscripten"

eval "$(thefuck --alias)"
fpath=(/usr/local/share/zsh-completions $fpath)

if [[ -x $(which exa) ]]; then
  export EXA_COLORS="da=32"
  alias l="exa -lbF"
  alias ls="exa -a --group-directories-first --color-scale"
  alias la="exa -alF --group-directories-first --color-scale"
  alias ll="exa -aFG --group-directories-first --color-scale"
  alias lg="exa -alFG --group-directories-first --color-scale"
  alias lr="exa -alr --group-directories-first --color-scale"
  alias lt="exa -alFs time --color-scale"
  alias lk="exa -als extension --group-directories-first --color-scale"
  alias lS="exa -alFs size --group-directories-first --color-scale"
  alias lR="exa -alFR --group-directories-first --color-scale"
  alias lT="exa -alFT --color-scale"
  alias ldot="exa -adl .* --color-scale"
fi

# fix for navigation keys in JetBrains terminal
if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
    bindkey "∫" backward-word # Option-b
    bindkey "ƒ" forward-word  # Option-f
    bindkey "∂" delete-word   # Option-d
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

function proxy_off() {
    unset http_proxy;
    unset https_proxy;
    unset all_proxy;
    echo -e "Proxy OFF!";
}
function proxy_on() {
    export https_proxy=http://127.0.0.1:1081;export http_proxy=http://127.0.0.1:1081;export all_proxy=socks5://127.0.0.1:1088;

    echo -e "Proxy On!";
}

proxy_on
