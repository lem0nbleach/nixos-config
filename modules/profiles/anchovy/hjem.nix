{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/hypr/hyprland.conf".source = ../../config/hypr/anchovy-hyprland.conf;
      ".config/hypr/hypridle.conf".source = ../../config/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ../../config/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ../../config/hypr/hyprpaper.conf;
      ".mozilla/firefox/nh8kebxc.default/user.js".source = ../../config/mozilla/firefox/user.js;
      ".config/foot/foot.ini".source = ../../config/foot/foot.ini;
      ".config/fish/config.fish".source = ../../config/fish/config.fish;
      ".config/helix/config.toml".source = ../../config/helix/config.toml;
      ".config/gtk-4.0/settings.ini".source = ../../config/gtk-4.0/settings.ini;
      ".config/gtk-3.0/settings.ini".source = ../../config/gtk-3.0/settings.ini;
      ".gtkrc-2.0".source = ../../config/gtkrc-2.0/gtkrc-2.0;
      ".icons/default/index.theme".source = ../../config/icons/default/index.theme;
      ".config/xsettingsd/xsettingsd.conf".source = ../../config/xsettingsd/xsettingsd.conf;
      ".config/watt.toml".source = ../../config/watt/watt.toml;
    };
  };
}
