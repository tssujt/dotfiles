# zmodload zsh/zprof

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz compinit
compinit

export BREW_PREFIX="$(command brew --prefix)"

alias vi='nvim'
alias vim='nvim'

alias ssh="TERM=xterm ssh"
alias tig='TERM=xterm-256color tig'

alias rm='trash'

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

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# Completion
source <(stern --completion=zsh)
[ -f ${BREW_PREFIX}/etc/profile.d/autojump.sh ] && . ${BREW_PREFIX}/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${BREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh
source ${BREW_PREFIX}/opt/asdf/libexec/asdf.sh
eval "`pip3 completion --zsh`"
eval "$(starship init zsh)"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# kubectl
alias k='kubectl'
export PATH="${PATH}:${HOME}/.krew/bin"

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

# zprof

neofetch
