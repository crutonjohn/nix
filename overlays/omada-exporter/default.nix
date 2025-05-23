{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "omada-exporter";
  version = "v0.13.1";

  src = fetchFromGitHub {
    owner = "charlie-haley";
    repo = "omada_exporter";
    rev = version;
    sha256 = "sha256-zJBwGWY9/DqcK4Oew8DbJ8R/hssVSCIhtqT5MSt4/00=";
  };

  vendorHash = "sha256-m4zc2/BVvhCuk+WWxBu283qF/kdeRZdYGv3N3zIslgU=";

  meta = with lib; {
    description = "Exporter for metrics from TP-Link Omada SDN Controller";
    homepage = "https://github.com/charlie-haley/omada_exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ crutonjohn ];
  };
}
