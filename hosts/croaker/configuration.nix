{ config, pkgs, pkgsStable, inputs, lib, ... }:

{
  imports =
    [
      ./modules
      ../../modules/profiles/croaker
      ../../config/croaker.nix
    ];

  networking.hostName = "croaker";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Input method for Chinese
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
    ];
  };

  /*# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, us";
    variant = "workman, qwerty";
    options = "grp:alt_shift_toggle";
  };*/

  users.users.lem0nbleach = {
    isNormalUser = true;
    description = "Feiyang Wu";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable portals between applications
  xdg.portal.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  system.stateVersion = "24.05";

  services.getty.autologinUser = "lem0nbleach";

  services.xserver.displayManager.lightdm.enable = false;
  # for some reason lightdm is the display manager that is enabled by default
  # looks like enabling xserver using the module would also enable lightdm
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.hypridle.enable = true;

  programs.hyprlock.enable = true;

  environment.sessionVariables = {
    TERM = "foot";
    BROWSER = "firefox";
    TERMINAL = "foot";
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    EDITOR = "nvim";
    PROTON_VERSION = "GE-Proton9-18";
  };

/*
  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
    };
    graphics = {
      #enable = true;
      enable32Bit = true;
    };
  };
*/

  hardware = {
    graphics = {
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
  programs.gamemode.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  services.tor = {
    enable = true;
  };

  services.xserver.wacom.enable = true;

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

  programs.fish.enable = true;

  services.flatpak.enable = true;
}
