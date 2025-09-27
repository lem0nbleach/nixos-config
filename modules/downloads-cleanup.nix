{ lib, config, pkgs, ... }:

let
  downloads-cleanup = pkgs.writeShellApplication {
    name = "downloads-cleanup";
    runtimeInputs = [ pkgs.findutils ];
    text = ''
      find "$HOME/Downloads" -maxdepth 1 -mtime +14 -exec rm -rf {} \;
    '';
  };

in
lib.mkIf (config.croaker || config.anchovy) {
  systemd.user.services.downloads-cleanup = {
    description = "Deletes files in downloads that are older than 2 weeks on startup";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe downloads-cleanup;
    };
  };
}
