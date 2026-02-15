{
  stdenv,
  fetchurl,
  libpq,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "teamspeak-server";
  version = "6.0.0";
  release = "beta8";

  src = fetchurl {
    url = "https://github.com/teamspeak/teamspeak6-server/releases/download/v${version}/${release}/teamspeak-server_linux_amd64-v${version}-${release}.tar.bz2";
    sha256 = "sha256-53d8dacdecd7146716f798aedb42ad73ae04d62857484e02890c778e48031117";
  };

  buildInputs = [
    stdenv.cc.cc
    libpq
  ];

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall

    # Install files.
    mkdir -p $out/lib/teamspeak
    mv * $out/lib/teamspeak/

    # Make symlinks to the binaries from bin.
    mkdir -p $out/bin/
    ln -s $out/lib/teamspeak/tsserver $out/bin/tsserver

    runHook postInstall
  '';

  # passthru.updateScript = writeScript "update-teampeak-server" ''
  #   #!/usr/bin/env nix-shell
  #   #!nix-shell -i bash -p common-updater-scripts curl gnugrep gnused jq pup

  #   set -eu -o pipefail

  #   version=$( \
  #     curl https://www.teamspeak.com/en/downloads/ \
  #       | pup "#server .linux .version json{}" \
  #       | jq -r ".[0].text"
  #   )

  #   versionOld=$(nix-instantiate --eval --strict -A "teamspeak_server.version")

  #   nixFile=pkgs/applications/networking/instant-messengers/teamspeak/server.nix

  #   update-source-version teamspeak_server "$version" --system=i686-linux

  #   sed -i -e "s/version = \"$version\";/version = $versionOld;/" "$nixFile"

  #   update-source-version teamspeak_server "$version" --system=x86_64-linux
  # '';
}
