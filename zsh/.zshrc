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

if [[ -x $(which eza) ]]; then
  export EZA_COLORS="da=32"
  alias l="eza -lbF"
  alias ls="eza -a --group-directories-first"
  alias la="eza -alF --icons"
  alias ll="eza -aFG --group-directories-first"
  alias lg="eza -alFG --group-directories-first"
  alias lr="eza -alr --group-directories-first"
  alias lt="eza -alFs time"
  alias lk="eza -als extension --group-directories-first"
  alias lS="eza -alFs size --group-directories-first"
  alias lR="eza -alFR --group-directories-first"
  alias lT="eza -alFT"
  alias ldot="eza -adl .*"
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

# golang
source ~/.asdf/plugins/golang/set-env.zsh

# kubectl
alias k='kubectl'
export PATH="${PATH}:${HOME}/.krew/bin"

eval "$(helm completion zsh)"

eval "$(atuin init zsh)"

eval "$(zoxide init zsh)"


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

fastfetch
