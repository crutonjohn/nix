{ pkgs, ... }:

{
  # Intel GPU BS
  services.xserver.videoDrivers = [ "modesetting" ];

  # Pipewire
  hardware.pulseaudio.enable = false;
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  #Power stuff
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  # Blueman
  services.blueman.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Fingerprints
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # Enable X11/WM
  services.xserver.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  # TODO: migrate to i3-gaps
  # package = "pkgs.i3-gaps";
  # TODO: migrate to inline i3 config (maybe)
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <${
      pkgs.writeText "Xresources" ''
        Xcursor.theme: Adwaita
        Xcursor.size: 32
        Xft.dpi: 144
        Xft.autohint: 0
        Xft.lcdfilter:  lcddefault
        Xft.hintstyle:  hintfull
        Xft.hinting: 1
        Xft.antialias: 1
        Xft.rgba: rgb
      ''
    }
  '';

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
