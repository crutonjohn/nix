{ name, nodes, pkgs, lib, inputs, ... }: {

services.tailscale = {
  enable = true;
  authKeyFile = "/run/secrets/tailscale/nord/preauthkey";
  port = 0;
};

}