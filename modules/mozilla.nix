{ lib, config, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  programs.firefox = {
    enable = true;
  };
  programs.thunderbird.enable = true;
}
