{ config, lib, pkgs, ... }:

{

  imports =
    [ 
      ./azuracast.nix   # AzuraCast Web Radio
      ./calibre.nix     # Calibre Book Server 
      ./jellyfin.nix    # Jellyfin Media Server
      ./komga.nix       # Komga Comics Server
      ./navidrome.nix   # Navidrome Music Server
    ];

  options = {
    modules.services.network.traefik.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  config = lib.mkMerge [
    
    (lib.mkIf (config.modules.services.network.traefik.enable) {
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

      };
    
    })

    (lib.mkIf (! config.modules.services.network.traefik.enable) {
      modules.services.network.traefik = {
        azuracast.enable = lib.mkForce false;
        calibre.enable = lib.mkForce false;
        jellyfin.enable = lib.mkForce false;
        komga.enable = lib.mkForce false;
        navidrome.enable = lib.mkForce false;
      };
    })

  ];

}