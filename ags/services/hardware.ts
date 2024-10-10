const cpuChip = "cros_ec-isa-0000";
const iGpuChip = "amdgpu-pci-c400";
const dGpuChip = "amdgpu-pci-0300";

function normalizeTemp(temp: number): number {
  return temp + 0.15;
}

class HardwareService extends Service {
  static {
    Service.register(
      this,
      {
        "fan-1-changed": ["int"],
        "fan-2-changed": ["int"],
        "cpu-temp-changed": ["int"],
        "igpu-temp-changed": ["int"],
        "dgpu-temp-changed": ["int"],
      },
      {
        "fan-1": ["string", "r"],
        "fan-2": ["string", "r"],
        "cpu-temp": ["string", "r"],
        "igpu-temp": ["string", "r"],
        "dgpu-temp": ["string", "r"],
      },
    );
  }

  #fan_1 = 0;
  #fan_2 = 0;
  #cpu_temp = 0;
  #igpu_temp = 0;
  #dgpu_temp = 0;

  get fan_1() {
    return this.#fan_1;
  }

  get fan_2() {
    return this.#fan_2;
  }

  get cpu_temp() {
    return this.#cpu_temp;
  }

  get igpu_temp() {
    return this.#igpu_temp;
  }

  get dgpu_temp() {
    return this.#dgpu_temp;
  }

  constructor() {
    super();

    Utils.interval(1000, () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    const sensorJson = JSON.parse(Utils.exec("sensors -j"));

    this.#cpu_temp = sensorJson[cpuChip]["cpu@4c"]["temp4_input"];
    this.#cpu_temp = normalizeTemp(this.#cpu_temp);

    this.#fan_1 = sensorJson[cpuChip]["fan1"]["fan1_input"];
    this.#fan_2 = sensorJson[cpuChip]["fan2"]["fan2_input"];

    this.#dgpu_temp = sensorJson[dGpuChip]["edge"]["temp1_input"];
    this.#igpu_temp = sensorJson[iGpuChip]["edge"]["temp1_input"];

    this.changed("fan-1");
    this.changed("fan-2");
    this.changed("cpu-temp");
    this.changed("igpu-temp");
    this.changed("dgpu-temp");

    this.emit("fan-1-changed", this.#fan_1);
    this.emit("fan-2-changed", this.#fan_2);
    this.emit("cpu-temp-changed", this.#cpu_temp);
    this.emit("igpu-temp-changed", this.#igpu_temp);
    this.emit("dgpu-temp-changed", this.#dgpu_temp);
  }
}

const service = new HardwareService();

export default service;
