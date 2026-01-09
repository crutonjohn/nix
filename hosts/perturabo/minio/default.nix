{ ... }:

{

  imports = [
    ./nginx.nix
  ];

  services.minio = {
    enable = true;
    browser = true;
    dataDir = [
      "/mnt/olympia/volsync/minio-data"
    ];
    configDir = "/mnt/olympia/volsync/minio-config";
    consoleAddress = "127.0.0.1:9001";
    listenAddress = "127.0.0.1:9000";
  };
}
