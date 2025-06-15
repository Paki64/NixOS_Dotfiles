{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.deluge.enable = 
      lib.mkEnableOption "starts deluge instance";
  };

  config = lib.mkIf config.modules.services.deluge.enable {
    
    fileSystems."/var/lib/deluge/.config/deluge" = {
      device = "/srv/nas/apps/deluge/config";
      options = [ "bind" ];
    };
    
    services.deluge = {
      enable = true;
      openFirewall = true;
      user = "paki";
      group = "users";
      web = {
        enable = true;
        openFirewall = true;
      };
      config = {
        download_location = "/srv/nas/tmp/torrents/";
      };

    };
  };

}