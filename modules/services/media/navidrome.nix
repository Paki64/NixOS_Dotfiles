{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.media.navidrome.enable = 
      lib.mkEnableOption "starts navidrome server";
  };

  config = lib.mkIf config.modules.services.media.navidrome.enable {
    
  };

}