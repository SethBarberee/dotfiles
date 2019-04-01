#! /bin/bash

. "$HOME/.cache/wal/colors.sh"

# TODO test if swayidle and swaylock exits

swayidle -w \
    timeout 300 'swaylock -f -i $wallapaper' \
    timeout 600 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    before-sleep 'swaylock -f -i $wallpaper'
