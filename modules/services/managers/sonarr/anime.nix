{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.sonarr.anime.enable = 
      lib.mkEnableOption "starts sonar instance for anime";
  };

  config = lib.mkIf config.modules.services.managers.sonarr.anime.enable {
    #kokokokok
  };

}