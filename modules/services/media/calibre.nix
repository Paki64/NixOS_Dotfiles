{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.media.calibre.enable = 
      lib.mkEnableOption "starts calibre server";
  };

  config = lib.mkIf config.modules.services.media.calibre.enable {
    #kokokokok
  };

}