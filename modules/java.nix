{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.openjdk21.override { enableJavaFX = true; };
  };
}
