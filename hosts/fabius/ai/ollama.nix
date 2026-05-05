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
      "hf.co/mradermacher/deepseek-moe-16b-base-GGUF:Q6_K"
      "hf.co/bartowski/burtenshaw_GemmaCoder3-12B-GGUF:Q4_K_M"
      "hf.co/bartowski/DeepSeek-Coder-V2-Lite-Instruct-GGUF:Q6_K"
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
