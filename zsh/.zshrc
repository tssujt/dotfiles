# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE

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
    autojump
    autopep8
    brew
    cargo
    celery
    colored-man-pages
    common-aliases
    # composer
    cp
    dash
    django
    docker
    docker-compose
    dotenv
    emoji
    extract
    fabric
    fzf
    git
    git-extras
    github
    gitignore
    golang
    gulp
    history
    httpie
    iterm2
    man
    mosh
    npm
    osx
    pep8
    pip
    pipenv
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
    virtualenv
    # virtualenvwrapper
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

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Ruby
# eval "$(rbenv init -)"

# Python
# eval "`pip3 completion --zsh`"
eval "$(pyenv init -)" && pyenv virtualenvwrapper

# Node
eval "$(nodenv init -)"

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

# unsetopt XTRACE
# exec 2>&3 3>&-

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

alias lain="~/.local/share/virtualenvs/subot-next/bin/lain"
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

[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"
