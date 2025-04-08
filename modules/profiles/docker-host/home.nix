{ inputs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "lem0nbleach";
    homeDirectory = "/home/lem0nbleach";
    stateVersion = "24.11";
  };

  imports = [
    # Home manager
    inputs.nvf.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    ../../home-manager/zsh.nix
    ../../home-manager/zoxide.nix
    ../../home-manager/nvf.nix
  ];
}
