{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  config = lib.mkIf config.modules.services.network.traefik.enable {

    services.traefik = {
      enable = true;

      staticConfigOptions = {
        
        entryPoints = {
          web = {
            address = ":80";
            asDefault = true;
            http.redirections.entrypoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure = {
            address = ":443";
            asDefault = true;
            http.tls.certResolver = "letsencrypt";
          };
        };

        log = {
          level = "INFO";
          filePath = "${config.services.traefik.dataDir}/traefik.log";
          format = "json";
        };

        certificatesResolvers.letsencrypt.acme = {
          email = "pasqualecriscuolo2010@gmail.com";
          storage = "${config.services.traefik.dataDir}/acme.json";
          httpChallenge.entryPoint = "web";
        };

        api.dashboard = true;
        # Access the Traefik dashboard on <Traefik IP>:8080 of your server
        api.insecure = true;
      };

      dynamicConfigOptions = {
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
  };

}