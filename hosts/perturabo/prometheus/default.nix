{ ... }:
{

  services.prometheus.exporters = {
    node = {
      enable = true;
      openFirewall = true;
      listenAddress = "0.0.0.0";
      port = 9100;
    };
    smartctl = {
      enable = true;
      openFirewall = true;
      listenAddress = "0.0.0.0";
      port = 9633;
      maxInterval = "5m";
      devices = [
        "/dev/disk/by-id/ata-WUH721414ALN6L0_9JH7X8PT"
        "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJ95TWT"
        "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJ9LR7T"
        "/dev/disk/by-id/ata-WUH721414ALN6L0_9JJA2VWT"
        "/dev/disk/by-id/nvme-SAMSUNG_MZVLW256HEHP-000H1_S340NA0K847530"
        "/dev/disk/by-id/ata-WDC_WD80EDAZ-11CEWB0_WD-RD0E4NHE"
      ];
    };
    zfs = {
      enable = true;
      openFirewall = true;
      listenAddress = "0.0.0.0";
      port = 9134;
      pools = [
        "olympia"
        "WD-RD0E4NHE"
      ];
    };
  };

}
