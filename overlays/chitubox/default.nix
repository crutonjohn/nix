{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;

stdenv.mkDerivation rec {
  pname = "chitubox";

  version = "2.3.1";

  src = fetchTarball {
    # url = "https://download.chitubox.com/17839/v${version}/CHITUBOX_Basic_linux_Installer_${version}";
    url = "https://sac.chitubox.com/software/download.do?softwareId=17839&softwareVersionId=v${version}&fileName=CHITUBOX_V${version}.tar.gz";
    sha256 = "0di0d3hg7jy2c63isdv50c3qsff9vk2x0305jjdqy8xpy62mh9dq";
  };
  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    stdenv.cc.cc.lib
    libglvnd
    libgcrypt
    zlib
    glib
    fontconfig
    freetype
    libdrm
  ];

  buildPhase = ''
    mkdir -p bin
    mv CHITUBOX bin/chitubox

    # Remove unused stuff
    rm AppRun

    # Place resources where ChiTuBox can expect to find them
    mkdir ChiTuBox
    mv resource ChiTuBox/

    # Configure Qt paths
    cat << EOF > bin/qt.conf
      [Paths]
      Prefix = $out
      Plugins = plugins
      Imports = qml
      Qml2Imports = qml
    EOF
  '';

  installPhase = ''
    mkdir -p $out
    mv * $out/
  '';

  meta = {
    description = "A Revolutionary Tool to Change 3D Printing Processes within One Click";
    homepage = "https://www.chitubox.com";
    license = {
      fullName = "ChiTuBox EULA";
      shortName = "ChiTuBox";
      url = "https://www.chitubox.com";
    };
  };
}
