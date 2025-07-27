{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = [
      pkgs.fcitx5-gtk
      pkgs.fcitx5-chinese-addons
    ];
  };
}
