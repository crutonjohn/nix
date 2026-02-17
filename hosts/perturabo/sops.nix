{
  sops = {

    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "garage/rpc_secret" = { };
      "garage/admin_token" = { };
      "ups/nut_admin_password" = { };
    };
  };
}
