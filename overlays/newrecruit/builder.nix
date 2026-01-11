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
  version = "1.32.68";
  appImage = fetchurl {
    url = "https://www.newrecruit.eu/downloads/builder/NewRecruit-Builder-${version}.AppImage";
    sha256 = "sha256-/R5yRBOvdXv2IvUKNpQkbZDxrENE1Kl6q/o1k61SCzw=";
  };
in
appimageTools.wrapType2 {
  pname = "newrecruit-builder";
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
      zlib

      # needed for icons
      adwaita-icon-theme
    ]);
}
