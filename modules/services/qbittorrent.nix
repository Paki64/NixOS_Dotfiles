{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.qbittorrent.enable = 
      lib.mkEnableOption "starts qbittorrent instance";
  };

  config = lib.mkIf config.modules.services.qbittorrent.enable {
    
  };

}