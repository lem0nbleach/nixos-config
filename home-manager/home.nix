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
    inputs.anyrun.homeManagerModules.anyrun
    ./modules/kitty.nix
    ./modules/zsh.nix
    ./modules/window-manager/waybar.nix
    ./modules/theme.nix
    ./modules/git.nix
    ./modules/nixvim.nix
    ./modules/window-manager/hyprpaper.nix
    ./modules/window-manager/hyprlock.nix
    ./modules/window-manager/hypridle.nix
    ./modules/anyrun.nix
  ];
}
