{ lib, config, ... }:

lib.mkIf config.croaker = {
  services.flatpak.enable = true;
}
