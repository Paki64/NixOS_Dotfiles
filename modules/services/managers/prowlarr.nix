{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.prowlarr.enable = 
      lib.mkEnableOption "starts prowlarr instance";
  };

  config = lib.mkIf config.modules.services.managers.prowlarr.enable {
    #kokokokok
  };

}