{ lib, stdenv, pkgs, appimageTools, gsettings-desktop-schemas, gtk3, fetchurl, ...}:
let
  version = "1.3.19";
  appImage = fetchurl {
    url = "https://www.newrecruit.eu/downloads/editor/NewRecruit-Editor-${version}.AppImage";
    sha256 = "sha256:ce28a910ccf9f251bffaec6e6c2779ddce818c9f56ddda09f7f67c549a7e65ae";
  };
in
appimageTools.wrapType2 {
  pname = "newrecruit-editor";
  inherit version;

  src = appImage;

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS"
  '';

  extraPkgs = pkgs: (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ (with pkgs; [
    # fixes "unexpected error"
    gsettings-desktop-schemas glib gtk3 zlib

    # needed for icons
    adwaita-icon-theme
  ]);
}

