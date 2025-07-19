{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = [
    pkgs.mangohud
  ];
}
