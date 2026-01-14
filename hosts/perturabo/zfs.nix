{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  # head -c 8 /etc/machine-id
  networking.hostId = "3787caae";

  boot.zfs.extraPools = [
    "WD-RD0E4NHE"
    "olympia"
  ];

}
