#!/bin/bash

# I use this in Conky.  It displays the current volume on my system,
# and displays [M] if the volume is 0.

mute=`amixer get Master | grep "Mono:" | awk '{print $6}'`
vol=`amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d '[]'`

if [[ "$mute" == "[off]" ]]; then
    echo "Mute"
else
    echo "$vol"
fi
