{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.syncthing.enable = 
      lib.mkEnableOption "starts syncthing instance";
  };

  config = lib.mkIf config.modules.services.syncthing.enable {
    
  };

}