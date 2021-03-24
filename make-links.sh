#!/bin/bash

BASETARGET=${1:-$HOME}
TARGET=$BASETARGET/.config
mkdir -p $TARGET
WD=$(pwd)
for dir in ./config/*; do
    dir=${dir%*/}
    dir=${dir##*/}
    [[ -L "$TARGET/$dir" ]] && rm "$TARGET/$dir"
    [[ -e "$TARGET/$dir" ]] && echo "Skipping $TARGET/$dir"
    ln -s $WD/config/$dir $TARGET/$dir
    [[ -x "$TARGET/$dir/setup" ]] && $TARGET/$dir/setup "$@"
done

for ti in ./.terminfo-italic-fix/*.ti; do
    tic $ti
done

mkdir -p $BASETARGET/.local/bin
for bin in ./bin/*; do
    bin=${bin##*/}
    [[ -L "$BASETARGET/.local/bin/$bin" ]] && rm "$BASETARGET/.local/bin/$bin"
    [[ -e "$BASETARGET/.local/bin/$bin" ]] && echo "Skipping $BASETARGET/.local/bin/$bin"
    ln -s $WD/bin/$bin $BASETARGET/.local/bin/$bin
done

[[ ! -d $TARGET/kak/plugins ]] && mkdir $TARGET/kak/plugins

[[ -L "$BASETARGET/.ssh" ]] && rm "$BASETARGET/.ssh"
[[ -e "$BASETARGET/.ssh" ]] && echo "Skipping $BASETARGET/.ssh"
ln -s $WD/ssh $BASETARGET/.ssh
