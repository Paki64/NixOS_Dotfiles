{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.komga.enable = 
      lib.mkEnableOption "enables komga domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.komga.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        komga = {
          entryPoints = ["websecure"];
          rule = "Host(`comics.pakisrv.com`)";
          service = "komga";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        komga.loadBalancer.servers = [
          {
            #url = "http://localhost:8096";
          }
        ];
      };
    };

  };

}