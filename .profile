launchlog()
{
    if [ "$PS1" ]; then
        echo "$@"
    fi
}

launchlog "$HOME/.profile"

if [ -f /proc/version ] && grep -q Microsoft /proc/version; then
    umask 0022
fi

if [ -x /usr/libexec/path_helper ]; then
    launchlog "$HOME"/.profile: invoke /usr/libexec/path_helper
    eval "$(/usr/libexec/path_helper)"
fi

for OS in macosx linux; do
    if [ -x /opt/android-sdk-$OS ]; then
        ANDROID_SDK_ROOT=/opt/android-sdk-$OS
        export ANDROID_SDK_ROOT
        ANDROID_HOME=$ANDROID_SDK_ROOT
        export ANDROID_HOME
        PATH=/opt/android-sdk-$OS/cmdline-tools/latest/bin:$PATH
        PATH=/opt/android-sdk-$OS/platform-tools:$PATH
        break
    fi
done

if [ -x /opt/local/sbin ]; then
    PATH=/opt/local/sbin:$PATH
fi

if [ -x /opt/local/bin ]; then
    PATH=/opt/local/bin:$PATH
fi

if [ -x "$HOME/.deno/bin" ]; then
    PATH=$HOME/.deno/bin:$PATH
fi

if [ -x "$HOME/bin" ]; then
    PATH=$HOME/bin:$PATH
fi

if [ -x "$HOME/.local/bin" ]; then
    PATH=$HOME/.local/bin:$PATH
fi

if [ -x /usr/libexec/java_home ] && [ -x "$(/usr/libexec/java_home 2> /dev/null)" ]; then
    launchlog "$HOME/.profile: invoke /usr/libexec/java_home"
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
fi

if [ -x "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

hash -r
if [ -n "$(command -v sccache)" ]; then
   # https://github.com/mozilla/sccache/blob/main/docs/Configuration.md
   RUSTC_WRAPPER=sccache
   export RUSTC_WRAPPER

   # 60*60*24=1day
   SCCACHE_IDLE_TIMEOUT=86400
   export SCCACHE_IDLE_TIMEOUT

   SCCACHE_CACHE_SIZE="50G"
   export SCCACHE_CACHE_SIZE
fi

if [ -x "$HOME/Applications/terminal-notifier.app" ]; then
    PATH=$HOME/Applications/terminal-notifier.app/Contents/MacOS:$PATH
fi

if [ -x "$HOME/src/rust-myscript/target/release" ]; then
    PATH=$HOME/src/rust-myscript/target/release:$PATH
fi

if [ -x "$HOME/src/ripgrep/target/release" ]; then
    PATH=$HOME/src/ripgrep/target/release:$PATH
fi

if [ -x "$HOME/.gem" ]; then
    GEM_HOME=$HOME/.gem
    export GEM_HOME
fi

if [ -x "$GEM_HOME/ruby/2.6.0" ]; then
    PATH=$PATH:$GEM_HOME/ruby/2.6.0/bin
fi

if [ -x "$GEM_HOME/ruby/2.3.0" ]; then
    PATH=$PATH:$GEM_HOME/ruby/2.3.0/bin
fi

if [ "$(command -v python3)" ] && [ -x "$(python3 -m site --user-base)/bin" ]; then
    launchlog "$HOME/.profile: invoke python"
    PATH=$(python3 -m site --user-base)/bin:$PATH
fi

if [ -x "$HOME/.yarn/bin" ]; then
    # for nvm
    # PATH="`yarn global bin`:$PATH"
    PATH=$PATH:$HOME/.yarn/bin
fi

if [ -n "$(command -v mypathhelper)" ]; then
    launchlog "$HOME/.profile: invoke mypathhelper"
    PATH=$(mypathhelper)
fi

if [ -x "$HOME/.nvm" ]; then
    NVM_DIR=$HOME/.nvm
    export NVM_DIR
    if [ "$(uname -s)" = "Darwin" ]; then
        launchlog "$HOME/.profile: load $NVM_DIR/nvm.sh"
        . "$NVM_DIR/nvm.sh"
    fi
fi

if [ -n "$(command -v docker)" ]; then
    DOCKER_BUILDKIT=1
    export DOCKER_BUILDKIT
fi

LANG=en_US.UTF-8
export LANG
CLICOLOR=1
export CLICOLOR
EDITOR=vim
export EDITOR
if [ -x /Applications/Sublime\ Text.app ]; then
    VISUAL=sublime_text
    export VISUAL
    sublime_text()
    {
        open -Wna /Applications/Sublime\ Text.app "$@"
    }
    export -f sublime_text
elif [ -x /opt/sublime_text/sublime_text ]; then
    VISUAL=/opt/sublime_text/sublime_text
    export VISUAL
fi
TZ=JST-9
export TZ

if [ -r "$HOME/.profile.local" ]; then
    launchlog "$HOME/.profile.local: load $HOME/.profile.local"
    . "$HOME/.profile.local"
fi
