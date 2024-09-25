import { Padding } from "lib/utils";

const WINDOW_NAME = "ags-power";

function PowerButton(label: string, icon: string, cmd: string) {
  return Widget.Button({
    on_clicked: () => {
      App.closeWindow(WINDOW_NAME);
      Utils.execAsync(cmd);
    },
    className: "power-button-icon",
    child: Widget.Box({
      vertical: true,
      children: [Widget.Icon({ icon: icon, size: 48 }), Widget.Label(label)],
    }),
  });
}

function Power() {
  return Widget.Revealer({
    transition: "crossfade",
    setup: (self) =>
      self.hook(App, (_, wname, visible) => {
        if (wname === WINDOW_NAME) {
          self.reveal_child = visible;
        }
      }),
    child: Widget.Box({
      spacing: 16,
      className: "power",
      children: [
        PowerButton(
          "Lock",
          "system-lock-screen-symbolic",
          "hyprlock --immediate",
        ),
        PowerButton(
          "Logout",
          "system-log-out-symbolic",
          "loginctl kill-session $XDG_SESSION_ID",
        ),
        PowerButton("Suspend", "system-suspend-symbolic", "systemctl suspend"),
        PowerButton(
          "Hibernate",
          "system-suspend-hibernate-symbolic",
          "systemctl hibernate",
        ),
        PowerButton("Reboot", "system-reboot-symbolic", "reboot"),
        PowerButton("Shutdown", "system-shutdown-symbolic", "shutdown now"),
      ],
    }),
  });
}

function Layout() {
  // const css = "background-color: @bg-clear;";
  const css = "";
  return Widget.CenterBox({
    startWidget: Padding(WINDOW_NAME, { css }),
    centerWidget: Widget.Box({
      vertical: true,
      children: [
        Padding(WINDOW_NAME, { css }),
        Widget.Box({ css, child: Power() }),
        Padding(WINDOW_NAME, { css }),
      ],
    }),
    endWidget: Padding(WINDOW_NAME, { css }),
  });
}

export default function () {
  return Widget.Window({
    name: WINDOW_NAME,
    setup: (self) =>
      self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME);
      }),
    visible: false,
    exclusivity: "ignore",
    keymode: "on-demand",
    layer: "top",
    anchor: ["top", "bottom", "right", "left"],
    child: Layout(),
  });
}
