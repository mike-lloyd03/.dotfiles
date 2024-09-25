import tuned from "services/tuned";
import PopupMenu from "lib/popupMenu";

export function TuneD() {
  const activeProfile = tuned.bind("active_profile");

  const profiles = [
    {
      profile: "laptop-battery-powersave",
      icon: "battery-profile-powersave-symbolic",
    },
    { profile: "balanced", icon: "power-profile-balanced-symbolic" },
    { profile: "off", icon: "battery-profile-performance-symbolic" },
  ];

  const label = Widget.Label("TuneD Profile");

  const profileButtons = Widget.Box({
    spacing: 8,
    children: profiles.map((p) =>
      Widget.Button({
        child: Widget.Icon({
          icon: p.icon,
          size: 24,
        }),
        className: activeProfile.as(
          (a) =>
            `${a == p.profile ? "ags-battery-menu-profile active" : "ags-battery-menu-profile"}`,
        ),
        onPrimaryClick: () => {
          tuned.active_profile = p.profile;
        },
        tooltipText: p.profile,
      }),
    ),
  });

  return Widget.Box({
    vertical: true,
    children: [label, profileButtons],
  });
}

export function BatteryMenu() {
  const name = "ags-battery-menu";

  const child = Widget.Box({
    vertical: true,
    children: [TuneD()],
  });

  return PopupMenu(name, child);
}
