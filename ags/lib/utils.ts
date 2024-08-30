const audio = await Service.import("audio");

export function Padding(
  windowName: string | null = null,
  { css = "", vexpand = true } = {},
) {
  return Widget.EventBox({
    hexpand: true,
    vexpand,
    can_focus: false,
    child: Widget.Box({ css: "background-color: transparent;" + css }),
    setup: (w) => {
      if (windowName) {
        w.on("button-press-event", () => App.closeWindow(windowName));
      }
    },
  });
}

export function getVolumeIcon() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  const icon = audio.speaker.is_muted
    ? 0
    : [101, 67, 34, 1, 0].find(
        (threshold) => threshold <= audio.speaker.volume * 100,
      );

  if (icon) {
    return `audio-volume-${icons[icon]}-symbolic`;
  } else {
    return `audio-volume-muted-symbolic`;
  }
}
