{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.navidrome.enable = 
      lib.mkEnableOption "enables navidrome domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.navidrome.enable {

    services.navidrome.dynamicConfigOptions = {
      http.routers = {
        navidrome = {
          entryPoints = ["websecure"];
          rule = "Host(`music.pakisrv.com`)";
          service = "navidrome";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        navidrome.loadBalancer.servers = [
          {
            #url = "http://localhost:8096";
          }
        ];
      };
    };

  };

}