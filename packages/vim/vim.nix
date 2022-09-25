{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ale
      fzf-vim
      coc-git
      vim-fugitive
      vim-nerdtree-syntax-highlight
      vim-airline
      vim-easy-align
      vim-git
      nerdtree
      nerdcommenter
      lightline-vim
      vim-floaterm
    ];
  };
}
