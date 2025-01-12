{ config, ... }: {

services.tailscale = {
  enable = true;
  # authKeyFile = "/run/secrets/tailscale/nord/preauthkey";
  port = 0;
  extraUpFlags = [
    "--login-server" 
    "${config.services.headscale.settings.server_url}"
    "--accept-routes"
  ];
};

}