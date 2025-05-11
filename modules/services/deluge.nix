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
      user = "paki";
      group = "users";
      web = {
        enable = true;
        openFirewall = true;
      };
      config = {
        download_location = "/media/tmp/torrents/";
      };

    };
  };

}