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

  services.smartd = {
    enable = true;
    autodetect = false;
    devices = [
      {
        device = "/dev/disk/by-id/ata-WUH721414ALN6L0_9JH7X8PT";
      }
      {
        device = "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJ95TWT";
      }
      {
        device = "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJ9LR7T";
      }
      {
        device = "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJA2VWT";
      }
    ];
  };

}
