{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    neovim
    helix
    git
    dig
    ripgrep
    zoxide
    fd
    zsh
    thefuck
    unzip
    gzip
    foot
    yazi

    # GUI Apps
    firefox
    logseq
    obsidian
    vesktop
    du-dust
    libreoffice

    # Hyprland Tools
    rofi-wayland
    grim
    hyprcursor
    hyprpaper
    brightnessctl
    wl-clipboard
    slurp
    wluma
    mako

    # Rice
    nwg-look
    bibata-cursors
    candy-icons
    sweet

    # Media/Audio
    pavucontrol
    easyeffects
    pamixer
    
    # System Management
    powertop
    libnotify

    # Programming
    gcc
    lua
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  # For Logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
}
