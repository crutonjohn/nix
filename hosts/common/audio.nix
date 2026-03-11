{ pkgs, ... }:

{

  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
        };
      };
      "11-quantum-sync" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      alsa-lib
      alsa-utils
      flac
      pulsemixer
    ];
  };
}
