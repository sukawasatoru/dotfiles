[[ "$PS1" ]] && bash_interactive=1

[[ "$bash_interactive" ]] && echo $HOME/.bash_profile

if [ -f $HOME/.profile ]; then
    [[ "$bash_interactive" ]] && echo "$HOME/.bash_profile: load $HOME/.profile"
    source $HOME/.profile
fi

if [ "$bash_interactive" -a -f $HOME/.bashrc ]; then
    echo "$HOME/.bash_profile: load $HOME/.bashrc"
    source $HOME/.bashrc
fi

if [ "$(which trimhistory)" ] && [ -x $HOME/src/terminal-history ]; then
    [[ "$bash_interactive" ]] && echo $HOME/.bash_profile: invoke trimhistory
    pushd . > /dev/null
    trimhistory trim -b $HOME/src/terminal-history/.bash_history $HOME/.bash_history
    if [ -r "$HOME/Library/Application Support/jp.tinyport.trimhistory/statistics.toml" ]; then
        cp "$HOME/Library/Application Support/jp.tinyport.trimhistory/statistics.toml" $HOME/src/terminal-history
    elif [ -r $HOME/.local/share/trimhistory/statistics.toml ]; then
        cp $HOME/.local/share/trimhistory/statistics.toml $HOME/src/terminal-history
    fi

    cd $HOME/src/terminal-history
    [[ "$(git diff --name-only)" ]] && git add . && git commit -m "auto update $(date +%Y%m%d-%H%M%S)" > /dev/null
    popd > /dev/null
fi

unset bash_interactive
