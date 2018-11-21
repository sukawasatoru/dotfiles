if [ "$PS1" ]; then
    echo $HOME/.profile
fi

if [ -f /proc/version ] && [ "`grep Microsoft /proc/version`" ]; then
    umask 0022
fi

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper`
fi

if [ -x /opt/local/sbin ]; then
    PATH=/opt/local/sbin:$PATH
fi

if [ -x /opt/local/bin ]; then
    PATH=/opt/local/bin:$PATH
fi

# adding an appropriate PATH variable for use with Android.
# ~/Library/LaunchAgents/setenv.ANDROID_SDK_ROOT.plist
# ~/Library/LaunchAgents/setenv.ANDROID_HOME.plist
if [ -x /opt/android-sdk-macosx ]; then
    ANDROID_SDK_ROOT=/opt/android-sdk-macosx
    export ANDROID_SDK_ROOT
    ANDROID_HOME=$ANDROID_SDK_ROOT
    export ANDROID_HOME
    PATH=/opt/android-sdk-macosx/tools/bin:$PATH
    PATH=/opt/android-sdk-macosx/platform-tools:$PATH
fi

if [ -x $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

if [ -x $HOME/.local/bin ]; then
    PATH=$HOME/.local/bin:$PATH
fi
# ~/Library/LaunchAgents/setenv.JAVA_HOME.plist
# export JAVA_HOME=`/usr/libexec/java_home`

if [ -x $HOME/.cargo/bin ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -x $HOME/.ndenv/bin ]; then
    PATH=$PATH:$HOME/.ndenv/bin
fi

if [ -x ~/Applications/terminal-notifier.app ]; then
    PATH=$HOME/Applications/terminal-notifier.app/Contents/MacOS:$PATH
fi

if [ -x ~/src/rust-myscript/target/release ]; then
    PATH=$HOME/src/rust-myscript/target/release:$PATH
fi

if [ -n "`which mypathhelper`" ]; then
    PATH=`mypathhelper`
fi

if [ "`which python`" -a -x "`python -m site --user-base`/bin" ]; then
    PATH=`python -m site --user-base`/bin:$PATH
fi

LANG=en_US.UTF-8
CLICOLOR=1
export CLICOLOR
EDITOR=vim
export EDITOR
if [ -x /Applications/Sublime\ Text.app ]; then
    if [ -x $HOME/bin ]; then
        function sublime_text()
        {
            open -Wna /Applications/Sublime\ Text.app $@
        }
        VISUAL=sublime_text
        export VISUAL
    fi
fi
TZ=JST-9
export TZ
