{ pkgs, ... }:

{
  programs.nixvim.enable = true;

  programs.nixvim = {

    defaultEditor = true;

    plugins = {
      lualine.enable = true;
      neo-tree.enable = true;
    };
  };
}
