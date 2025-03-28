{ config, pkgs, lib, input, ... }:

{
  options = {
    modules.services.media.jellyfin.enable = 
      lib.mkEnableOption "enables jellyfin media server";
  };

  config = lib.mkIf config.modules.services.media.jellyfin.enable {
    
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user="paki";
    };

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];

  };

}