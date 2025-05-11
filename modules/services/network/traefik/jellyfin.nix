{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.jellyfin.enable = 
      lib.mkEnableOption "enables jellyfin domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.jellyfin.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        jellyfin = {
          entryPoints = ["websecure"];
          rule = "Host(`tv.pakisrv.com`)";
          service = "jellyfin";
          tls.certResolver = "letsencrypt";
        };
        jellyseerr = {
          entryPoints = ["websecure"];
          rule = "Host(`requests.tv.pakisrv.com`)";
          service = "jellyseerr";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        jellyfin.loadBalancer.servers = [
          {
            url = "http://localhost:8096";
          }
        ];
        jellyseerr.loadBalancer.servers = [
          {
            url = "http://localhost:5055";
          }
        ];
      };
    };

  };

}