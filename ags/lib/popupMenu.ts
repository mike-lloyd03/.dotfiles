import Gtk from "types/@girs/gtk-3.0/gtk-3.0";
import { Padding } from "./utils";

const PopupRevealer = (name: string, child: Gtk.Widget) =>
  Widget.Box(
    { css: "padding: 1px;", classNames: ["popup", name] },
    Widget.Revealer({
      transition: "slide_down",
      child: Widget.Box({
        class_name: "window-content",
        child,
      }),
      // transitionDuration: options.transition.bind(),
      setup: (self) =>
        self.hook(App, (_, wname, visible) => {
          if (wname === name) self.reveal_child = visible;
        }),
    }),
  );

function Layout(name: string, child: Gtk.Widget) {
  return Widget.Box(
    {},
    Padding(name),
    Widget.Box(
      {
        hexpand: false,
        vertical: true,
      },
      PopupRevealer(name, child),
      Padding(name),
    ),
  );
}

export default function (name: string, child: Gtk.Widget) {
  return Widget.Window({
    name: name,
    setup: (w) => w.keybind("Escape", () => App.closeWindow(name)),
    visible: false,
    keymode: "on-demand",
    exclusivity: "exclusive",
    layer: "top",
    anchor: ["top", "bottom", "right", "left"],
    child: Layout(name, child),
  });
}
