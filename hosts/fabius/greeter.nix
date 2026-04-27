{ pkgs, ... }:
{

  services.xserver.enable = false;
  services.displayManager.sddm = {
    enable = true;
    # package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
      kdePackages.qtwayland
      kdePackages.qtbase
      sddm-astronaut
    ];
  };
  environment = {
    systemPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

}
