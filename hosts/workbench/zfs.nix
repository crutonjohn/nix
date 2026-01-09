{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "692807a9";

  boot.zfs.extraPools = [
    "WD-RD0E4NHE"
  ];

}
