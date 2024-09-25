class TunedService extends Service {
  static {
    Service.register(
      this,
      // signals
      {
        // 'name-of-signal': [type as a string from GObject.TYPE_<type>],
        "active-profile-changed": ["string"],
      },
      // properties
      {
        // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
        "active-profile": ["string", "rw"],
      },
    );
  }

  #activeProfile = "";

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

  constructor() {
    super();

    Utils.monitorFile("/etc/tuned/active_profile", () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    let activeProfile = Utils.exec("cat /etc/tuned/active_profile");
    if (activeProfile == "") {
      activeProfile = "off";
    }

    this.#activeProfile = activeProfile;

    this.changed("active-profile");

    this.emit("active-profile-changed", this.#activeProfile);
  }

  // overwriting the connect method, let's you
  // change the default event that widgets connect to
  connect(event = "active-profile-changed", callback) {
    return super.connect(event, callback);
  }
}

const service = new TunedService();

export default service;
