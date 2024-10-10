class TunedService extends Service {
  static {
    Service.register(
      this,
      // signals
      {
        // 'name-of-signal': [type as a string from GObject.TYPE_<type>],
        "active-profile-changed": ["string"],
        "service-is-active-changed": ["boolean"],
      },
      // properties
      {
        // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
        "active-profile": ["string", "rw"],
        "service-is-active": ["boolean", "r"],
      },
    );
  }

  #activeProfile = "";
  #serviceIsActive = false;

  // the getter has to be in snake_case
  get active_profile() {
    return this.#activeProfile;
  }

  // the setter has to be in snake_case too
  set active_profile(profile: string) {
    if (profile === "off") {
      Utils.execAsync(`tuned-adm off`);
    } else {
      Utils.execAsync(`tuned-adm profile ${profile}`);
    }
  }

  get service_is_active() {
    return this.#serviceIsActive;
  }

  constructor() {
    super();

    Utils.monitorFile("/etc/tuned/active_profile", () =>
      this.#onProfileChange(),
    );

    this.#onProfileChange();
    this.#getServiceStatus();
  }

  #onProfileChange() {
    let activeProfile = Utils.exec("cat /etc/tuned/active_profile");
    if (activeProfile == "") {
      activeProfile = "off";
    }

    this.#activeProfile = activeProfile;

    this.changed("active-profile");

    this.emit("active-profile-changed", this.#activeProfile);
  }

  #getServiceStatus() {
    let status = Utils.exec("systemctl is-active tuned");
    this.#serviceIsActive = status == "active" ? true : false;
  }

  startService() {
    print("starting service");
    Utils.exec("systemctl start tuned");

    print("updating variable");
    this.#getServiceStatus();

    print("emitting changed");
    this.changed("system-is-active");

    print("emitting changed 2");
    this.emit("system-is-active-changed", this.#serviceIsActive);
  }
}

const service = new TunedService();

export default service;
