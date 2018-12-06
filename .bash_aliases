echo $HOME/.bash_aliases

function alias_mac()
{
    # alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
    alias grep='grep --color=auto'
    [[ "$(which rmtrash)" ]] && alias rm=rmtrash
    [[ 10 -le $(sw_vers -productVersion | cut -d. -f1) ]] && [[ 12 -le $(sw_vers -productVersion | cut -d. -f2) ]] && alias cp="cp -c"
}

function alias_linux()
{
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto --time-style=long-iso'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    else
        alias ls='ls --time-style=long-iso'
    fi
    [[ "$(which notify-send)" ]] && alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    [[ $(which trash-put) ]] && alias rm=trash-put
}

case $(uname -s) in
    "Darwin")
        alias_mac
        ;;
    "Linux")
        alias_linux
        ;;
    *)
        ;;
esac
