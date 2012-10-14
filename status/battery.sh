#!/bin/bash

# Returns the battery %, time remaining, and charging status if on AC power
# Requires acpi 
#
# Output if battery discharging (Example):
# 68% 2:36 10.0W
# Note: Haven't figured out how to find watts yet
# Output if battery charching (Example):
# 72% Charging

# Battery percentage
batt_percent=`acpi -b | awk "{print $1}" | sed 's/\([^:]*\): \([^,]*\), \([0-9]*\)%.*/\3/'`

batt_time=`acpi -b | awk '{print $5}'`
cut_batt_time=`echo "$batt_time" | cut -c 1-2`

function format_time {
    if [ -n "$cut_batt_time" ]; then
        if (( "$cut_batt_time" < "10" )) ; then
            local time=`echo "$batt_time" | cut -c 2-5`
            echo "$time"
        else
            echo "$batt_time"
        fi
    else
        echo "Unknown"
    fi
}
result=$(format_time)

charging_status=$(cat /sys/class/power_supply/ADP1/online)

if [ "$charging_status" = "1" ] ; then
    echo "$batt_percent% Charging"
else
    echo "$batt_percent% $result"
fi
