import { PopupNotifications } from "widgets/notifications/index";
import Bar from "widgets/bar/bar";
import Launcher from "widgets/launcher";
import Osd from "widgets/osd";
import Cliphist from "widgets/cliphist";
import Power from "widgets/power";
import Gtk from "gi://Gtk?version=3.0";
import Gdk from "gi://Gdk";

const notifications = await Service.import("notifications");
notifications.popupTimeout = 10000;

App.config({
  style: "./style.css",
  windows: [
    // ...forMonitors(Bar),
    Bar(),
    PopupNotifications(),
    Launcher(),
    Osd(),
    Cliphist(),
    Power(),
  ],
});

function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).flatMap(widget);
}

function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}

export {};
