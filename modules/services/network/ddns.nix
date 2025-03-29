{ config, lib, pkgs, ... }:

{
  
  options = {
    modules.services.network.ddns.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  # Config file in secrets/dots/ddclient.sops
  config = lib.mkIf config.modules.services.network.ddns.enable {

    systemd.tmpfiles.rules = [
    ];
    services.ddclient = {
      enable = true;
      configFile = "/etc/ddclient.conf";
    };

  };

}