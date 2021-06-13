#!/bin/sh
player_status=$(playerctl -p spotify status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl -p spotify metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -p spotify metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Stopped" ]; then
    echo " Spotify Stopped"
else
    echo " Unknown" 
fi
