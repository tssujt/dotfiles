# zmodload zsh/zprof

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="steeef"

plugins=(
    adb
    autojump
    autopep8
    brew
    colored-man-pages
    common-aliases
    cp
    dash
    docker
    docker-compose
    dotenv
    emoji
    extract
    fzf
    git
    git-extras
    github
    gitignore
    golang
    gulp
    history
    httpie
    macos
    man
    mosh
    npm
    pep8
    pip
    pyenv
    pylint
    python
    redis-cli
    ripgrep
    rust
    rsync
    sudo
    supervisor
    thefuck
    tmux
    vscode
    web-search
    xcode
    yarn
)

source $ZSH/oh-my-zsh.sh

alias vi='nvim'
alias vim='nvim'

alias aws='/usr/local/opt/awscli@1/bin/aws'
alias ssh="TERM=xterm ssh"

# if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
#     . ~/.config/exercism/exercism_completion.zsh
# fi

# eval "$(thefuck --alias)"

# Ruby
# eval "$(rbenv init -)"

# Python
# eval "`pip3 completion --zsh`"

eval "$(mcfly init zsh)"

# https://github.com/davidparsson/zsh-pyenv-lazy
# Try to find pyenv, if it's not on the path
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
if ! type pyenv > /dev/null && [ -f "${PYENV_ROOT}/bin/pyenv" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

# Lazy load pyenv
if type pyenv > /dev/null; then
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        pyenv virtualenvwrapper_lazy
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
        pyenv $@
    }
fi

workon () {
    pyenv virtualenvwrapper_lazy;
    virtualenvwrapper_load;
    workon "$@"
}
mkvirtualenv () {
    pyenv virtualenvwrapper_lazy;
    virtualenvwrapper_load;
    mkvirtualenv "$@"
}
rmvirtualenv () {
    pyenv virtualenvwrapper_lazy;
    virtualenvwrapper_load;
    rmvirtualenv "$@"
}

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

fpath+=~/.zfunc

# Proxy
function proxy_off() {
    unset http_proxy;
    unset https_proxy;
    unset all_proxy;
    echo -e "Proxy OFF!";
}
function proxy_on() {
    export https_proxy=http://127.0.0.1:6152;
    export http_proxy=http://127.0.0.1:6152;
    export all_proxy=socks5://127.0.0.1:6153;

    echo -e "Proxy On!";
}

# proxy_on

alias rm='trash'
alias k='kubectl'

# alias leetcode='docker run -it --rm -v ~/Sources/leetcode-data:/root skygragon/leetcode-cli'

source <(stern --completion=zsh)

kx () {
    local cmd=${2:-"bash"}

    echo kubectl exec -it $1 -- $cmd
    kubectl exec -it $1 -- $cmd
}

klogs () {
    echo kubectl logs -f --tail 100 $1
    kubectl logs -f --tail 100 $1
}

alias wip='git add . && git commit --no-verify -m "wip"'

[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"

# zprof

neofetch
