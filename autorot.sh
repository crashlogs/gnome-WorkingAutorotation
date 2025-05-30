#!/bin/bash
# Redirect stdout and stderr to /dev/null to avoid any output
exec >/dev/null 2>&1

# ID of the touchscreen device
TOUCHSCREEN_ID=$(xinput list | grep -i 'wacom.*finger' | grep -o 'id=[0-9]\+' | head -n1 | sed 's/id=//')

# check if touchscreen was found, else don't run 
if [[ -z "$TOUCHSCREEN_ID" ]]; then
    echo "Error: Touchscreen device ID not found."
    exit 1
fi

# Function to rotate touchscreen based on screen orientation
rotate_touchscreen() {
    case "$1" in
        normal)
            xinput set-prop $TOUCHSCREEN_ID --type=float "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
            ;;
        left)
            xinput set-prop $TOUCHSCREEN_ID --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
            ;;
        right)
            xinput set-prop $TOUCHSCREEN_ID --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
            ;;
        inverted)
            xinput set-prop $TOUCHSCREEN_ID --type=float "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
            ;;
    esac
}

# Main loop
last_orientation=""
while true; do
    orientation=$(xrandr --verbose | grep -oP '(?<=\)\s)(normal|left|right|inverted)(?=\s\()')
    if [[ "$orientation" != "$last_orientation" ]]; then
        echo "Orientation changed to: $orientation"
        rotate_touchscreen "$orientation"
        last_orientation=$orientation
    fi
    sleep 1
done

