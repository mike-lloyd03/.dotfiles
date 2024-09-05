import { Padding } from "./utils";

const WINDOW_NAME = "ags-cliphist";
const MAX_ITEMS = 10;

function ClipItem(item: string) {
  return Widget.Revealer({
    transition: "none",
    child: Widget.Button({
      attribute: { item },
      on_clicked: () => {
        Utils.execAsync(
          `bash -c "echo -n '${item}' | cliphist decode | wl-copy"`,
        ).catch((err) => print("Error:", err));
        App.closeWindow(WINDOW_NAME);
      },
      className: "launcher-item",
      child: Widget.Box({
        child: Widget.Label({
          label: item.split("\t")[1],
          maxWidthChars: 72,
          truncate: "end",
        }),
      }),
    }),
  });
}

function Cliphist() {
  let cliphist = Variable([""]);

  const entry = Widget.Entry({
    classNames: ["launcher-entry"],
    hexpand: true,

    on_accept: () => {
      const result = list.children.filter((item) => item.reveal_child)[0];
      if (result) {
        result.child.activate();
      }
    },

    on_change: ({ text }) => {
      list.children.forEach((item, i) => {
        if (i < MAX_ITEMS) {
          if (
            text &&
            !item.child.attribute.item
              .toLowerCase()
              .includes(text?.toLowerCase() ?? "")
          ) {
            item.reveal_child = false;
            return;
          }
          item.reveal_child = true;
          return;
        }
        item.reveal_child = false;
      });
    },
  });

  const entryRow = Widget.Box({
    spacing: 8,
    children: [Widget.Icon({ icon: "clipboard-symbolic", size: 24 }), entry],
  });

  const list = Widget.Box({
    vertical: true,
    children: cliphist.bind().as((cliphist) => cliphist.map(ClipItem)),
  });

  return Widget.Box({
    vertical: true,
    className: "launcher",
    vpack: "start",
    children: [entryRow, list],

    setup: (self) =>
      self.hook(App, (_, windowName, visible) => {
        if (windowName !== WINDOW_NAME) {
          return;
        }

        if (visible) {
          // Use tr to trim out non-UTF8 characters
          Utils.execAsync("bash -c 'cliphist list | tr -d \"\\200-\\377\"'")
            .then((cliplist) => {
              cliphist.setValue(cliplist.split("\n"));
              list.children
                .slice(0, MAX_ITEMS)
                .forEach((item) => (item.reveal_child = true));
            })
            .catch((err) => print("Error getting cliphist list:", err));
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
          child: Cliphist(),
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
