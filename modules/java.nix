{ lib, config, pkgs, ... }:

lib.mkIf config.anchovy {
  programs.java = {
    enable = true;
    package = pkgs.jdk25.override { enableJavaFX = true; };
  };
}
