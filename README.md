# Autorotate Touchscreen Script

This is a workaround script to automatically rotate the touchscreen input to match the screen orientation on devices like the Lenovo Yoga 370 running Kali Linux with GNOME. It listens for display rotation changes and adjusts the touchscreen coordinate mapping accordingly.

---

## Why?

Some convertible laptops and tablets do not properly rotate the touchscreen input when the screen orientation changes. This script fixes that by syncing the touchscreen input with the current display rotation.

---

## Tested on

- Lenovo Yoga 370  
- Kali Linux with GNOME desktop environment

**It should work on other Linux systems with similar hardware and software configurations.**

---

## Requirements

- `xinput` — to control input devices  
- `xrandr` — to query screen orientation  
- A touchscreen device detected by `xinput` (the script automatically detects the Wacom Finger device)  
- Bash shell (tested with GNU Bash)

---

## How to use

1. Clone or download this repository:

   ```bash
   git clone https://github.com/USERNAME/autorotate-touchscreen.git
   cd autorotate-touchscreen 

2. Make the script Executable:
   ```bash
   chmod +x autorotate.sh

3. Run the script, rotate your screen and test if touchscreen works as intended
   ```bash
   ./autorotate.sh

The script runs in a loop, checking the screen orientation every second and rotating the touchscreen accordingly.

4. To autostart the script on GNOME login without showing a terminal window, create a .desktop autostart entry in ~/.config/autostart/ (see the repo Wiki or system documentation).

## How it works
Detects the current screen orientation (normal, left, right, or inverted) using xrandr.

Automatically detects the touchscreen device ID via xinput.

Sets the touchscreen coordinate transformation matrix to match the detected orientation.

Continuously monitors for orientation changes every second and updates the touchscreen accordingly.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contributions and Issues
Feel free to open issues or submit pull requests to improve compatibility or add features.

_Made with 🧠 & ☕_
