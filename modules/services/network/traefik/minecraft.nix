{ config, lib, pkgs, ... }:

{

  options = {
    modules.services.network.traefik.minecraft.enable = 
      lib.mkEnableOption "enables minecraft domain";
  };

  config = lib.mkIf config.modules.services.network.traefik.minecraft.enable {

    services.traefik.dynamicConfigOptions = {
      http.routers = {
        minecraft-pazzomc = {
          entryPoints = ["websecure"];
          rule = "Host(`pazzomc.pakisrv.com`)";
          service = "minecraft-pazzomc";
          tls.certResolver = "letsencrypt";
        };
      };
      http.services = {
        minecraft-pazzomc.loadBalancer.servers = [
          {
            url = "http://localhost:25565";
          }
        ];
      };
    };

  };

}