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
    ../../home-manager/kitty.nix
    ../../home-manager/window-manager/waybar.nix
    ../../home-manager/obs.nix
    ../../home-manager/zoxide.nix
  ];
}
