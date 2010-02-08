#!/bin/bash

# I use this in Conky.  It displays the current volume on my system, 
# and displays [Mute] if the volume is on 0.  

mute=`amixer get Master | grep "Mono:" | awk '{print $6}'`
vol=`amixer get Master | grep "Mono:" | awk '{print $4}'`

if [ $mute == "[off]" ]
   then
     echo "[Mute]"
   else
     echo "$vol"
fi
