{ lib, config, pkgs, ... }:

lib.mkIf config.anchovy {
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.openjdk21.override { enableJavaFX = true; };
  };
}
