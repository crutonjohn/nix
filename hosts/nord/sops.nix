{
  #imports = [ <sops-nix/modules/sops> ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "acme/linode/credentials" = { };
      "acme/step/environmentFile" = { };
      "headscale/oidc_client_secret" = { };
      "tailscale/nord/preauthkey" = { };
      "alertmanager/environmentFile" = { };
      "prometheus/exporters/omada/environmentFile" = { };
      "prometheus/alertmanager/environmentFile" = { };
    };
  };
}
