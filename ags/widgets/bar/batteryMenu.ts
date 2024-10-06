import tuned from "services/tuned";
import hardware from "services/hardware";
import PopupMenu from "lib/popupMenu";

function TuneD() {
  const activeProfile = tuned.bind("active_profile");

  const profiles = [
    {
      profile: "laptop-battery-powersave",
      icon: "battery-profile-powersave-symbolic",
    },
    { profile: "balanced-battery", icon: "power-profile-balanced-symbolic" },
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

function Hardware() {
  const cpuTempLabel = Widget.Label({
    label: hardware.bind("cpu_temp").as((f1) => `CPU: ${f1} °C`),
  });

  const iGpuTempLabel = Widget.Label({
    label: hardware.bind("igpu_temp").as((f1) => `iGPU: ${f1} °C`),
  });

  const dGpuTempLabel = Widget.Label({
    label: hardware.bind("dgpu_temp").as((f1) => `dGPU: ${f1} °C`),
  });

  const fan1Label = Widget.Label({
    label: hardware.bind("fan_1").as((f1) => `Fan 1: ${f1} rpm`),
  });

  const fan2Label = Widget.Label({
    label: hardware.bind("fan_2").as((f2) => `Fan 2: ${f2} rpm`),
  });

  return Widget.Box({
    vertical: true,
    children: [
      cpuTempLabel,
      iGpuTempLabel,
      dGpuTempLabel,
      fan1Label,
      fan2Label,
    ],
  });
}

export function BatteryMenu() {
  const name = "ags-battery-menu";

  const child = Widget.Box({
    vertical: true,
    children: [TuneD(), Hardware()],
  });

  return PopupMenu(name, child);
}
