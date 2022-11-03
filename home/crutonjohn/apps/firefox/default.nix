{ pkgs, lib, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  programs.firefox = {
    enable = true;
    extensions = with addons; [
      onepassword-password-manager
      bitwarden
      ublock-origin
      darkreader
    ];
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "start.duckduckgo.com";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "media.av1.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };
}