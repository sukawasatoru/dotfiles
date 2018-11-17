case $- in
    *i*) bash_interactive=1;;
      *) ;;
esac

[[ "$bash_interactive" ]] && echo ~/.bash_profile

if [ -f ~/.profile ]; then
    [[ "$bash_interactive" ]] && echo "$HOME/.bash_profile: load $HOME/.profile"
    source $HOME/.profile
fi

if [ "$bash_interactive" -a -f ~/.bashrc ]; then
    echo "$HOME/.bash_profile: load $HOME/.bashrc"
    source $HOME/.bashrc
fi

[[ "$(which trimhistory)" ]] && trimhistory ~/.bash_history

unset bash_interactive
