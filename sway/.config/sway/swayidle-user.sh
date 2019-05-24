#! /bin/bash

. "/home/seth/.cache/wal/colors.sh"

# TODO test if swayidle and swaylock exits

swayidle -w \
    timeout 300 'swaylock -i /home/seth/wallpapers/iceburg.jpg' \
    timeout 600 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    before-sleep 'swaylock -i /home/seth/wallpapers/iceburg.jpg'
