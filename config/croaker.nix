{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/MangoHud/MangoHud.conf".source = ./dots/MangoHud/MangoHud.conf;
      ".config/hypr/hyprland.conf".source = ./dots/hypr/hyprland.conf;
      ".config/hypr/hypridle.conf".source = ./dots/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ./dots/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ./dots/hypr/hyprpaper.conf;
      ".config/hypr/hyprsunset.conf".source = ./dots/hypr/hyprsunset.conf;
      ".zshrc".source = ./dots/zsh/zshrc;
      ".config/foot/foot.ini".source = ./dots/foot/foot.ini;
      ".config/gtk-3.0/settings.ini".source = ./dots/gtk-3.0/desktop.settings.ini;
      ".gtkrc-2.0".source = ./dots/gtkrc-2.0/desktop-gtkrc-2.0;
      "./local/share/icons/default/index.theme".source = ./dots/icons/default/desktop-index.theme;
      ".config/xsettingsd/xsettingsd.conf".source = ./dots/xsettingsd/xsettingsd.conf;
      ".config/helix/config.toml".source = ./dots/helix/config.toml;
      ".config/fish/config.fish".source = ./dots/fish/config.fish;
    };
  };
}
