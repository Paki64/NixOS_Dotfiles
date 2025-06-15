{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.nextcloud.enable = 
      lib.mkEnableOption "enables nextcloud";
  };

  config = lib.mkIf config.modules.services.nextcloud.enable {
    
      services.nextcloud = {
        enable = true;
        hostName = "localhost"; 
        package = pkgs.nextcloud31;
        https = false;        
        config.adminpassFile = "/etc/nextcloud-admin-pass";
        config.dbtype = "sqlite";          
      };

      # Forziamo Nginx ad ascoltare solo su localhost:9000
      services.nginx = {
        enable = true;
        virtualHosts."localhost" = {
          listen = [{
            addr = "127.0.0.1";
            port = 9000;
            ssl = false;
          }];
        };
      };
    
    };

  }