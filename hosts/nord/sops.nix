{
  #imports = [ <sops-nix/modules/sops> ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "acme/linode/credentials" = { };
      "headscale/oidc_client_secret" = { };
      "tailscale/nord/preauthkey" = { };
      "alertmanager/environmentFile" = { };
      "prometheus/exporters/omada/environmentFile" = { };
    };
  };
}
