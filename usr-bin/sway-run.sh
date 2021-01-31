#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -x $HOME/.config/sway/env.sh ]]; then
    source $HOME/.config/sway/env.sh
fi

systemd-cat --identifier=sway sway $@
