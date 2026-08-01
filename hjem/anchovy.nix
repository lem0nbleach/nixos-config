{ lib, ... }:

{
  hjem = {
    clobberByDefault = true;
    users.lem0nbleach = {
      files = {
        ".config/git/config".source = ./dots/git/config;
        ".config/sway/config".source = ./dots/sway/anchovy.conf;
        ".config/foot/foot.ini".source = ./dots/foot/foot.ini;
        ".config/helix/config.toml".source = ./dots/helix/config.toml;
        ".config/helix/languages.toml".source = ./dots/helix/languages.toml;
        ".config/gtk-4.0/settings.ini".source = ./dots/gtk-4.0/settings.ini;
        ".config/gtk-3.0/settings.ini".source = ./dots/gtk-3.0/settings.ini;
        ".gtkrc-2.0".source = ./dots/gtkrc-2.0/gtkrc-2.0;
        ".icons/default/index.theme".source = ./dots/icons/default/index.theme;
        ".config/xsettingsd/xsettingsd.conf".source = ./dots/xsettingsd/xsettingsd.conf;
        ".config/fish/config.fish".source = ./dots/fish/config.fish;
        ".config/watt.toml".source = ./dots/watt/watt.toml;
        ".config/zellij/config.kdl".source = ./dots/zellij/config.kdl;
        ".config/fish/config.fish".source = ./dots/fish/config.fish;
      };
    };
  };
}
