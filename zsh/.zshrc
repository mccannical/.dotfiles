# https://gist.github.com/pbrisbin/45654dc74787c18e858c
#Default behavior dictates the following order for ZSH startup files:
# /etc/zshenv
#~/.zshenv
#/etc/zprofile (if login shell)
#~/.zprofile (if login shell)
#/etc/zshrc (if interactive)
#~/.zshrc (if interactive)
#/etc/zlogin (if login shell)
#~/.zlogin (if login shell)
# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

#${ZDOTDIR:-~}/.zshrc
autoload -Uz compinit
compinit
# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=(/opt/homebrew/opt/antidote/share/antidote/functions/ $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle < ${zsh_plugins}.txt >| ${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

# Source other files
source ${HOME}/.aliases.zsh
source ${HOME}/.functions.zsh

# autocomplete kubectl & helm
source <(kubectl completion zsh)
source <(helm completion zsh)
[ -f ${HOME}/.fzf.zsh ] && source ${HOME}/.fzf.zsh

#zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship completions zsh)"
eval "$(starship init zsh)"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/tofu tofu

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# Bind up-arrow but not ctrl-r
eval "$(atuin init zsh --disable-ctrl-r)"