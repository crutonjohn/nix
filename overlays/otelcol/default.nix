{
  buildGoModule,
  fetchFromGitHub,
  stdenv,
  lib,
  systemdMinimal,
  withSystemd ? false,
}:

buildGoModule rec {
  pname = "opentelemetry-collector-contrib";
  version = "0.120.0";

  src = fetchFromGitHub {
    owner = "open-telemetry";
    repo = "opentelemetry-collector-contrib";
    rev = "v${version}";
    hash = "sha256-EWmSN9PfbNxEyRCz07pVQa1b0eQ9eq7LsrF2euWmz7E=";
  };

  # proxy vendor to avoid hash mismatches between linux and macOS
  proxyVendor = true;
  vendorHash = null;

  # there is a nested go.mod
  sourceRoot = "${src.name}/cmd/otelcontribcol";

  # upstream strongly recommends disabling CGO
  # additionally dependencies have had issues when GCO was enabled that weren't caught upstream
  # https://github.com/open-telemetry/opentelemetry-collector/blob/main/CONTRIBUTING.md#using-cgo
  CGO_ENABLED = 0;

  # journalctl is required in-$PATH for the journald receiver tests.
  nativeCheckInputs = lib.optionals stdenv.hostPlatform.isLinux [ systemdMinimal ];

  # We don't inject the package into propagatedBuildInputs unless
  # asked to avoid hard-requiring a large package. For the journald
  # receiver to work, journalctl will need to be available in-$PATH,
  # so expose this as an option for those who want more control over
  # it instead of trusting the global $PATH.
  propagatedBuildInputs = lib.optionals withSystemd [ systemdMinimal ];

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
    "-X github.com/open-telemetry/opentelemetry-collector-contrib/internal/version.Version=v${version}"
  ];

}
