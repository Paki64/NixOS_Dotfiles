{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.radarr.enable = 
      lib.mkEnableOption "starts radarr instance";
  };

  config = lib.mkIf config.modules.services.managers.radarr.enable {

    fileSystems."/var/lib/radarr" = {
      device = "/srv/nas/apps/radarr/config";
      options = [ "bind" ];
    };

    services.radarr = {
      enable = true;
      openFirewall = true;
      user="paki";
      group="users";
    };
  };

}