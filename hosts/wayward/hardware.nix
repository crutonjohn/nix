{ pkgs, ... }:

{
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiVdpau libvdpau-va-gl ];
  };
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
  #services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    extraConfig = ''
      IdleAction=hybrid-sleep
      IdleActionSec=2min
      HandlePowerKey=suspend
    '';
  };

  programs.xss-lock.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;
  # Fingerprints
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  # Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  services.ceph.client.enable = true;
}
