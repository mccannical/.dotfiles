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

# iterm2_shell_integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word


source ${HOME}/.aliases.zsh
source ${HOME}/.functions.zsh
#

autoload -U compinit; compinit

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh ; antidote load
# eval "$(~/.local/bin/mise activate zsh)"
eval "$(mise activate zsh --shims)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(starship completions zsh)"
eval "$(atuin init zsh)"; . "$HOME/.atuin/bin/env" ; eval "$(atuin init zsh --disable-up-arrow)" ; eval "$(atuin init zsh --disable-ctrl-r)"

