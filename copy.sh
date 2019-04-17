#!/usr/bin/env bash

set -ux
target=$(dirname $0)

cp -f ~/.android/androidtool.cfg $target/.android
cp -f ~/.bash_aliases $target
cp -f ~/.bash_completion $target
rsync --delete -crltvhi ~/.bash_completion.d $target
cp -f ~/.bash_profile $target
cp -f ~/.bashrc $target
cp -f ~/.gitconfig $target
cp -f ~/.gitconfig.mac $target
cp -f ~/.gitconfig.ubuntu $target
cp -f ~/.config/git/ignore $target/.config/git
cp -f ~/.gradle/gradle.properties $target/.gradle
cp -f ~/.inputrc $target
cp -f ~/.profile $target
cp -f ~/.tmux.conf $target
cp -f ~/.vimrc $target

if [ $(uname -s) = "Darwin" ]; then
    cp -f ~/.config/alacritty/alacritty.yml $target/.config/alacritty/alacritty_macos.yml
    cp -f {~,$target}/Library/Preferences/IntelliJIdea2018.3/idea.vmoptions
    cp -f {~,$target}/Library/LaunchAgents/setenv.ANDROID_HOME.plist
    cp -f {~,$target}/Library/LaunchAgents/setenv.ANDROID_SDK_ROOT.plist
    cp -f {~,$target}/Library/LaunchAgents/setenv.JAVA_HOME.plist
    rsync --delete -crltvhi ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User $target/Library/Application\ Support/Sublime\ Text\ 3/Packages
fi
