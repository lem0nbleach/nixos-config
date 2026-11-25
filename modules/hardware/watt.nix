{
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.watt.nixosModules.default ];

  # watt's NixOS module generates its config from services.watt.settings.
  # Previously only WATT_CONFIG was exported to user sessions, so the daemon
  # ran with an empty generated config and applied no rules at all.
  services.watt = lib.mkIf config.anchovy {
    enable = true;
    settings = lib.importTOML ./watt.toml;
  };
}
