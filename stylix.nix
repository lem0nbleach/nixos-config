{ pkgs, ... }:

{
  stylix.enable = true;

  stylix.polarity = "dark";
  stylix.image = ./home-manager/window-manager/wallpaper/EYE.jpg;
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
