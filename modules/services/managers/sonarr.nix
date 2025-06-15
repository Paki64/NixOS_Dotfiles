{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.sonarr.enable = 
      lib.mkEnableOption "starts sonarr instance";
  };

  config = lib.mkIf config.modules.services.managers.sonarr.enable {

    fileSystems."/var/lib/sonarr" = {
      device = "/srv/nas/apps/sonarr/config";
      options = [ "bind" ];
    };

    services.sonarr = {
      enable = true;
      openFirewall = true;
      user="paki";
      group="users";
    };
  };

}