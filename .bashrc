[[ -z "$PS1" ]] && return

echo "$HOME/.bashrc"

[[ -r $HOME/.env ]] && echo "$HOME/.bashrc: load $HOME/.env" && source "$HOME/.env"

if [ "$(uname -s)" = "Linux" ]; then
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    [[ "$(command -v lsb_release)" ]] && [[ "$(lsb_release -c | cut -f2)" = "xenial" ]] && COMPLETION_XENIAL=1
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
    unset COMPLETION_XENIAL
fi

shopt -s checkjobs
shopt -s histappend
shopt -s checkhash
shopt -s checkwinsize

HISTCONTROL=(ignoreboth)
HISTFILE=~/.bash_history
HISTSIZE=-1
HISTFILESIZE=-1
IGNOREEOF=10

# for "C-w" on .inputrc
stty werase undef

[[ -r ~/.bash_aliases ]] && echo "$HOME/.bashrc: load $HOME/.bash_aliases" && source "$HOME/.bash_aliases"
[[ -r ~/lib/azure-cli/az.completion ]] && echo "$HOME/.bashrc: load $HOME/lib/azure-cli/az.completion" && source "$HOME/lib/azure-cli/az.completion"
[[ -r $NVM_DIR/nvm.sh ]] && echo "$HOME/.bashrc: load $NVM_DIR/nvm.sh" && source "$NVM_DIR/nvm.sh" --no-use

if [ -r /opt/local/share/bash-completion/bash_completion ]; then
    echo "$HOME/.bashrc: load /opt/local/share/bash-completion/bash_completion"
    source /opt/local/share/bash-completion/bash_completion
elif [ -r /opt/local/etc/bash_completion ]; then
    echo "$HOME/.bashrc: load /opt/local/etc/bash_completion"
    source /opt/local/etc/bash_completion
fi

PROMPT_COMMAND="PS1='\$(RET=\$?; [ \$RET -eq 0 ] && echo -n \"\[\e[0;32m\]\" || echo -n \"\[\e[0;31m\]\"; printf %3s \$RET)\$\[\e[m\] '; history -a; history -c; history -r"

if [ -s /usr/share/autojump/autojump.sh ]; then
    echo "$HOME/.bashrc: load /usr/share/autojump/autojump.sh"
    source /usr/share/autojump/autojump.sh
elif [ -s /opt/local/etc/profile.d/autojump.sh ]; then
    echo "$HOME/.bashrc: load /opt/local/etc/profile.d/autojump.sh"
    source /opt/local/etc/profile.d/autojump.sh
fi

# https://gist.github.com/umeyuki/0267d8e995e32012cfe8
peco_history() {
    declare l=$(HISTTIMEFORMAT= history | LC_ALL=C sort -r | awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco_history'

# http://blog.glidenote.com/blog/2014/06/26/snippets-peco-percol/
function peco-snippets() {
    if [ ! -e ~/.snippets ]; then
        return 1
    fi

    declare l=$(peco --query "$READLINE_LINE" ~/.snippets | sed "s/^\[.*\] *//g")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-x\C-x":peco-snippets'

# https://github.com/rcaloras/bash-preexec
# http://bearmini.hatenablog.com/entry/2016/02/16/222057
if [ -f ~/src/bash-preexec/bash-preexec.sh ]; then
    source ~/src/bash-preexec/bash-preexec.sh
    _tn_timestamp=$(date +%s)
    _tn_cmd=''
    preexec() {
        _tn_timestamp=$(date +%s)
        _tn_cmd=$1
    }
    precmd() {
        now=$(date +%s)
        dur=$(( $now - $_tn_timestamp ))
        if [[ $_tn_cmd == "" ]]; then
            return
        fi
        if [[ $dur -gt 60 ]]; then
            if [[ ! -v SSH_TTY ]]; then
                case $(uname -s) in
                    "Darwin")
                        terminal-notifier -message "Finished: $_tn_cmd"
                        ;;
                    "Linux")
                        alias -p | grep -q "alias alert=" && alert "Finished: $_tn_cmd"
                        ;;
                    *)
                        ;;
                esac
            fi
            echo elapsed time: $dur seconds
        fi
        _tn_cmd=''
    }
fi

[[ -f /proc/version ]] && [[ $(cat /proc/version) =~ Microsoft ]] && WSL=1

if [[ "$WSL" ]]; then
    DISPLAY=127.0.0.1:0.0
    export DISPLAY
fi

[[ -r $HOME/.bashrc.local ]] && echo "$HOME/.bashrc: load $HOME/.bashrc.local" && source $HOME/.bashrc.local
true
