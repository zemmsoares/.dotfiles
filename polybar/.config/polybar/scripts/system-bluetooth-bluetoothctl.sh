#!/bin/sh

bluetooth_print() {
    icon="" # Bluetooth icon (e.g., e1a7)

    if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        devices_connected=0

        for device in $devices_paired; do
            device_info=$(bluetoothctl info "$device")

            if echo "$device_info" | grep -q "Connected: yes"; then
                device_output=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
                device_battery_percent=$(echo "$device_info" | grep "Battery Percentage" | awk -F'[()]' '{print $2}')

                if [ -n "$device_battery_percent" ]; then
                    if [ "$device_battery_percent" -gt 90 ]; then
                        device_battery_icon="#25"
                    elif [ "$device_battery_percent" -gt 60 ]; then
                        device_battery_icon="#24"
                    elif [ "$device_battery_percent" -gt 35 ]; then
                        device_battery_icon="#23"
                    elif [ "$device_battery_percent" -gt 10 ]; then
                        device_battery_icon="#22"
                    else
                        device_battery_icon="#21"
                    fi

                    device_output="$device_output $device_battery_icon $device_battery_percent%"
                fi

                if [ $devices_connected -gt 0 ]; then
                    printf ", %s" "$device_output"
                else
                    printf " %s" "$icon $device_output"
                fi

                devices_connected=$((devices_connected + 1))
            fi
        done

        if [ $devices_connected -eq 0 ]; then
            printf " %s Disconnected\n" "$icon"
        else
            printf '\n'
        fi
    else
        echo " $icon Bluetooth Off"
    fi
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
