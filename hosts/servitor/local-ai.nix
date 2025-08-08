{ config, pkgs, inputs, lib, ... }:

{

  services.ollama = {
    enable = true;
    package = pkgs.ollama.override { config.cudaSupport = true; config.rocmSupport = false; };
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "deepseek-r1:1.5b"
      "deepseek-r1:14b"
      "qwen3:14b"
      "qwen3:1.7b"
      "gemma3:12b"
      "gemma3:4b"
    ];
    acceleration = "cuda";
    host = "0.0.0.0";
    port = 11434;
  };
  # nixpkgs.config.cudaSupport = true;
  # nixpkgs.config.nvidia.acceptLicense = true;
  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
  };

}
