#!/bin/bash

TARGET=${1:-$HOME}/.config
WD=$(pwd)
for dir in ./config/*/; do
    dir=${dir%*/}
    dir=${dir##*/}
    [[ -L "$TARGET/$dir" ]] && rm "$TARGET/$dir"
    ln -s $WD/config/$dir $TARGET/$dir
    [[ -x "$TARGET/$dir/setup" ]] && $TARGET/$dir/setup "$@"
done

for ti in ./.terminfo-italic-fix/*.ti; do
    tic $ti
done

[[ ! -d $TARGET/kak/plugins ]] && mkdir $TARGET/kak/plugins
