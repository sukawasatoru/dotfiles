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

[[ "$(which trimhistory)" ]] && trimhistory ~/.bash_history

unset bash_interactive
