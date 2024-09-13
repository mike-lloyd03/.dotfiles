const get = (args: string) => Number(Utils.exec(`brightnessctl ${args}`));

class Brightness extends Service {
  static {
    Service.register(
      this,
      {},
      {
        screen: ["float", "rw"],
      },
    );
  }

  #screenMax = get("max");
  #screen = get("get") / (get("max") || 1);

  get screen() {
    return this.#screen;
  }

  set screen(percent) {
    if (percent < 0) percent = 0;

    if (percent > 1) percent = 1;

    Utils.execAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(
      () => {
        this.#screen = percent;
        this.changed("screen");
      },
    );
  }

  constructor() {
    super();

    const screenPath = `/sys/class/backlight/amdgpu_bl2/brightness`;

    Utils.monitorFile(screenPath, async (f) => {
      const v = await Utils.readFileAsync(f);
      this.#screen = Number(v) / this.#screenMax;
      this.changed("screen");
    });
  }
}

export default new Brightness();
