#!/bin/bash -ux

cp -f ~/.android/androidtool.cfg $(dirname $0)/.android
cp -f ~/.bash_aliases $(dirname $0)
cp -f ~/.bash_completion $(dirname $0)
cp -rf ~/.bash_completion.d $(dirname $0)
cp -f ~/.bash_profile $(dirname $0)
cp -f ~/.bashrc $(dirname $0)
cp -f ~/.gitconfig $(dirname $0)
cp -f ~/.gradle/gradle.properties $(dirname $0)/.gradle
cp -f ~/.inputrc $(dirname $0)
cp -f ~/.profile $(dirname $0)
cp -f ~/.tmux.conf $(dirname $0)
cp -f ~/.vimrc $(dirname $0)

if [ $(uname -s) = "Darwin" ]; then
    cp -f {~,$(dirname $0)}/Library/LaunchAgents/setenv.ANDROID_HOME.plist
    cp -f {~,$(dirname $0)}/Library/LaunchAgents/setenv.ANDROID_SDK_ROOT.plist
    cp -f {~,$(dirname $0)}/Library/LaunchAgents/setenv.JAVA_HOME.plist
fi
