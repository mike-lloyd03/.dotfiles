import { RoundedAngleEnd } from "lib/roundedCorner";
import { NotificationIndicator } from "lib/notifications/index.js";
import { getVolumeIcon } from "./utils";
import PopupMenu from "./popupMenu";

const hyprland = await Service.import("hyprland");
const notifications = await Service.import("notifications");
const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
const network = await Service.import("network");
const powerProfiles = await Service.import("powerprofiles");

const date = Variable("", {
  poll: [1000, 'date "+%a %Y-%m-%d %H%M:%S"'],
});

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .filter(({ id }) => id > 0)
      .sort((a, b) => a.id - b.id)
      .map(({ id }) =>
        Widget.Button({
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${id}`),
          class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
        }),
      ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
    maxWidthChars: 40,
    truncate: "end",
  });
}

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });
}

function Notification() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}

function Media() {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0];
      return `${track_artists.join(", ")} - ${track_title}`;
    } else {
      return "Nothing is playing";
    }
  });

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  });
}

function Volume() {
  const icon = Widget.Icon({
    icon: Utils.watch(getVolumeIcon(), audio.speaker, getVolumeIcon),
    className: "icon",
  });

  const value = Widget.Label({
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.label = `${Math.round(audio.speaker.volume * 100)}%`;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    children: [icon, value],
  });
}

function secondsToHHMM(seconds: number): string {
  const totalMinutes = Math.floor(seconds / 60);
  const hours = Math.floor(totalMinutes / 60);
  const minutes = totalMinutes % 60;

  const hoursString = hours.toString().padStart(1, "0");
  const minutesString = minutes.toString().padStart(2, "0");

  return `${hoursString}:${minutesString}`;
}

function BatteryMenu() {
  const name = "ags-battery-menu";
  const activeProfile = powerProfiles.bind("active_profile");

  const profileIcons = {
    "power-saver": "battery-profile-powersave-symbolic",
    balanced: "power-profile-balanced-symbolic",
    performance: "battery-profile-performance-symbolic",
  };

  const child = Widget.Box({
    spacing: 8,
    children: powerProfiles.profiles.map((p) =>
      Widget.Button({
        child: Widget.Icon({
          icon: profileIcons[p["Profile"]],
          size: 24,
        }),
        className: activeProfile.as(
          (a) =>
            `${a == p["Profile"] ? "ags-battery-menu-profile active" : "ags-battery-menu-profile"}`,
        ),
        onPrimaryClick: () => {
          powerProfiles.active_profile = p["Profile"];
        },
      }),
    ),
  });

  return PopupMenu(name, child);
}

function BatteryLabel() {
  return Widget.Button({
    on_primary_click: () => App.toggleWindow("ags-battery-menu"),
    child: Widget.Box({
      visible: battery.bind("available"),
      children: [
        Widget.Icon({
          icon: battery.bind("icon_name"),
          className: "icon",
        }),
        Widget.Label({
          label: battery.bind("percent").as((p) => `${p}% `),
        }),
        Widget.Label({
          label: battery
            .bind("time_remaining")
            .as((t) => `(${secondsToHHMM(t)})`),
        }),
      ],
    }),
  });
}

function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
        className: "tray-item",
      }),
    ),
  );

  return Widget.Box({
    children: items,
  });
}

function WifiIndicator() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: network.wifi.bind("icon_name"),
        className: "icon",
      }),
      Widget.Label({
        label: network.wifi.bind("ssid").as((ssid) => ssid || "Unknown"),
      }),
    ],
  });
}

function WiredIndicator() {
  return Widget.Icon({
    icon: network.wired.bind("icon_name"),
    className: "icon",
  });
}

function NetworkIndicator() {
  return Widget.Stack({
    children: {
      wifi: WifiIndicator(),
      wired: WiredIndicator(),
    },
    shown: network.bind("primary").as((p) => p || "wifi"),
  });
}

function PowerMenu() {
  return Widget.Button({
    child: Widget.Icon({
      icon: "system-shutdown-symbolic",
      size: 16,
    }),
    on_primary_click: () => {
      App.toggleWindow("ags-power");
    },
    className: "power-icon",
  });
}

function Left() {
  return Widget.Box({
    spacing: 8,
    children: [Workspaces(), ClientTitle()],
    hpack: "start",
    className: "bar-group",
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [Clock()],
    className: "bar-group",
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      SysTray(),
      NotificationIndicator(),
      Volume(),
      BatteryLabel(),
      NetworkIndicator(),
      PowerMenu(),
    ],
    classNames: ["bar-group", "bar-right"],
  });
}

export default function (monitor = 0) {
  App.addWindow(BatteryMenu());

  return Widget.Window({
    name: `ags-bar-${monitor}`, // name has to be unique
    className: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      startWidget: Widget.Box({
        children: [
          Left(),
          RoundedAngleEnd("topright", { className: "bar-group" }),
        ],
      }),
      centerWidget: Widget.Box({
        children: [
          RoundedAngleEnd("topleft", { className: "bar-group" }),
          Center(),
          RoundedAngleEnd("topright", { className: "bar-group" }),
        ],
      }),
      endWidget: Widget.Box({
        hpack: "end",
        children: [
          RoundedAngleEnd("topleft", { className: "bar-group" }),
          Right(),
        ],
      }),
    }),
  });
}
