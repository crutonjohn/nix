{ ... }:

{

  imports =
    [
#      ./nginx.nix
    ];

  services.minio = {
    enable = true;
    browser = true;
    dataDir = [
      "/WD-RD0E4NHE/volsync/minio"
    ];
    configDir = "/WD-RD0E4NHE/volsync/minio-config";
    consoleAddress = "192.168.130.4:9001";
    listenAddress = "192.168.130.4:9000";
  };
}
