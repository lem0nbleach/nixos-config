{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/MangoHud/MangoHud.conf".source = ../../config/MangoHud/MangoHud.conf;
      ".config/rofi/config.rasi".source = ../../config/rofi/config.rasi;
      ".config/hypr/hyprland.conf".source = ../../config/hypr/hyprland.conf;
      ".config/hypr/hypridle.conf".source = ../../config/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ../../config/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ../../config/hypr/hyprpaper.conf;
      ".zshrc".source = ../../config/zsh/zshrc;
      ".config/foot/foot.ini".source = ../../config/foot/foot.ini;
      ".mozilla/firefox/user.js".source = ../../config/mozilla/firefox/user.js;
      ".config/gtk-3.0/settings.ini".source = ../../config/gtk-3.0/desktop.settings.ini;
      ".gtkrc-2.0".source = ../../config/gtkrc-2.0/desktop-gtkrc-2.0;
      "./local/share/icons/default/index.theme".source = ../../config/icons/default/desktop-index.theme;
      ".config/xsettingsd/xsettingsd.conf".source = ../../config/xsettingsd/xsettingsd.conf;
      ".config/helix/config.toml".source = ../../config/helix/config.toml;
      ".config/fish/config.fish".source = ../../config/fish/config.fish;
    };
  };
}
