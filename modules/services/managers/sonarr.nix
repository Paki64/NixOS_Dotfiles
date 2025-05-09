{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.sonarr.enable = 
      lib.mkEnableOption "starts sonarr instance";
  };

  config = lib.mkIf config.modules.services.managers.sonarr.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/sonarr";
    };
  };

}