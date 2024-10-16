# zsh reload
alias zconf="pycharm ~/.zshrc"
alias rz="exec zsh"
# bastion/helper script
alias eb="pycharm ~/src/fedramp/xops/tools/stevedore"

# dotfiles
alias de="pycharm ~/.dotfiles"
alias dotfiles='pycharm ~/.dotfiles'out

# Kubernetes
alias k=kubectl

#LSD
alias ls='lsd '
alias l='lsd --almost-all --long '
alias llm='lsd --timesort --long '
alias lS='lsd --oneline --classic '
alias lt='lsd --tree --depth=4 -lha '
alias lf='lsd --directory-only (.*|*)(^/) '

# stop rm and move to trash
## https://github.com/sindresorhus/trash-cli
## npm install --global trash-cli
alias rm=trash

# podman/docker
# Not a trailing space in value causes the next word to be checked for alias substitution when the alias is expanded.
alias docker='podman '
alias build="build --arch=linuxamd64"
alias run="run --arch=linux/amd64"

# tailscale
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# git
alias gc='git commit -m '
alias gst='git status'
alias ga='git add'
alias gco='git checkout'
# helm
alias hls='helm list -A'

# zoxide
alias cd="z"
