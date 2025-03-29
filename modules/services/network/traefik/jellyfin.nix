{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.jellyfin.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  config = lib.mkIf config.modules.services.network.traefik.jellyfin.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        jellyfin = {
          entryPoints = ["websecure"];
          rule = "Host(`jellyfin.pakisrv.com`)";
          service = "jellyfin";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        jellyfin.loadBalancer.servers = [
          {
            url = "http://localhost:8096";
          }
        ];
      };
    };

  };

}