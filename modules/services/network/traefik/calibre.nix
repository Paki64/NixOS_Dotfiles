{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.calibre.enable = 
      lib.mkEnableOption "enables calibre domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.calibre.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        calibre = {
          entryPoints = ["websecure"];
          rule = "Host(`books.pakisrv.com`)";
          service = "calibre";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        calibre.loadBalancer.servers = [
          {
            #url = "http://localhost:8096";
          }
        ];
      };
    };

  };

}