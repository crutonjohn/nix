(
  { options, lib, ... }:
  lib.mkIf (options ? virtualisation.memorySize) {
    users.users.kat.password = "changeme";
  }
)
