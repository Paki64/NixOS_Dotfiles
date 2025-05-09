{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.deluge.enable = 
      lib.mkEnableOption "starts deluge instance";
  };

  config = lib.mkIf config.modules.services.deluge.enable {
    services.deluge = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/deluge";
      web = {
        enable = true;
        openFirewall = true;
      };
      config = {
        download_location = "/data/torrents/";
      };

    };
  };

}