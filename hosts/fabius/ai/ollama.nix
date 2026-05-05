{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama.override {
      config.cudaSupport = false;
      config.rocmSupport = true;
    };
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "qwen3.5:9b"
      "qwen3.5:2b"
      "gemma3:4b"
      "hf.co/bartowski/burtenshaw_GemmaCoder3-12B-GGUF:Q4_K_M"
      "qwen2.5-coder:7b"
      "codegemma:7b"
    ];
    acceleration = "rocm";
    host = "0.0.0.0";
    port = 11434;
  };
  # nixpkgs.config.cudaSupport = true;
  # nixpkgs.config.nvidia.acceptLicense = true;
  services.open-webui = {
    enable = false;
    host = "0.0.0.0";
  };

}
