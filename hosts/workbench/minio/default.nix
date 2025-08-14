{ ... }:

{

  imports =
    [
     ./nginx.nix
    ];

  services.minio = {
    enable = true;
    browser = true;
    dataDir = [
      "/WD-RD0E4NHE/volsync/minio"
    ];
    configDir = "/WD-RD0E4NHE/volsync/minio-config";
    consoleAddress = "127.0.0.1:9001";
    listenAddress = "127.0.0.1:9000";
  };
}
