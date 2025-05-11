{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.azuracast.enable = 
      lib.mkEnableOption "enables azuracast domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.azuracast.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        azuracast = {
          entryPoints = ["websecure"];
          rule = "Host(`radio.pakisrv.com`)";
          service = "azuracast";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        azuracast.loadBalancer.servers = [
          {
            url = "http://localhost:880";
          }
        ];
      };
    };

  };

}