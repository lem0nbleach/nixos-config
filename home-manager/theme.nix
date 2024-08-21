{ config, pkgs, ... }:

{
  # GTK Configs
  gtk.enable = true;

  gtk = {
    theme = {
      #package = pkgs.orchis-theme.override { tweaks = [ "black" ]; };
      #name = "Orchis-Purple";
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze-Dark";
    };
    #cursorTheme = {
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Modern-Ice";
    #};
    iconTheme = {
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze-Dark";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };

  # QT Configs
  qt.enable = true;

  qt = {
    platformTheme = "qtct";
    style = {
      package = pkgs.libsForQt5.breeze-qt5;
      name = "Breeze-Dark";
    };
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
