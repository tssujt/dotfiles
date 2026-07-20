# zmodload zsh/zprof

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# export GHOSTTY_RESOURCES_DIR="/Applications/Ghostty.app/Contents/Resources/ghostty"
# source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration

# compinit is already run (with dump caching) by Prezto's completion module.
export BREW_PREFIX="/opt/homebrew"

alias vi='nvim'
alias vim='nvim'

alias ssh="TERM=xterm ssh"
alias tig='TERM=xterm-256color tig'

if (( $+commands[eza] )); then
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

bindkey '\e[27;5;13~' accept-line

export no_proxy=127.0.0.1
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

# Completion & tool init: cache generated scripts to avoid spawning
# subprocesses on every startup; regenerate when the binary is newer.
_zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$_zsh_cache_dir" ]] || mkdir -p "$_zsh_cache_dir"

_cache_source() {
  local name="$1"; shift
  (( $+commands[$1] )) || return 0
  local cache="$_zsh_cache_dir/$name.zsh"
  if [[ ! -s "$cache" || "$commands[$1]" -nt "$cache" ]]; then
    "$@" >| "$cache"
  fi
  source "$cache"
}

_cache_source stern stern --completion=zsh
[ -f ${BREW_PREFIX}/etc/profile.d/autojump.sh ] && . ${BREW_PREFIX}/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${BREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh
_cache_source starship starship init zsh

_cache_source mise mise activate zsh
_cache_source codex codex completion zsh

# kubectl
alias k='kubectl'
export PATH="${PATH}:${HOME}/.krew/bin"

_cache_source helm helm completion zsh

_cache_source atuin atuin init zsh

_cache_source zoxide zoxide init zsh


kx () {
    local cmd=${2:-"sh"}

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

export PATH="$BREW_PREFIX/opt/openjdk/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${GOPATH:-$HOME/go}/bin:$PATH"

if command -v op >/dev/null 2>&1; then
    load_1password_keys() {
        echo "Loading development keys from 1Password..."
        echo "✅ Keys loaded"
    }
fi

alias claude="proxy_on && $BREW_PREFIX/bin/claude"
# export DISABLE_TELEMETRY=1
# export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
alias cc="proxy_on && $BREW_PREFIX/bin/claude --dangerously-skip-permissions"
alias ccc="proxy_on && $BREW_PREFIX/bin/claude --dangerously-skip-permissions --continue"
alias cx="proxy_on && codex --dangerously-bypass-approvals-and-sandbox"
alias cxc="proxy_on && codex --dangerously-bypass-approvals-and-sandbox resume"


alias rm='trash'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
