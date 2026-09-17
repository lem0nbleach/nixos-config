{
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/watt.nix"
  ];

  config = lib.mkIf config.anchovy {
    services.watt.enable = true;

    environment.sessionVariables = {
      WATT_CONFIG = "/home/lem0nbleach/.config/watt.toml";
    };
  };
}
