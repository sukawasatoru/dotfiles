#!/usr/bin/env bash

set -ux
target=$(dirname $0)

cp -f ~/.android/androidtool.cfg $target/.android
cp -f ~/.bash_aliases $target
cp -f ~/.bash_completion $target
rsync --delete -crltvhi ~/.bash_completion.d $target
cp -f ~/.bash_profile $target
cp -f ~/.bashrc $target
cp -f ~/.config/git/ignore $target/.config/git
cp -f ~/.gitconfig $target
cp -f ~/.gitconfig.mac $target
cp -f ~/.gitconfig.ubuntu $target
cp -f ~/.gradle/gradle.properties $target/.gradle
cp -f ~/.ideavimrc $target
cp -f ~/.inputrc $target
cp -f ~/.profile $target
cp -f ~/.tmux.conf $target
cp -f ~/.vim/vimrc .vim/

if [ $(uname -s) = "Darwin" ]; then
    cp -f ~/.config/alacritty/alacritty.yml $target/.config/alacritty/alacritty_macos.yml
    cp -f ~/Library/Application\ Support/Code/User/{keybindings.json,settings.json} $target/Library/Application\ Support/Code/User
    cp -f ~/Library/Application\ Support/JetBrains/CLion2020.3/idea.properties $target/Library/Application\ Support/JetBrains/CLion2020.3
    cp -f ~/Library/Application\ Support/JetBrains/IntelliJIdea2020.2/idea.vmoptions $target/Library/Application\ Support/JetBrains/IntelliJIdea2020.2
    rsync --delete -crltvhi ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Default $target/Library/Application\ Support/Sublime\ Text\ 3/Default
    rsync --delete -crltvhi ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User $target/Library/Application\ Support/Sublime\ Text\ 3/Packages
fi

cp -f ~/bin/apktool $target/bin
cp -f ~/bin/bfg $target/bin
cp -f ~/bin/dex2jar $target/bin
cp -f ~/bin/nproc $target/bin
cp -f ~/bin/sdedit $target/bin
