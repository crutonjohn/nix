{ ... }:

{
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    #extraPackages = with pkgs; [  ];
  };
  hardware.amdgpu.amdvlk.enable = true;
  hardware.amdgpu.opencl.enable = true;
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
  services.tlp = { enable = true; };
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
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend-then-hibernate";
    extraConfig = ''
      IdleAction=suspend-then-hibernate
      IdleActionSec=2min
      HandlePowerKey=suspend-then-hibernate
    '';
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=180min
  '';

  programs.xss-lock.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;
  # Fingerprints
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  # Pipewire
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
        "context.properties" = { "default.clock.rate" = 44100; };
      };
      "11-quantum-sync" = {
        "context.properties" = { "default.clock.min-quantum" = 1024; };
      };
    };
  };

  services.ceph.client.enable = true;
}
