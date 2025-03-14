{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "baremetalblog";
  version = "a2c9684225a3038430a97a9cb99f628c030f0da7";

  src = pkgs.fetchgit {
    url = "https://github.com/crutonjohn/baremetalblog.git";
    rev = version;
    sha256 = "sha256-/Gsmf9cXaOwGNQMiXEnoYIroSl8+WgRx2vkBl+3DdTo=";
    fetchSubmodules = true;
  };

  buildPhase = ''
    mkdir -p $out

    ${pkgs.hugo}/bin/hugo --minify --noBuildLock -t hello-friend -d $out/
  '';
}
