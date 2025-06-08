const { St, Gio, GLib } = imports.gi;
const Main = imports.ui.main;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;

let myButton;
let isAutorotateEnabled = false;

function runCommand(args) {
    try {
        GLib.spawn_async(null, args, null, GLib.SpawnFlags.SEARCH_PATH, null);
    } catch (e) {
        log("Failed to run command: " + e.message);
    }
}

function init() {}

function enable() {
    myButton = new PanelMenu.Button(0.0, 'AutoRotateToggle');

    const icon = new St.Icon({
        gicon: Gio.icon_new_for_string('orientation-lock-symbolic'),
        style_class: 'system-status-icon',
    });

    myButton.add_child(icon);

    const menuItem = new PopupMenu.PopupMenuItem('Enable Auto-Rotate');

    menuItem.connect('activate', () => {
        isAutorotateEnabled = !isAutorotateEnabled;

        const cmd = isAutorotateEnabled ? 'start' : 'stop';

        runCommand(['bash', `${GLib.get_home_dir()}/.config/autostart/autorotate.sh`]);

        menuItem.label.text = isAutorotateEnabled ? 'Disable Auto-Rotate' : 'Enable Auto-Rotate';
    });

    myButton.menu.addMenuItem(menuItem);

    Main.panel.addToStatusArea('AutoRotateToggle', myButton, 1, 'right');
}

function disable() {
    if (myButton) {
        myButton.destroy();
        myButton = null;
    }
}
