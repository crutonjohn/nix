{ pkgs, ... }:

{
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk ];
  };
  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  #Power stuff
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  # Usbmuxd
  services.usbmuxd.enable = true;
  # Pipewire
  hardware.pulseaudio.enable = false;
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
