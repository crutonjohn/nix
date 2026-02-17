{
  sops = {

    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "garage/rpc_secret" = { };
      "garage/admin_token" = { };
      "ups/nut_admin_password" = { };
      "ups/nut_exporter_password" = { };
    };
  };
}
