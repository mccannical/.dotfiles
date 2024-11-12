# Environment variables for zsh/cli
export PATH="${HOME}/bin:$PATH"

# gitlab config
GITLAB_HOST="gitlab.internal.dtexgov.com"
. "$HOME/.cargo/env"


export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_LOG_PATH=ansible.`date +%s`.log
