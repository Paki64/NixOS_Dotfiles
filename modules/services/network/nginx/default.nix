{ config, pkgs, lib, input, ... }:

{
  imports =
  [ 
    #./jellyfin.nix        # Media server
  ];

  options = {
    modules.services.network.nginx.enable = 
      lib.mkEnableOption "enables Nginx reverse proxy";
  };

  config = lib.mkMerge [

      (lib.mkIf (config.modules.services.network.nginx.enable) { 
        services.nginx = {
        enable = true;
        };
      })
      
      (lib.mkIf (! config.modules.services.network.nginx.enable) {
        modules.services.network.nginx = {
          #jellyfin.enable = lib.mkForce false;
        };
      })
    
    ];


}