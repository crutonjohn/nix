{ config, ... }:
{

  services.teamspeak3 = {
    enable = true;
    openFirewall = true;
  };

}
