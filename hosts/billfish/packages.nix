{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    zsh
    neovim
    git
    kitty
    lsof
    dig
    iftop
    gcc
    foot
    fishPlugins.hydro
    zoxide
    ripgrep
    python3Minimal # for ansible to work on this machine
    rclone
    bitwarden-cli
  ];
}
