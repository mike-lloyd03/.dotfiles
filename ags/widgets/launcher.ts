import Gtk from "gi://Gtk?version=3.0";
import type { Application } from "types/service/applications";
import { Padding } from "lib/utils";
const appSvc = await Service.import("applications");

const WINDOW_NAME = "ags-launcher";

function AppItem(app: Application) {
  return Widget.Revealer({
    transition: "none",
    child: Widget.Button({
      attribute: { app },
      on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        app.launch();
      },
      classNames: ["launcher-item"],
      child: Widget.Box({
        children: [
          Widget.Icon({
            icon: app.icon_name || "",
            size: 42,
            className: "app-icon",
          }),
          Widget.Label({
            label: app.name,
            className: "app-label",
          }),
        ],
      }),
    }),
  });
}

function Launcher() {
  let appList = Variable(appSvc.query(""));

  const entry = Widget.Entry({
    classNames: ["launcher-entry"],
    hexpand: true,

    on_accept: () => {
      const result = list.child.children[0];
      if (result) {
        App.closeWindow(WINDOW_NAME);
        result.child.attribute.app.launch();
      }
    },

    on_change: ({ text }) => {
      if (text) {
        if (text.startsWith("calc:")) {
          entryIcon.icon = "mathmode-symbolic";
          calc.reveal_child = true;
          list.reveal_child = false;

          entry.toggleClassName("calc-mode", true);

          const equation = text.replace("calc:", "");
          const result = Utils.exec(`kalker "${equation}"`);

          calc.child.children[0].label = result;
        } else {
          appList.value = appSvc.query(text);
          entryIcon.icon = "terminal-symbolic";
          list.reveal_child = true;
          calc.reveal_child = false;

          list.child.children.forEach((item, i) => {
            if (i >= 5) {
              item.reveal_child = false;
              return;
            }
            item.reveal_child = true;
            item.toggleClassName("selected", i == 0);
          });
        }
      } else {
        calc.reveal_child = false;
        list.reveal_child = false;
        appList.value = [];
      }
    },
  });

  const entryIcon = Widget.Icon({ size: 24 });

  const entryRow = Widget.Box({
    spacing: 8,
    children: [entryIcon, entry],
  });

  const list = Widget.Revealer({
    transition: "slide_down",
    child: Widget.Box({
      vertical: true,
      children: appList.bind().as((appList) => appList.map(AppItem)),
    }),
  });

  const calc = Widget.Revealer({
    child: Widget.Box({
      valign: Gtk.Align.CENTER,
      margin: 12,
      children: [
        Widget.Label({
          label: "",
        }),
      ],
    }),
  });

  return Widget.Box({
    vertical: true,
    className: "launcher",
    vpack: "start",
    children: [entryRow, calc, list],

    setup: (self) =>
      self.hook(App, (_, windowName, visible) => {
        if (windowName !== WINDOW_NAME) {
          return;
        }

        if (visible) {
          entryIcon.icon = "terminal-symbolic";
          appList.value = [];
          entry.text = "";
          entry.grab_focus();
        }
      }),
  });
}

function Layout() {
  return Widget.CenterBox({
    startWidget: Padding(WINDOW_NAME),
    centerWidget: Widget.Box({
      vertical: true,
      children: [
        Padding(WINDOW_NAME, { css: "min-height: 400px;", vexpand: false }),
        Widget.Revealer({
          transition: "slide_right",
          child: Launcher(),
          setup: (self) =>
            self.hook(App, (_, wname, visible) => {
              if (wname === WINDOW_NAME) {
                self.reveal_child = visible;
              }
            }),
        }),
        Padding(WINDOW_NAME),
      ],
    }),
    endWidget: Padding(WINDOW_NAME),
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
    keymode: "on-demand",
    exclusivity: "ignore",
    layer: "top",
    anchor: ["top", "bottom", "right", "left"],
    child: Layout(),
  });
}
