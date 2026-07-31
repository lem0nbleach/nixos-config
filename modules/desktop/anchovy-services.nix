{ config, lib, ... }:

lib.mkIf config.anchovy {
  services.playerctld.enable = true;
  services.elephant.enable = true;
}
