{ pkgs, ... }:

{


  boot.kernelModules = [ 
    "iwlwifi" 
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"

    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"  
  ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
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
