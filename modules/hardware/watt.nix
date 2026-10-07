{
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.watt.nixosModules.default ];

  services.watt.enable = lib.mkIf config.anchovy true;

  environment.sessionVariables = lib.mkIf config.anchovy {
    WATT_CONFIG = "/home/lem0nbleach/.config/watt.toml";
  };
}
