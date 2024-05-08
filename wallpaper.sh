#!/usr/bin/env bash

export DISPLAY=":0.0"

current_hour=$(date +%H)

night_start=20
night_end=6

if [ "$current_hour" -ge $night_start ] || [ "$current_hour" -lt $night_end ]; then
	feh --bg-fill ~/Obrazy/Wallpaper/night.jpg
else
	feh --bg-fill ~/Obrazy/Wallpaper/iceland.jpg
fi
