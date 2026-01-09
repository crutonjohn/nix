{ ... }:

{

  networking.nameservers = [
    "192.168.130.2"
    "192.168.130.3"
  ];

  networking.hostName = "perturabo";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      53
      69
      80
      443
    ];
    allowedUDPPorts = [
      53
      51830
      69
    ];
    # allowedUDPPorts = [ 51830 ]; # Clients and peers can use the same port, see listenport
  };

  networking.nat = {
    enable = true;
    externalInterface = "eno1";
    #    internalInterfaces = [ "wg0" ];
  };

  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIBlzCCAT2gAwIBAgIQUpQBQxZIqmRM7G2TXqG+6TAKBggqhkjOPQQDAjAqMSgw
      JgYDVQQDEx9oZXlqb2huLmZhbWlseSBJbnRlcm5hbCBSb290IENBMB4XDTI1MDMw
      MjA3MDE1MFoXDTM1MDIyODA3MDE1MFowKjEoMCYGA1UEAxMfaGV5am9obi5mYW1p
      bHkgSW50ZXJuYWwgUm9vdCBDQTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABJ3X
      mNYRYbLLKbGizAKZR3lYxPqnsnXmPotYokuY+vKJ8iuc7nFbSKLbl95EKR1gMY6u
      iO9zmxqsBMGff6kvb66jRTBDMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
      AQH/AgEBMB0GA1UdDgQWBBTlfB3jEuTS6VvJdlv7ZZxrOY4fnDAKBggqhkjOPQQD
      AgNIADBFAiEAr8RV0ixLb0c2zCQeJc1SfCRDC6rhT9xWey62p+qpmzYCIBXz63ba
      tBOU7WFC8guYTAO9xMu35MnTgYD7K0OLLGvG
      -----END CERTIFICATE-----
    ''
  ];

}
