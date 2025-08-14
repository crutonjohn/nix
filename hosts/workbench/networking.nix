{ ... }:

{

  networking.nameservers = [ "192.168.130.2" "192.168.130.3" ];

  networking.hostName = "workbench";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 53 69 80 443 ];
    allowedUDPPorts = [ 53 51830 69 ];
    # allowedUDPPorts = [ 51830 ]; # Clients and peers can use the same port, see listenport
  };

  networking.nat = {
    enable = true;
    externalInterface = "eno1";
#    internalInterfaces = [ "wg0" ];
  };

}
