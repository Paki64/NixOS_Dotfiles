{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.radarr.enable = 
      lib.mkEnableOption "starts radarr instance";
  };

  config = lib.mkIf config.modules.services.managers.radarr.enable {
    services.radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/radarr";
    };
  };

}