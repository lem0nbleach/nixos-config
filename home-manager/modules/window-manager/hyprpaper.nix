{ ... }:

{
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = {
    ipc = true;
    splash = true;

    preload = ./wallpaper/EYE.jpg
    wallpaper = ./wallpaper/EYE.jpg
  };
}
