{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  programs.winbox = {
    enable = true;
    package = pkgs.winbox4;
    openFirewall = true;
  };
}
