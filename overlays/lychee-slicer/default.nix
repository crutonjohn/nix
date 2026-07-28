{
  lib,
  stdenv,
  pkgs,
  appimageTools,
  gsettings-desktop-schemas,
  gtk3,
  fetchurl,
  ...
}:
let
  version = "7.6.6";
  appImage = fetchurl {
    url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
    sha256 = "sha256-eDMhA8fCD++BYK58t4/2XUlzrhcwtbAuOzRsThQAiVs=";
  };
in
appimageTools.wrapType2 {
  pname = "lychee-slicer";
  inherit version;

  src = appImage;

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS"
  '';

  extraPkgs =
    pkgs:
    (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
    ++ (with pkgs; [
      # fixes "unexpected error"
      gsettings-desktop-schemas
      glib
      gtk3

      # needed for icons
      adwaita-icon-theme
      libxshmfence
    ]);
}
