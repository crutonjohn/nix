{ ... }:

{
  networking.hostName = "wayward";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.firewall = {
    enable = false;
    # allowedUDPPorts = [ 51830 ]; # Clients and peers can use the same port, see listenport
  };
  networking.nat = {
    enable = true;
    externalInterface = "wlp166s0";
#    internalInterfaces = [ "wg0" ];
  };
  # Open ports in the firewall
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 51830 ];
  };
  # tailscale daemon
  services.tailscale = {
    enable = true;
  };
}
