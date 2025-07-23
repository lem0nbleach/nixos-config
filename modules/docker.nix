{ lib, config, pkgs, ... }:

lib.mkIf config.marlin {
  virtualisation.docker.enable = true;
}
