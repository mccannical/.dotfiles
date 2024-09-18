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


autoload -Uz compinit
compinit

#zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship completions zsh)"
eval "$(starship init zsh)"

# Source other files
source ${HOME}/.aliases.zsh
source ${HOME}/.functions.zsh
source ${HOME}/.zplug/init.zsh
source ${HOME}/.zplug.zsh

# autocomplete kubectl & helm
source <(kubectl completion zsh)
source <(helm completion zsh)