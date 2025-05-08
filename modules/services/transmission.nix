{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.transmission.enable = 
      lib.mkEnableOption "starts transmission instance";
  };

  config = lib.mkIf config.modules.services.transmission.enable {
    
  };

}