{ pkgs, ... }:

{

  imports = [
    ./nginx.nix
  ];

  services.garage = {
    enable = true;
    package = pkgs.garage_2;
    settings = {
      data_dir = "/mnt/olympia/volsync/garage/data";
      metadata_dir = "/mnt/olympia/volsync/garage/meta";
      rpc_bind_addr = "127.0.0.1:3901";
      s3_api = {
        s3_region = "us-east-1";
        root_domain = "s3.garage.heyjohn.family";
        api_bind_addr = "127.0.0.1:3900";
      };
      s3_web = {
        root_domain = "web.garage.heyjohn.family";
        bind_addr = "127.0.0.1:3902";
      };
      admin = {
        api_bind_addr = "192.168.130.4:3903";
        metrics_require_token = false;
      };
    };
  };
  systemd.units."garage.service" = {
    overrideStrategy = "asDropinIfExists";
    text = ''
      [Service]
      DynamicUser=false
      User=garage
    '';
  };
}
