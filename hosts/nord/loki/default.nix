{ name, nodes, pkgs, lib, inputs, ... }: {

services.loki = {
  enable = true;
  configFile = ./config.yaml;
};

}
