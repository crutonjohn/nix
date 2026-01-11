{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  # head -c 8 /etc/machine-id
  networking.hostId = "3787caae";

  # fileSystems."/mnt/olympia" = {
  #   device = "olympia/root";
  #   fsType = "zfs";
  # };

  # fileSystems."/mnt/olympia/volsync" = {
  #   device = "olympia/volsync";
  #   fsType = "zfs";
  # };

  # fileSystems."/mnt/olympia/docker" = {
  #   device = "olympia/docker";
  #   fsType = "zfs";
  # };

  # fileSystems."/mnt/olympia/users/crutonjohn" = {
  #   device = "olympia/crutonjohn";
  #   fsType = "zfs";
  # };

  # fileSystems."/mnt/olympia/music" = {
  #   device = "olympia/music";
  #   fsType = "zfs";
  # };

  # fileSystems."/mnt/olympia/videos" = {
  #   device = "olympia/videos";
  #   fsType = "zfs";
  # };

  boot.zfs.extraPools = [
    "WD-RD0E4NHE"
  ];

}
