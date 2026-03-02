{ ... }:

{
  home = {
    sessionVariables = {
      # AQ_DRM_DEVICES = "/dev/dri/by-path/pci-0000:01:00.0-card";
      # WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:01:00.0-card";
      LIBVA_DRIVER_NAME = nvidia;
      __GLX_VENDOR_LIBRARY_NAME = nvidia;
      NIXOS_OZONE_WL = "1";
    };
  };
}
