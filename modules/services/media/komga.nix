{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.media.komga.enable = 
      lib.mkEnableOption "starts navidrome server";
  };

  config = lib.mkIf config.modules.services.media.komga.enable {
    
  };

}