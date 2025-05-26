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
    bibata-cursors
    candy-icons

    # Audio
    pavucontrol
    easyeffects
    
    # System Management
    powertop
    libnotify

    # Programming
    gcc
    lua
  ];

  # For Logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
}
