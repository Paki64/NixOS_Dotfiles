{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.nextcloud.enable = 
      lib.mkEnableOption "enables nextcloud domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.nextcloud.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        nextcloud = {
          entryPoints = ["websecure"];
          rule = "Host(`cloud.pakisrv.com`)";
          service = "nextcloud";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        nextcloud.loadBalancer.servers = [
          {
            url = "http://server:9880";
          }
        ];
      };
    };

  };

}