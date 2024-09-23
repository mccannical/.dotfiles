zplug "junegunn/fzf", \
    from:gh-r, \
    as:command, \
    use:"*darwin*amd64*"

## Can manage gist file just like other packages
#zplug "b4b4r07/79ee61f7c140c63d2786", \
#    from:gist, \
#    as:command, \
#    use:get_last_pane_path.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
