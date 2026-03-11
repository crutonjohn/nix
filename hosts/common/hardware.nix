{
  pkgs,
  inputs,
  ...
}:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  boot.kernelModules = [
    "iwlwifi"
    "kvm-amd"
  ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    package = pkgs-unstable.mesa;
    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  services.fwupd.enable = true;
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
  services.usbmuxd.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

}
