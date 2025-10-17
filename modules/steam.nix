{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  # Gamescope fix from https://wiki.nixos.org/wiki/Steam#Gamescope_fails_to_launch_when_used_within_Steam
  programs.steam.package = pkgs.steam.override {
    extraPkgs = pkgs': with pkgs'; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib # Provides libstdc++.so.6
      libkrb5
      keyutils
      # Add other libraries as needed
    ];
  };

  environment.systemPackages = [
    pkgs.mangohud
    # steamtinkerlaunch does not have a steamcompattool output so it has to be installed imperatively
    # instead of being able to be added using extracompatpackages
    pkgs.steamtinkerlaunch
  ];
}
