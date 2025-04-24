{ inputs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "lem0nbleach";
    homeDirectory = "/home/lem0nbleach";
    stateVersion = "24.05";
  };

  imports = [
    # Home manager
    inputs.schizofox.homeManagerModules.default
    ../../home-manager/kitty.nix
    ../../home-manager/zsh.nix
    ../../home-manager/window-manager/waybar.nix
    ../../home-manager/window-manager/hyprpaper.nix
    ../../home-manager/window-manager/hyprlock.nix
    ../../home-manager/window-manager/hypridle.nix
    ../../home-manager/obs.nix
    ../../home-manager/zoxide.nix
    ../../home-manager/schizofox.nix
  ];
}
