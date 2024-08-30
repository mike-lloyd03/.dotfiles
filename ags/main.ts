import { PopupNotifications } from "lib/notifications/index";
import Bar from "lib/bar";
import Launcher from "lib/launcher";
import Osd from "lib/osd";

const notifications = await Service.import("notifications");
notifications.popupTimeout = 10000;

App.config({
  style: "./style.css",
  windows: [Bar(), PopupNotifications(), Launcher(), Osd()],
});

export {};
