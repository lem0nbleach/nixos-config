{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/hypr/hyprland.conf".source = ./dots/hypr/anchovy-hyprland.conf;
      ".config/hypr/hypridle.conf".source = ./dots/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ./dots/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ./dots/hypr/hyprpaper.conf;
      ".config/foot/foot.ini".source = ./dots/foot/foot.ini;
      ".config/helix/config.toml".source = ./dots/helix/config.toml;
      ".config/gtk-4.0/settings.ini".source = ./dots/gtk-4.0/settings.ini;
      ".config/gtk-3.0/settings.ini".source = ./dots/gtk-3.0/settings.ini;
      ".gtkrc-2.0".source = ./dots/gtkrc-2.0/gtkrc-2.0;
      ".icons/default/index.theme".source = ./dots/icons/default/index.theme;
      ".config/xsettingsd/xsettingsd.conf".source = ./dots/xsettingsd/xsettingsd.conf;
      ".config/watt.toml".source = ./dots/watt/watt.toml;
      ".config/walker/config.toml".source = ./dots/walker/config.toml;
      ".config/walker/themes/theme.toml".source = ./dots/walker/themes/theme.toml;
    };
  };
}
