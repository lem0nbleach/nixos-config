{ pkgs, inputs, ... }:
let
  wattPKG = inputs.watt.packages.x86_64-linux.default;
  stashPKG = inputs.stash.packages.x86_64-linux.default;
  narniaPKG = inputs.narnia.packages.x86_64-linux.default;

in
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
    wattPKG
    bat
    zellij
    ansible
    stashPKG
    typst
    nix-tree
    narniaPKG
    openscad-lsp

    # GUI Apps
    thunderbird
    obsidian
    vesktop
    libreoffice
    bitwarden
    networkmanagerapplet
    prismlauncher
    todoist-electron
    qalculate-qt
    kicad
    openscad-unstable

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
    dejavu_fonts
    liberation_ttf
  ];

  # For Logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
}
