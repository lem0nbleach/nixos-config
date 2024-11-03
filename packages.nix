{ config, pkgs, pkgsStable, inputs, ... }:

{
  # Allowing unfree software
  nixpkgs.config.allowUnfree = true;

  _module.args.pkgsStable = import inputs.nixpkgs-stable {
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (config.nixpkgs) config;
  };
  
  environment.systemPackages = with pkgs; [
    wget
    kitty
    bash
    pipewire
    wireplumber
    vesktop
    hyprcursor
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    hyprpaper
    xfce.thunar
    home-manager
    firefox
    git
    mangohud
    protonup
    swaynotificationcenter
    fastfetch
    zsh
    oh-my-zsh
    waybar
    pavucontrol
    htop
    yazi
    zoxide
    fzf
    zsh-autocomplete
    unzip
    prismlauncher
    jdk
    grim
    slurp
    wl-clipboard
    brightnessctl
    lemurs
    hyprpicker
    kmonad
    inputs.zen-browser.packages."${system}".specific
    sbctl
    obs-studio
    freecad
    blender
    kicad
    chromium
    libreoffice-qt6-fresh
    egl-wayland
    logseq
    appimage-run
    prusa-slicer
    ruby
    postgresql
    super-slicer-beta
    protonup-qt
    xdotool
    xorg.xprop
    xxd
    xorg.xwininfo
    yad
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerdfonts
    font-awesome
    jetbrains-mono
    texlivePackages.alfaslabone
  ];
}
