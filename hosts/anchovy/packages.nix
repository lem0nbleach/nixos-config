{ pkgs, inputs, ... }:
let
  wattPKG = inputs.watt.packages.x86_64-linux.default;
  stashPKG = inputs.stash.packages.x86_64-linux.default;
  narniaPKG = inputs.narnia.packages.x86_64-linux.default;
  librepodsPKG = inputs.librepods.packages.x86_64-linux.default;

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
    dust
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
    marksman
    bitwarden-cli
    talosctl
    kubectl

    # GUI Apps
    thunderbird
    obsidian
    vesktop
    libreoffice
    networkmanagerapplet
    prismlauncher
    qalculate-qt
    kicad
    openscad-unstable
    todoist-electron
    todoist
    librepodsPKG

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
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    font-awesome
    jetbrains-mono
    texlivePackages.alfaslabone
    dejavu_fonts
    liberation_ttf
  ];

  # For Logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
}
