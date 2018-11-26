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

if [ "$(which trimhistory)" ] && [ -x ~/src/terminal-history ]; then
    pushd . > /dev/null
    trimhistory -b ~/src/terminal-history/.bash_history ~/.bash_history
    cd ~/src/terminal-history
    [[ "$(git diff --name-only)" ]] && git add . && git commit -m "auto update $(date +%Y%m%d-%H%M%S)" > /dev/null
    popd > /dev/null
fi

unset bash_interactive
