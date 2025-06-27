{ config, pkgs, pkgsStable, inputs, ... }:

{
  # Allowing unfree software
  nixpkgs.config.allowUnfree = true;

  _module.args.pkgsStable = import inputs.nixpkgs-stable {
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (config.nixpkgs) config;
  };
  
  environment.systemPackages = with pkgs; [
    neovim
    helix
    ripgrep
    gcc
    vscode
    wget
    kitty
    foot
    bash
    pipewire
    wireplumber
    ffmpeg-full
    yt-dlp
    vesktop
    hyprcursor
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    hyprpaper
    hyprutils
    home-manager
    git
    mangohud
    goverlay
    lm_sensors
    swaynotificationcenter
    fastfetch
    hyprland
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
    sbctl
    freecad
    blender
    chromium
    libreoffice-qt6-fresh
    egl-wayland
    logseq
    appimage-run
    xdotool
    xorg.xprop
    xxd
    xorg.xwininfo
    xorg.xrandr
    yad
    orca-slicer
    mumble
    brave
    tor-browser
    vlc
    v4l-utils
    screen
    element-desktop
    wine-wayland
    winbox4
    obsidian
    krita
    yadm
    rofi-wayland
    sqlitebrowser
    lutris
    nwg-look
    candy-icons
    bibata-cursors
    fluent-gtk-theme
    activitywatch
    rojo
    osu-lazer-bin
    bat
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
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    font-awesome
    jetbrains-mono
    texlivePackages.alfaslabone
    powerline-fonts
  ];
}
