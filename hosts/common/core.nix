# catch-all environment pkgs
# unknown or old stuff idk what to do with
# could be important or could be garbage
# or could be stuff i'm afraid to remove
{
  pkgs,
  ...
}:

{

  environment = {
    systemPackages = with pkgs; [
      at-spi2-atk
      libnotify
      libinput
      glfw
      linux-firmware
      sshpass
      lxappearance
      toybox
      xsettingsd
      xorg.xrdb
    ];
  };
}
