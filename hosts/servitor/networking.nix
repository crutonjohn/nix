{ ... }:

{
  networking.hostName = "servitor";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 51830 ];
    # allowedUDPPorts = [ 51830 ]; # Clients and peers can use the same port, see listenport
  };
  networking.nat = {
    enable = true;
    externalInterface = "enp8s0";
  };

  # tailscale daemon
  services.tailscale = {
    enable = true;
  };
}
