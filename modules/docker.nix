{ lib, config, pkgs, ... }:

lib.mkIf (config.croaker || config.marlin) {
  virtualisation.docker.enable = true;
}
