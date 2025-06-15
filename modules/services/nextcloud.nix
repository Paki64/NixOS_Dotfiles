{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.nextcloud.enable = 
      lib.mkEnableOption "enables nextcloud";
  };

  config = lib.mkIf config.modules.services.nextcloud.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "localhost";
      #config.adminpassFile = "/etc/nextcloud-admin-pass";
      config.dbtype = "sqlite";
    };
  };

}