{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.flaresolverr.enable = 
      lib.mkEnableOption "starts flaresolverr instance";
  };

  config = lib.mkIf config.modules.services.managers.flaresolverr.enable {
    #kokokokok
  };

}