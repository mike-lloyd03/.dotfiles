const fan1File = "/sys/class/hwmon/hwmon10/fan1_input";
const fan2File = "/sys/class/hwmon/hwmon10/fan2_input";
const cpuFile = "/sys/class/hwmon/hwmon10/temp4_input";

class HardwareService extends Service {
  static {
    Service.register(
      this,
      {
        "fan-1-changed": ["string"],
        "fan-2-changed": ["string"],
        "cpu-temp-changed": ["int"],
      },
      {
        "fan-1": ["string", "r"],
        "fan-2": ["string", "r"],
        "cpu-temp": ["string", "r"],
      },
    );
  }

  #fan_1 = "0";
  #fan_2 = "0";
  #cpu_temp = 0;

  get fan_1() {
    return this.#fan_1;
  }

  get fan_2() {
    return this.#fan_2;
  }

  get cpu_temp() {
    return this.#cpu_temp;
  }

  constructor() {
    super();

    Utils.interval(1000, () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    this.#fan_1 = Utils.exec(`cat ${fan1File}`);
    this.#fan_2 = Utils.exec(`cat ${fan2File}`);
    let rawCpuTemp = Number(Utils.exec(`cat ${cpuFile}`));
    this.#cpu_temp = (rawCpuTemp + 150) / 1000;

    this.changed("fan-1");
    this.changed("fan-2");
    this.changed("cpu-temp");

    this.emit("fan-1-changed", this.#fan_1);
    this.emit("fan-2-changed", this.#fan_2);
    this.emit("cpu-temp-changed", this.cpu_temp);
  }
}

const service = new HardwareService();

export default service;
