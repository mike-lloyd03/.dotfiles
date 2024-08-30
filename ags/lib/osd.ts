import brightness from "services/brightness";
const audio = await Service.import("audio");

import { getVolumeIcon, Padding } from "./utils";

const WINDOW_NAME = "ags-osd";

function OsdRevealer() {
  const indicator = Widget.Icon({
    size: 32,
  });

  const levelbar = Widget.LevelBar({
    vpack: "center",
    widthRequest: 170,
  });

  const revealer = Widget.Revealer({
    transition: "crossfade",
    child: Widget.Box({
      className: "osd",
      spacing: 8,
      children: [indicator, levelbar],
    }),
  });

  let count = 0;
  function show(value: number, max: number, icon: string) {
    revealer.reveal_child = true;
    levelbar.set_value(value);
    levelbar.set_max_value(max);
    indicator.icon = icon;
    count++;
    Utils.timeout(1000, () => {
      count--;

      if (count === 0) revealer.reveal_child = false;
    });
  }

  return revealer
    .hook(audio.speaker, () => show(audio.speaker.volume, 1.5, getVolumeIcon()))
    .hook(brightness, () =>
      show(brightness.screen, 1, "brightness-high-symbolic"),
    );
}

function Layout() {
  return Widget.CenterBox({
    startWidget: Padding(),
    centerWidget: Widget.Box({
      vertical: true,
      children: [
        Padding(),
        OsdRevealer(),
        Padding(null, {
          css: "min-height: 160px;",
          vexpand: false,
        }),
      ],
    }),
    endWidget: Padding(),
  });
}

const layout = Layout();

export default function () {
  return Widget.Window({
    name: WINDOW_NAME,
    visible: true,
    exclusivity: "ignore",
    clickThrough: true,
    layer: "overlay",
    anchor: ["top", "bottom", "right", "left"],
    child: layout,
  });
}
