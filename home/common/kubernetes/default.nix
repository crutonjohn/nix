{ pkgs, ... }:
{

  imports = [
  ];

  home = {
    packages = with pkgs; [
      jsonnet
      k9s
      krew
      kubectl
      kubernetes-helm
      kubecolor
      kubectx
      kustomize
      kustomize-sops
      sops
      minikube
      kns
      kubescape
      pkgs.unstable.fluxcd
    ];
  };

}
