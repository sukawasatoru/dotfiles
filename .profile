if [ -n "$PS1" ]; then
    echo ~/.profile
fi

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper`
fi
# MacPorts Installer addition on 2012-12-01_at_14:53:21: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# adding an appropriate PATH variable for use with Android.
# ~/Library/LaunchAgents/setenv.ANDROID_SDK_ROOT.plist
# ~/Library/LaunchAgents/setenv.ANDROID_HOME.plist
export ANDROID_SDK_ROOT=/opt/android-sdk-macosx
export ANDROID_HOME=$ANDROID_SDK_ROOT

export PATH=/opt/android-sdk-macosx/tools/bin:$PATH
export PATH=/opt/android-sdk-macosx/platform-tools:$PATH

export PATH=$HOME/bin:$PATH
# ~/Library/LaunchAgents/setenv.JAVA_HOME.plist
# export JAVA_HOME=`/usr/libexec/java_home`

export LANG=en_US.UTF-8
export CLICOLOR=1
export EDITOR=vim
# export VISUAL=$EDITOR
export TZ=JST-9

export PATH="$HOME/.cargo/bin:$PATH"

export PATH=$PATH:$HOME/.ndenv/bin
eval "`ndenv init -`"

if [ -x ~/Applications/terminal-notifier.app ]; then
    PATH=$HOME/Applications/terminal-notifier.app/Contents/MacOS:$PATH
fi

if [ -x ~/src/rust-myscript/target/release ]; then
    PATH=$HOME/src/rust-myscript/target/release:$PATH
fi

if [ -n "`which mypathhelper`" ]; then
    export PATH=`mypathhelper`
fi
