#!/bin/bash

BASETARGET=${1:-$HOME}
TARGET=$BASETARGET/.config
mkdir -p $TARGET
WD=$(pwd)
for dir in ./config/*/; do
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
    cp ./bin/$bin $BASETARGET/.local/bin/$bin
done

[[ ! -d $TARGET/kak/plugins ]] && mkdir $TARGET/kak/plugins
