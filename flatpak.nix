{ pkgs, inputs, ...}:

{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "com.ultimaker.cura"
  ];
}
