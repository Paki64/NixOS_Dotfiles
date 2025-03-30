{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.homepage.enable = 
      lib.mkEnableOption "enables homepage dashboard";
  };

  config = lib.mkIf config.modules.services.homepage.enable {
    
  };

}