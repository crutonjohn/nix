({ options, lib, ... }:
  lib.mkIf (options ? virtualisation.memorySize) {
    users.users.crutonjohn.password = "changeme";
  })
