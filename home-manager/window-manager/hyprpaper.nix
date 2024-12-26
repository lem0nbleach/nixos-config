{ lib, ... }:

{
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = {
    ipc = true;
    splash = true;

    preload = lib.mkForce "/home/lem0nbleach/.dotfiles/home-manager/window-manager/wallpaper/EYE.jpg";
    wallpaper = lib.mkForce ", /home/lem0nbleach/.dotfiles/home-manager/window-manager/wallpaper/EYE.jpg";
  };
}
