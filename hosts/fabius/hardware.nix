{ ... }:

{
  boot.kernelModules = [
    "iwlwifi"
    "kvm-amd"
  ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    #extraPackages = with pkgs; [  ];
  };
  hardware.amdgpu = {
    opencl.enable = true;
    overdrive.enable = true;
    overdrive.ppfeaturemask = "0xfffd7fff";
  };
  # Fan Curve/Overclocker
  services.lact.enable = true;
  # Another Fan Curve/Cooler Tool
  programs.coolercontrol.enable = true;

  services.fwupd.enable = true;

  services.libinput.touchpad = {
    naturalScrolling = true;
    tapping = false;
    clickMethod = "clickfinger";
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  #Power stuff
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
  };
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        turbo = "auto";
        #scaling_min_freq = 800000;
        #scaling_max_freq = 3500000;
      };
      battery = {
        governor = "powersave";
        energy_performance_preference = "balance_power";
        turbo = "never";
        #scaling_min_freq = 800000;
        #scaling_max_freq = 2000000;
      };
    };
  };
  #powerManagement.powertop.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    LidSwitchExternalPower = "suspend-then-hibernate";
    IdleAction = "suspend-then-hibernate";
    IdleActionSec = "2min";
    HandlePowerKey = "suspend-then-hibernate";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=180min
  '';

  programs.xss-lock.enable = true;
  # enable uinput kernel mod and group
  hardware.uinput.enable = true;
  # Usbmuxd
  services.usbmuxd.enable = true;
  # Fingerprints
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  # Pipewire
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
        };
      };
      "11-quantum-sync" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
        };
      };
    };
  };

  services.udev.extraRules = ''
    # Keychron Devices (for use with web configuration)
    # Stolen from https://www.reddit.com/r/Keychron/comments/1e5um1u/a_linux_user_psa/
    # M3 8K
    #SUBSYSTEM=="usb", ATTR{idVendor}=="3434", ATTR{idProduct}=="d050", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d050", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    # Link
    #SUBSYSTEM=="usb", ATTR{idVendor}=="3434", ATTR{idProduct}=="d030", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d030", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    # Q3 Max
    #SUBSYSTEM=="usb", ATTR{idVendor}=="3434", ATTR{idProduct}=="0830", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0830", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

  '';

  services.upower.enable = true;
  services.ceph.client.enable = true;
}
