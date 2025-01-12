{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "lem0nbleach";
      };
      default_session = initial_session;
    };
  };
}
