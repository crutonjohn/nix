{ pkgs, config, ... }:

{
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  
  services.fwupd.enable = true;
  #Power stuff
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = false;
  };
  services.auto-cpufreq = {
    enable = false;
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
  powerManagement.powertop.enable = true;
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=180min
  '';

  programs.xss-lock.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;
}
