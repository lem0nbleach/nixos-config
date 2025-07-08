{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./modules
      ../../config/anchovy.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "amdgpu.sg_display=0"
  ];

  networking.hostName = "anchovy";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "192.168.88.50" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  environment.sessionVariables = {
    TERM = "foot";
    BROWSER = "firefox";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    EDITOR = "hx";
    MOZ_ENABLE_WAYLAND=1;
    XCURSOR_THEME="Bibata-Modern-Ice";
    WATT_CONFIG="/home/lem0nbleach/.config/watt.toml";
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDriver = "amdgpu";
  };

  users.users.lem0nbleach = {
    isNormalUser = true;
    description = "Feiyang Wu";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Let lem0nbleach automatically be loggedin at boot up
  services.getty.autologinUser = "lem0nbleach";

  services.xserver.displayManager.lightdm.enable = false;
  programs.uwsm.enable = true;
  services.displayManager.defaultSession = "hyprland-uwsm";

  services.openssh.enable = true;
  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose"; # needed in order to use an exit node
  services.logind.lidSwitch = "suspend";

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/leds/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
  '';

  services.fprintd.enable = true;
  #security.pam.services.hyprlock = {};
  security.pam.services.hyprlock.fprintAuth = true;
  
  services.playerctld.enable = true;
  
  programs.fish.enable = true;

  programs.bash.interactiveShellInit = ''
  	if shopt -q login_shell; then
  		if uwsm check may-start; then
      	exec uwsm start hyprland-uwsm.desktop
  	  fi
  	else
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
  	fi
  '';

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  services.cloudflare-warp.enable = true;

  services.watt.enable = true;
  systemd.services.watt.environment = {
    WATT_CONFIG = "/home/lem0nbleach/.config/watt.toml";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.hypridle.enable = true;

  programs.hyprlock.enable = true;

  system.stateVersion = "24.11";
}
