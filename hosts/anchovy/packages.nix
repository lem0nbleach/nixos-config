{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    neovim
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
    ansible

    # GUI Apps
    thunderbird
    obsidian
    vesktop
    libreoffice
    jellyfin-media-player
    bitwarden
    networkmanagerapplet
    prismlauncher
    todoist-electron

    # Games
    prismlauncher

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
