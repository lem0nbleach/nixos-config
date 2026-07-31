{ config, lib, ... }:

lib.mkIf config.anchovy {
  services.playerctld.enable = true;
}
