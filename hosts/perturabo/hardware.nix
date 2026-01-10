{ pkgs, ... }:

{
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  services.fwupd.enable = true;

  #Power stuff
  #services.tlp.enable = true;
  powerManagement.powertop.enable = true;

  programs.xss-lock.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;

  # Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.ceph.client.enable = true;
}
