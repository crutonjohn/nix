{ lib, stdenv, pkgs, appimageTools, gsettings-desktop-schemas, gtk3, fetchurl, ...}:
let
  version = "2.0.3";
  appImage = fetchurl {
    url = "https://github.com/JanLunge/pog/releases/download/v${version}/pog-${version}-x86_64.AppImage";
    sha256 = "sha256-CJQJDX7HxbYTzq2/nVskH/uf6HPbMqLVHRtR3qMZ5bM=";
  };
in
appimageTools.wrapType2 {
  pname = "pog";
  inherit version;

  src = appImage;

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS"
  '';

  extraPkgs = pkgs: (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ (with pkgs; [
    # fixes "unexpected error"
    gsettings-desktop-schemas glib gtk3

    # needed for icons
    gnome.adwaita-icon-theme
  ]);
}
