{ pkgs, ... }:

{

  imports = [
    ./nginx.nix
  ];

  sops = {
    secrets = {
      "garage/admin_token" = {
        mode = "0600";
        group = "garage";
        owner = "garage";
        restartUnits = [
          "garage.service"
          "garage-webui.service"
        ];
      };
      "garage/rpc_secret" = {
        mode = "0600";
        group = "garage";
        owner = "garage";
        restartUnits = [
          "garage.service"
          "garage-webui.service"
        ];
      };
    };
  };

  services.garage = {
    enable = true;
    package = pkgs.garage_2;
    settings = {
      data_dir = "/mnt/olympia/volsync/garage/data";
      metadata_dir = "/mnt/olympia/volsync/garage/meta";
      rpc_bind_addr = "192.168.130.4:3901";
      rpc_public_addr = "192.168.130.4:3901";
      rpc_secret_file = "/run/secrets/garage/rpc_secret";
      replication_factor = 1;
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
        admin_token_file = "/run/secrets/garage/admin_token";
      };
    };
  };
  systemd.services = {
    "garage" = {
      serviceConfig = {
        DynamicUser = false;
        User = "garage";
      };
      overrideStrategy = "asDropinIfExists";
    };
    "garage-webui" = {
      environment = {
        PORT = "3919";
        CONFIG_PATH = "/etc/garage.toml";
        AUTH_USER_PASS = "crutonjohn:$2y$10$nYauB7zjBZePTdUNEAEBteNJr6Me0WkytoLT77N3tdhcIEDcAXER.";
        API_BASE_URL = "https://admin.garage.heyjohn.family";
        S3_ENDPOINT_URL = "http://127.0.0.1:3900";
      };
      unitConfig = {
        Description = "Garage Web UI";
        After = "garage.service";
      };
      serviceConfig = {
        User = "garage";
        ExecStart = "/bin/sh -c 'API_ADMIN_KEY=$(cat /run/secrets/garage/admin_token) ${pkgs.garage-webui}/bin/garage-webui'";
        Restart = "always";
      };
    };
  };
  users.groups.garage = { };
  users.users = {
    garage = {
      description = "Garage S3 Storage";
      isNormalUser = false;
      isSystemUser = true;
      group = "garage";
      home = "/mnt/olympia/volsync/garage";
    };
  };
}
