{ pkgs, comfyui, ... }:

{

  services.comfyui = {
    enable = true;
    package = pkgs.comfyui-nvidia;
    host = "0.0.0.0";
    models = builtins.attrValues pkgs.nixified-ai.models;
    customNodes = with comfyui.pkgs; [ comfyui-gguf comfyui-impact-pack ];
  };

}
