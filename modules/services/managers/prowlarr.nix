{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.prowlarr.enable = 
      lib.mkEnableOption "starts prowlarr instance";
  };

  config = lib.mkIf config.modules.services.managers.prowlarr.enable {

    fileSystems."/var/lib/prowlarr" = {
      device = "/srv/nas/apps/prowlarr/config";
      options = [ "bind" ];
    };
    
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };

}