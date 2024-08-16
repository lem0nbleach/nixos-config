{ inputs, ... }:

{
  programs.home-manager.enable = true;
  home = {
    username = "lem0nbleach";
    homeDirectory = "/home/lem0nbleach";
    stateVersion = "24.05";
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/kitty.nix
    ./modules/zsh.nix
    ./modules/window-manager/waybar.nix
    ./modules/theme.nix
    ./modules/git.nix
    ./modules/nixvim.nix
    ./modules/window-manager/hyprpaper.nix
  ];
}
