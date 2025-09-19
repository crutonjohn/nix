{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "baremetalblog";
  version = "d5ca958bdd24ca46ed7a30862dbd61b14797c481";

  src = pkgs.fetchgit {
    url = "https://github.com/crutonjohn/baremetalblog.git";
    rev = version;
    sha256 = "sha256-tKV0NcoKssR7c6z5TqhE7NuKsigk6NkkZRfXSEM7zxw=";
    fetchSubmodules = true;
  };

  buildPhase = ''
    mkdir -p $out

    ${pkgs.hugopin.hugo}/bin/hugo --minify --noBuildLock -t hello-friend -d $out/
  '';
}
