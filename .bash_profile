[[ "$PS1" ]] && bash_interactive=1

[[ "$bash_interactive" ]] && echo "$HOME/.bash_profile"

if [ -f "$HOME/.profile" ]; then
    [[ "$bash_interactive" ]] && echo "$HOME/.bash_profile: load $HOME/.profile"
    source "$HOME/.profile"
fi

if [ "$bash_interactive" ] && [ -f "$HOME/.bashrc" ]; then
    echo "$HOME/.bash_profile: load $HOME/.bashrc"
    source "$HOME/.bashrc"
fi

if [ "$(command -v trimhistory)" ] && [ -x "$HOME/src/terminal-history" ]; then
    [[ "$bash_interactive" ]] && echo "$HOME/.bash_profile: invoke trimhistory"
    trimhistory trim -b "$HOME/src/terminal-history/.bash_history" "$HOME/.bash_history"
    if [ -r "$HOME/Library/Application Support/jp.tinyport.trimhistory/statistics.toml" ]; then
        cp "$HOME/Library/Application Support/jp.tinyport.trimhistory/statistics.toml" "$HOME/src/terminal-history"
    elif [ -r "$HOME/.local/share/trimhistory/statistics.toml" ]; then
        cp "$HOME/.local/share/trimhistory/statistics.toml" "$HOME/src/terminal-history"
    fi

    start_dir="$PWD"
    cd "$HOME/src/terminal-history" || (echo failed to cd && return)
    [[ "$(git diff --name-only)" ]] && git add . && git commit -m "auto update $(date +%Y%m%d-%H%M%S)" > /dev/null
    cd "$start_dir" || echo failed to cd
    unset start_dir
fi

unset bash_interactive
