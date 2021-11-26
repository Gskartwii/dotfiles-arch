#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export WLR_NO_HARDWARE_CURSORS=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.userSystemAAFontSettings=lcd'
export QT_QPA_PLATFORM=wayland

if [[ -x $HOME/.config/sway/env.sh ]]; then
    source $HOME/.config/sway/env.sh
fi

systemd-cat --identifier=sway sway --my-next-gpu-wont-be-nvidia $@
