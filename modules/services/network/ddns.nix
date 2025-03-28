{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.network.ddns.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  # Config file in secrets/dots/ddns.sops

  config = lib.mkIf config.modules.services.network.ddns.enable {

    systemd.services.ddns = {
      description = "Dynamic DNS updater using ddns-updater";
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = true;
      serviceConfig = {
        WorkingDirectory = "/etc/ddns";
        ExecStart = "${pkgs.ddns-updater}/bin/ddns-updater";
        Restart = "on-failure";
      };
    };

  };

}