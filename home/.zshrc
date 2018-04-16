# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(arcanist, autopep8, aws, brew, celery, common-aliases, composer, dotenv, docker, emacs, emoji, fabric, git, github, gitignore, go, golang, gulp, httpie, laravel5, man, mosh, npm, osx, pep8, pip, pylint, python, redis-cli, sudo, supervisorm, tmux, virtualenv, xcode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="emacs"

export PATH="$HOME/Sources/arcanist/bin:$PATH"
if [ -f $HOME/bin/arcanist/resources/shell/bash-completion ]; then
    source $HOME/bin/arcanist/resources/shell/bash-completion
fi

export PATH="$PATH:$HOME/.composer/vendor/bin"

export PATH="$(brew --prefix php@7.0)/bin:$PATH"

export ANDROID_HOME=/usr/local/opt/android-sdk

export EDITOR=emacs

eval "$(thefuck --alias)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "`pip completion --zsh`"

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
    . ~/.config/exercism/exercism_completion.zsh
fi

# export PYSPARK_DRIVER_PYTHON=jupyter
# export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LD_LIBRARY_PATH=/Users/imperat0r/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:/Users/imperat0r/.rustup/toolchains/nightly-x86_64-apple-darwin/lib:

export PATH="${HOME}/Library/emsdk-portable:$PATH"
export EMSDK="${HOME}/Library/emsdk-portable"
export EM_CONFIG="${HOME}/.emscripten"

eval "$(rbenv init -)"
