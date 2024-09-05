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
    pkgsStable.logseq
    lemurs
    hyprpicker
    kmonad
    inputs.zen-browser.packages."${system}".specific
    sbctl
    obs-studio
    freecad
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
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
    texlivePackages.alfaslabone
  ];
}
