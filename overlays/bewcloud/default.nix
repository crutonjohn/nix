{ lib, stdenv, pkgs, appimageTools, gsettings-desktop-schemas, gtk3, fetchurl, ...}:
let
  version = "0.0.5";
  appImage = fetchurl {
    url = "https://github.com/bewcloud/bewcloud-desktop/releases/download/v${version}/bewCloud-desktop-sync_${version}_amd64.AppImage";
    sha256 = "sha256-PVNhyXLIjivR5dBuOWL85/c5BAL2fKx3q6/5pKReWuE=";
  };
in
appimageTools.wrapType2 {
  pname = "bewcloud-desktop";
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
    adwaita-icon-theme
  ]);
}

