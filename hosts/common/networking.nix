{
  pkgs,
  ...
}:

{

  time.timeZone = "America/New_York";

  services.openssh.enable = true;

  environment = {
    systemPackages = with pkgs; [
      networkmanagerapplet
    ];
  };

  # tailscale daemon
  services.tailscale = {
    enable = true;
  };

}
