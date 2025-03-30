{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.sonarr.tv.enable = 
      lib.mkEnableOption "starts sonar instance for anime";
  };

  config = lib.mkIf config.modules.services.managers.sonarr.tv.enable {
    #kokokokok
  };

}