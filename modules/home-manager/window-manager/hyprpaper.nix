{ lib, ... }:

{
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = {
    ipc = true;
    splash = false;

    preload = lib.mkForce "./window-manager/wallpaper/EYE.jpg";
    wallpaper = lib.mkForce ",./wallpaper/EYE.jpg";
  };
}
