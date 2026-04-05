{
  sops = {

    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "fabius/rpc_secret" = { };
      "fabius/admin_token" = { };
      "ups/nut_admin_password" = { };
      "ups/nut_exporter_password" = { };
      "ups/crutonjohn_password" = { };
    };
  };
}
