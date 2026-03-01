{
  appimageTools,
  gsettings-desktop-schemas,
  gtk3,
  fetchurl,
  ...
}:
let
  version = "8.15.1.0";
  appImage = fetchurl {
    url = "https://github.com/badabing2005/PixelFlasher/releases/download/v${version}/PixelFlasher-x86_64.AppImage";
    sha256 = "sha256:8e3573bcc485ce09977fe25917b7002090f94a3aef009756cd56219a4d7fab2a";
  };
in
appimageTools.wrapType2 {
  pname = "pixelflasher";
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

      # android tools
      android-tools

      # needed for icons
      adwaita-icon-theme
    ]);
}
