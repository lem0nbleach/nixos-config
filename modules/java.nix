{
  lib,
  config,
  pkgs,
  ...
}:

lib.mkIf (config.anchovy || config.croaker) {
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.openjdk21.override { enableJavaFX = true; };
  };
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];
}
