# for scp
#[[ -z "$PS1" ]] && return
case $- in
    *i*) ;;
    *) return;;
esac

echo ~/.bashrc

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

[[ -f ~/lib/azure-cli/az.completion ]] && echo "$HOME/.bashrc: load $HOME/lib/azure-cli/az.completion" && source $HOME/lib/azure-cli/az.completion
[[ -f ~/.bash_aliases ]] && echo "$HOME/.bashrc: load $HOME/.bash_aliases" && source $HOME/.bash_aliases
[[ -f /opt/local/etc/bash_completion ]] && echo "$HOME/.bashrc: load /opt/local/etc/bash_completion" && source /opt/local/etc/bash_completion

PROMPT_COMMAND="PS1='\$(RET=\$?; [ \$RET -eq 0 ] && echo -n \"\[\e[0;32m\]\" || echo -n \"\[\e[0;31m\]\"; printf %3s \$RET)\$\[\e[m\] '; history -a; history -c; history -r"

[[ -s /opt/local/etc/profile.d/autojump.sh ]] && echo "$HOME/.bashrc: load /opt/local/etc/profile.d/autojump.sh" && source /opt/local/etc/profile.d/autojump.sh

# https://gist.github.com/umeyuki/0267d8e995e32012cfe8
peco_history() {
    declare l=$(HISTTIMEFORMAT=  history | LC_ALL=C sort -r |  awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}'   |  peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco_history'

# http://blog.glidenote.com/blog/2014/06/26/snippets-peco-percol/
function peco-snippets() {
    local line
    local snippet

    if [ ! -e ~/.snippets ]; then
        return 1
    fi

    declare l=$(grep -v "^#" ~/.snippets | peco --query "$READLINE_LINE" | sed "s/^\[.*\] *//g")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-x\C-x":peco-snippets'

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
            # TODO: ubuntu.
            terminal-notifier -message "Finished: $_tn_cmd"
            echo elapsed time: $dur seconds
        fi
        _tn_cmd=''
    }
fi
