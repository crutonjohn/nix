{ lib, stdenv, pkgs, appimageTools, gsettings-desktop-schemas, gtk3, fetchurl, ...}:
let
  version = "02.02.02.56";
  appImage = fetchurl {
    #url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_linux_fedora-v${version}.AppImage";
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_ubuntu-24.04_PR-8184.AppImage";
    sha256 = "sha256:ce28a910ccf9f251bffaec6e6c2779ddce818c9f56ddda09f7f67c549a7e65ae";
  };
in
appimageTools.wrapType2 {
  pname = "bambu-studio";
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

