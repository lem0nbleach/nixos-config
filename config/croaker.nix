{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/MangoHud/MangoHud.conf".source = ./dots/config/MangoHud/MangoHud.conf;
      ".config/rofi/config.rasi".source = ./dots/config/rofi/config.rasi;
      ".config/hypr/hyprland.conf".source = ./dots/config/hypr/hyprland.conf;
      ".config/hypr/hypridle.conf".source = ./dots/config/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ./dots/config/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ./dots/config/hypr/hyprpaper.conf;
      ".zshrc".source = ./dots/config/zsh/zshrc;
      ".config/foot/foot.ini".source = ./dots/config/foot/foot.ini;
      ".mozilla/firefox/user.js".source = ./dots/config/mozilla/firefox/user.js;
      ".config/gtk-3.0/settings.ini".source = ./dots/config/gtk-3.0/desktop.settings.ini;
      ".gtkrc-2.0".source = ./dots/config/gtkrc-2.0/desktop-gtkrc-2.0;
      "./local/share/icons/default/index.theme".source = ./dots/config/icons/default/desktop-index.theme;
      ".config/xsettingsd/xsettingsd.conf".source = ./dots/config/xsettingsd/xsettingsd.conf;
      ".config/helix/config.toml".source = ./dots/config/helix/config.toml;
      ".config/fish/config.fish".source = ./dots/config/fish/config.fish;
    };
  };
}
