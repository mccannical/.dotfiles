# zsh reload
alias zshconfig="pycharm ~/.zshrc"
alias reloadZshConfig="source ~/.zshrc"

# Kubernetes
alias k=kubectl

#LSD
alias ls='lsd '
alias l='lsd --almost-all --long'
alias llm='lsd --timesort --long'
alias lS='lsd --oneline --classic'
alias lt='lsd --tree --depth=2 -lha'
alias lf='lsd --directory-only (.*|*)(^/)'

# stop rm and move to trash
## https://github.com/sindresorhus/trash-cli
## npm install --global trash-cli
alias rm=trash

# podman/docker
# Not a trailing space in value causes the next word to be checked for alias substitution when the alias is expanded.
alias docker='podman '
alias build="build --arch=linuxamd64"
alias run="run --arch=linux/amd64"
