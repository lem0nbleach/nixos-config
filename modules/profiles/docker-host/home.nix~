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
    inputs.nixvim.homeManagerModules.nixvim
    ../../home-manager/zsh.nix
    ../../home-manager/zoxide.nix
    ../../home-manager/git.nix
    ../../home-manager/nixvim.nix
  ];
}
