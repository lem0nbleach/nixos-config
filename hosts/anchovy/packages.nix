{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    neovim
    helix
    git
    dig
    ripgrep
    fd
    zsh
    unzip
    gzip
    foot
    yazi
    du-dust
    lm_sensors
    microfetch
    inputs.watt.packages.x86_64-linux.default
    bat
    zellij

    # GUI Apps
    firefox
    thunderbird
    obsidian
    vesktop
    libreoffice
    jellyfin-media-player
    bitwarden
    networkmanagerapplet
    prismlauncher
    activitywatch
    walker

    # Games
    prismlauncher

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
    inputs.quickshell.packages.x86_64-linux.default

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
